<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Symfony\Component\Process\Exception\ProcessTimedOutException;
use Symfony\Component\Process\Process;

class RWHILEController extends Controller
{
    /**
     * Sample ドロップダウンの番号 → [プログラム, 入力データ]。
     * Laravel 6 版の if 連鎖と同じ対応を保つ（未知の番号は reverse に落ちる）。
     *
     * @var array<int, array{0: string, 1: string}>
     */
    private const SAMPLES = [
        0 => ['reverse.rwhile', 'list123.val'],
        1 => ['swap.rwhile', 'list123.val'],
        2 => ['piorder.rwhile', 'piorder_input05.val'],
        3 => ['ri.rwhile', 'id_and_nil.p_val'],
        4 => ['ri.rwhile', 'reverse_and_list123.p_val'],
        5 => ['ri.rwhile', 'piorder.p_val'],
        6 => ['ri.rwhile', 'ri_ri_reverse_list123.p_val'],
        7 => ['infinite.rwhile', 'list123.val'],
        8 => ['enumeration.rwhile', 'nil.val'],
    ];

    public function index(): View
    {
        return view('index', ['program' => '', 'data' => '']);
    }

    public function sample(int $sample): View
    {
        [$programFile, $dataFile] = self::SAMPLES[$sample] ?? self::SAMPLES[0];

        return view('index', [
            'program' => $this->readExample($programFile),
            'data' => $this->readExample($dataFile),
        ]);
    }

    public function execute(Request $request): JsonResponse
    {
        $max = config('rwhile.max_input_bytes');

        // ConvertEmptyStringsToNull ミドルウェアが空文字を null にするので、
        // 「空のプログラム」と「プログラムの欄が無い」を present と nullable で分ける。
        $validated = $request->validate([
            'prog' => ['present', 'nullable', 'string', "max:$max"],
            'data' => ['present', 'nullable', 'string', "max:$max"],
            'invert' => ['nullable', 'boolean'],
            'p2d' => ['nullable', 'boolean'],
            'exp' => ['nullable', 'boolean'],
        ]);

        $riBin = config('rwhile.ri_bin');

        if (! is_executable($riBin)) {
            // src/ を make install していないとここに来る。利用者に処理系の
            // 所在を漏らさず、運用者にはログで知らせる。
            report(new \RuntimeException("R-WHILE interpreter not found or not executable: $riBin"));

            return response()->json(['output' => "The interpreter is not available on this server.\n"], 503);
        }

        $invert = (bool) ($validated['invert'] ?? false);
        $p2d = (bool) ($validated['p2d'] ?? false);
        $exp = (bool) ($validated['exp'] ?? false);

        $program = $this->convertEol($validated['prog'] ?? '');
        $data = $this->convertEol($validated['data'] ?? '');

        $programPath = $this->writeScratchFile('prog', $program);
        // 変換系のオプション（反転・program2data・マクロ展開）は入力データを取らない。
        $dataPath = ($invert || $p2d || $exp) ? null : $this->writeScratchFile('data', $data);

        // 引数はすべてこちらで組み立てた文字列で、シェルは介さない。
        $command = [$riBin];
        if ($invert) {
            $command[] = '-inverse';
        }
        if ($p2d) {
            $command[] = '-p2d';
        }
        if ($exp) {
            $command[] = '-exp';
        }
        $command[] = $programPath;
        if ($dataPath !== null) {
            $command[] = $dataPath;
        }

        // ri は標準入力を読まない（src/Main.ml は引数のファイルだけを開く）。
        // Laravel 6 版はプログラム本文を標準入力にも書いており、64KB を超えると
        // パイプが埋まって詰まる状態だった。入力は渡さない。
        $timeout = config('rwhile.timeout');
        $process = new Process($command, sys_get_temp_dir(), [], null, $timeout);

        try {
            $process->run();
            $output = $process->getOutput();

            // 構文エラーのとき ri は標準出力に何も出さず、標準エラーへ
            // "Fatal error: exception BNFC_Util.Parse_error(_, _)" を出して終わる。
            // 黙って空を返すと利用者には何が起きたか分からない。
            if ($output === '' && ! $process->isSuccessful()) {
                $output = trim($process->getErrorOutput());
                $output = $output === '' ? 'Execution failed.' : $output;
                $output .= "\n";
            }
        } catch (ProcessTimedOutException) {
            $output = "Execution timed out!\n";
        } finally {
            @unlink($programPath);
            if ($dataPath !== null) {
                @unlink($dataPath);
            }
        }

        // 念のため、サーバ側の絶対パスが応答に混ざらないようにする。
        $output = str_replace([storage_path(), base_path()], '', $output);

        return response()->json(['output' => $output]);
    }

    private function readExample(string $filename): string
    {
        $path = public_path('examples/'.$filename);

        return is_file($path) ? (string) file_get_contents($path) : '';
    }

    /**
     * 利用者の投稿を、Web から配信されない場所に一時ファイルとして置く。
     * Laravel 6 版は public/programs/ と public/data/ に sha1 名で置いており、
     * 内容を知る者は URL を再現でき、かつ無期限に溜まり続けた。
     */
    private function writeScratchFile(string $prefix, string $contents): string
    {
        $dir = storage_path('app/rwhile');
        if (! is_dir($dir)) {
            mkdir($dir, 0o700, true);
        }

        $path = tempnam($dir, $prefix.'-');
        file_put_contents($path, $contents);

        return $path;
    }

    private function convertEol(string $string, string $to = "\n"): string
    {
        return strtr($string, ["\r\n" => $to, "\r" => $to, "\n" => $to]);
    }
}
