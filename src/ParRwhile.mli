type token =
  | TOK_cons
  | TOK_do
  | TOK_else
  | TOK_fi
  | TOK_from
  | TOK_hd
  | TOK_if
  | TOK_loop
  | TOK_macro
  | TOK_nil
  | TOK_read
  | TOK_show
  | TOK_then
  | TOK_tl
  | TOK_until
  | TOK_write
  | SYMB1
  | SYMB2
  | SYMB3
  | SYMB4
  | SYMB5
  | SYMB6
  | SYMB7
  | SYMB8
  | TOK_EOF
  | TOK_Ident of (string)
  | TOK_String of (string)
  | TOK_Integer of (int)
  | TOK_Double of (float)
  | TOK_Char of (char)
  | TOK_RIdent of (string)
  | TOK_Atom of (string)

val pProgram :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> AbsRwhile.program
val pValT :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> AbsRwhile.valT
