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

open Parsing;;
let _ = parse_error;;
# 3 "ParRwhile.mly"
open AbsRwhile
open Lexing


# 43 "ParRwhile.ml"
let yytransl_const = [|
  257 (* TOK_cons *);
  258 (* TOK_do *);
  259 (* TOK_else *);
  260 (* TOK_fi *);
  261 (* TOK_from *);
  262 (* TOK_hd *);
  263 (* TOK_if *);
  264 (* TOK_loop *);
  265 (* TOK_macro *);
  266 (* TOK_nil *);
  267 (* TOK_read *);
  268 (* TOK_show *);
  269 (* TOK_then *);
  270 (* TOK_tl *);
  271 (* TOK_until *);
  272 (* TOK_write *);
  273 (* SYMB1 *);
  274 (* SYMB2 *);
  275 (* SYMB3 *);
  276 (* SYMB4 *);
  277 (* SYMB5 *);
  278 (* SYMB6 *);
  279 (* SYMB7 *);
  280 (* SYMB8 *);
  281 (* TOK_EOF *);
    0|]

let yytransl_block = [|
  282 (* TOK_Ident *);
  283 (* TOK_String *);
  284 (* TOK_Integer *);
  285 (* TOK_Double *);
  286 (* TOK_Char *);
  287 (* TOK_RIdent *);
  288 (* TOK_Atom *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\003\000\005\000\005\000\008\000\
\009\000\009\000\009\000\007\000\007\000\010\000\010\000\010\000\
\010\000\010\000\010\000\010\000\013\000\013\000\014\000\014\000\
\015\000\015\000\016\000\016\000\011\000\011\000\011\000\011\000\
\011\000\017\000\017\000\017\000\012\000\012\000\019\000\019\000\
\019\000\004\000\004\000\004\000\018\000\006\000\020\000\000\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\001\000\008\000\000\000\002\000\006\000\
\000\000\001\000\003\000\003\000\001\000\004\000\003\000\003\000\
\006\000\006\000\002\000\003\000\002\000\000\000\002\000\000\000\
\002\000\000\000\002\000\000\000\003\000\002\000\002\000\003\000\
\001\000\001\000\001\000\003\000\003\000\001\000\001\000\001\000\
\003\000\001\000\001\000\005\000\001\000\001\000\001\000\002\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\002\000\048\000\000\000\000\000\004\000\
\042\000\000\000\047\000\049\000\000\000\043\000\001\000\000\000\
\000\000\007\000\000\000\003\000\046\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\040\000\000\000\000\000\013\000\000\000\039\000\
\038\000\044\000\000\000\000\000\000\000\045\000\000\000\000\000\
\000\000\000\000\000\000\000\000\035\000\000\000\033\000\034\000\
\000\000\019\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\011\000\000\000\000\000\037\000\000\000\030\000\031\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\020\000\041\000\000\000\015\000\000\000\012\000\016\000\029\000\
\036\000\032\000\000\000\000\000\000\000\000\000\000\000\000\000\
\014\000\005\000\000\000\000\000\000\000\000\000\018\000\017\000"

let yydgoto = "\003\000\
\005\000\012\000\006\000\053\000\007\000\046\000\037\000\018\000\
\029\000\038\000\054\000\039\000\079\000\096\000\077\000\093\000\
\055\000\040\000\041\000\014\000"

let yysindex = "\016\000\
\007\255\073\255\000\000\000\000\000\000\021\255\070\255\000\000\
\000\000\247\254\000\000\000\000\030\255\000\000\000\000\028\255\
\028\255\000\000\043\255\000\000\000\000\077\255\098\255\247\254\
\028\255\112\255\126\255\106\255\129\255\250\254\115\255\115\255\
\115\255\112\255\000\000\249\254\114\255\000\000\119\255\000\000\
\000\000\000\000\028\255\112\255\122\255\000\000\250\254\124\255\
\124\255\124\255\115\255\124\255\000\000\147\255\000\000\000\000\
\137\255\000\000\043\255\075\255\022\255\028\255\115\255\096\255\
\122\255\000\000\134\255\133\255\000\000\124\255\000\000\000\000\
\043\255\139\255\124\255\112\255\151\255\112\255\157\255\112\255\
\000\000\000\000\142\255\000\000\028\255\000\000\000\000\000\000\
\000\000\000\000\134\255\112\255\148\255\134\255\112\255\160\255\
\000\000\000\000\134\255\115\255\134\255\115\255\000\000\000\000"

let yyrindex = "\000\000\
\089\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\146\255\000\000\000\000\149\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\038\255\000\000\000\000\000\000\000\000\
\000\000\000\000\146\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\251\254\000\000\000\000\
\083\255\000\000\042\255\000\000\000\000\146\255\000\000\000\000\
\000\000\000\000\109\255\000\000\000\000\000\000\000\000\000\000\
\150\255\000\000\000\000\000\000\152\255\000\000\162\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\254\254\000\000\000\000\107\255\000\000\000\000\
\000\000\000\000\155\255\000\000\167\255\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\254\255\000\000\004\000\249\255\000\000\
\013\000\207\255\007\000\227\255\000\000\000\000\000\000\000\000\
\087\000\002\000\228\255\000\000"

let yytablesize = 171
let yytable = "\013\000\
\009\000\047\000\026\000\009\000\061\000\025\000\004\000\019\000\
\010\000\026\000\062\000\045\000\025\000\063\000\086\000\068\000\
\001\000\002\000\069\000\022\000\023\000\027\000\011\000\035\000\
\021\000\011\000\060\000\035\000\028\000\036\000\086\000\059\000\
\056\000\056\000\056\000\087\000\067\000\036\000\057\000\058\000\
\082\000\035\000\059\000\065\000\035\000\015\000\028\000\036\000\
\073\000\056\000\056\000\056\000\056\000\056\000\020\000\066\000\
\045\000\074\000\021\000\045\000\040\000\035\000\035\000\040\000\
\056\000\028\000\024\000\036\000\091\000\084\000\094\000\056\000\
\008\000\035\000\083\000\035\000\056\000\035\000\016\000\036\000\
\017\000\036\000\009\000\036\000\099\000\022\000\022\000\101\000\
\098\000\035\000\010\000\080\000\035\000\081\000\025\000\036\000\
\030\000\006\000\036\000\006\000\031\000\056\000\032\000\056\000\
\011\000\009\000\103\000\033\000\104\000\021\000\021\000\085\000\
\030\000\034\000\026\000\048\000\031\000\008\000\032\000\008\000\
\049\000\009\000\030\000\033\000\009\000\043\000\021\000\011\000\
\050\000\034\000\064\000\009\000\051\000\009\000\070\000\071\000\
\072\000\052\000\075\000\045\000\065\000\051\000\021\000\011\000\
\042\000\021\000\011\000\044\000\076\000\078\000\080\000\082\000\
\021\000\011\000\021\000\011\000\088\000\089\000\092\000\095\000\
\097\000\090\000\100\000\102\000\009\000\024\000\028\000\010\000\
\035\000\027\000\023\000"

let yycheck = "\002\000\
\010\001\030\000\008\001\010\001\034\000\008\001\000\001\010\000\
\018\001\015\001\018\001\018\001\015\001\021\001\064\000\045\000\
\001\000\002\000\047\000\016\000\017\000\024\000\032\001\026\000\
\031\001\032\001\034\000\030\000\025\000\026\000\080\000\034\000\
\031\000\032\000\033\000\065\000\044\000\034\000\032\000\033\000\
\019\001\044\000\045\000\022\001\047\000\025\001\043\000\044\000\
\051\000\048\000\049\000\050\000\051\000\052\000\025\001\043\000\
\019\001\051\000\031\001\022\001\019\001\064\000\065\000\022\001\
\063\000\062\000\024\001\064\000\076\000\063\000\078\000\070\000\
\000\001\076\000\062\000\078\000\075\000\080\000\009\001\076\000\
\011\001\078\000\010\001\080\000\092\000\003\001\004\001\095\000\
\085\000\092\000\018\001\017\001\095\000\019\001\018\001\092\000\
\001\001\009\001\095\000\011\001\005\001\100\000\007\001\102\000\
\032\001\010\001\100\000\012\001\102\000\003\001\004\001\016\001\
\001\001\018\001\017\001\001\001\005\001\009\001\007\001\011\001\
\006\001\010\001\001\001\012\001\010\001\020\001\031\001\032\001\
\014\001\018\001\017\001\010\001\018\001\010\001\048\000\049\000\
\050\000\023\001\052\000\018\001\022\001\018\001\031\001\032\001\
\019\001\031\001\032\001\019\001\002\001\013\001\017\001\019\001\
\031\001\032\001\031\001\032\001\070\000\019\001\008\001\003\001\
\019\001\075\000\015\001\004\001\019\001\004\001\015\001\019\001\
\019\001\015\001\004\001"

let yynames_const = "\
  TOK_cons\000\
  TOK_do\000\
  TOK_else\000\
  TOK_fi\000\
  TOK_from\000\
  TOK_hd\000\
  TOK_if\000\
  TOK_loop\000\
  TOK_macro\000\
  TOK_nil\000\
  TOK_read\000\
  TOK_show\000\
  TOK_then\000\
  TOK_tl\000\
  TOK_until\000\
  TOK_write\000\
  SYMB1\000\
  SYMB2\000\
  SYMB3\000\
  SYMB4\000\
  SYMB5\000\
  SYMB6\000\
  SYMB7\000\
  SYMB8\000\
  TOK_EOF\000\
  "

let yynames_block = "\
  TOK_Ident\000\
  TOK_String\000\
  TOK_Integer\000\
  TOK_Double\000\
  TOK_Char\000\
  TOK_RIdent\000\
  TOK_Atom\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'program) in
    Obj.repr(
# 35 "ParRwhile.mly"
                           ( _1 )
# 249 "ParRwhile.ml"
               : AbsRwhile.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "ParRwhile.mly"
          ( raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) )
# 255 "ParRwhile.ml"
               : AbsRwhile.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'valT) in
    Obj.repr(
# 38 "ParRwhile.mly"
                     ( _1 )
# 262 "ParRwhile.ml"
               : AbsRwhile.valT))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "ParRwhile.mly"
          ( raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) )
# 268 "ParRwhile.ml"
               : AbsRwhile.valT))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : 'macro_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'rIdent) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'com) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'rIdent) in
    Obj.repr(
# 42 "ParRwhile.mly"
                                                                      ( Prog ((List.rev _1), _3, _5, _8) )
# 278 "ParRwhile.ml"
               : 'program))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "ParRwhile.mly"
                         ( []  )
# 284 "ParRwhile.ml"
               : 'macro_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'macro_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'macro) in
    Obj.repr(
# 46 "ParRwhile.mly"
                     ( (fun (x,xs) -> x::xs) (_2, _1) )
# 292 "ParRwhile.ml"
               : 'macro_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'rIdent) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'rIdent_list) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 49 "ParRwhile.mly"
                                                     ( Mac (_2, _4, _6) )
# 301 "ParRwhile.ml"
               : 'macro))
; (fun __caml_parser_env ->
    Obj.repr(
# 52 "ParRwhile.mly"
                          ( []  )
# 307 "ParRwhile.ml"
               : 'rIdent_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'rIdent) in
    Obj.repr(
# 53 "ParRwhile.mly"
           ( (fun x -> [x]) _1 )
# 314 "ParRwhile.ml"
               : 'rIdent_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'rIdent) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'rIdent_list) in
    Obj.repr(
# 54 "ParRwhile.mly"
                             ( (fun (x,xs) -> x::xs) (_1, _3) )
# 322 "ParRwhile.ml"
               : 'rIdent_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'com) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'com1) in
    Obj.repr(
# 57 "ParRwhile.mly"
                     ( CSeq (_1, _3) )
# 330 "ParRwhile.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'com1) in
    Obj.repr(
# 58 "ParRwhile.mly"
         (  _1 )
# 337 "ParRwhile.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'rIdent) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'rIdent_list) in
    Obj.repr(
# 61 "ParRwhile.mly"
                                      ( CMac (_1, _3) )
# 345 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'rIdent) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 62 "ParRwhile.mly"
                     ( CAss (_1, _3) )
# 353 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'pat) in
    Obj.repr(
# 63 "ParRwhile.mly"
                  ( CRep (_1, _3) )
# 361 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'thenBranch) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'elseBranch) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 64 "ParRwhile.mly"
                                                ( CCond (_2, _3, _4, _6) )
# 371 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'doBranch) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'loopBranch) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 65 "ParRwhile.mly"
                                                   ( CLoop (_2, _3, _4, _6) )
# 381 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 66 "ParRwhile.mly"
                 ( CShow _2 )
# 388 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'com) in
    Obj.repr(
# 67 "ParRwhile.mly"
                    (  _2 )
# 395 "ParRwhile.ml"
               : 'com1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 70 "ParRwhile.mly"
                          ( BThen _2 )
# 402 "ParRwhile.ml"
               : 'thenBranch))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "ParRwhile.mly"
                ( BThenNone  )
# 408 "ParRwhile.ml"
               : 'thenBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 74 "ParRwhile.mly"
                          ( BElse _2 )
# 415 "ParRwhile.ml"
               : 'elseBranch))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "ParRwhile.mly"
                ( BElseNone  )
# 421 "ParRwhile.ml"
               : 'elseBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 78 "ParRwhile.mly"
                      ( BDo _2 )
# 428 "ParRwhile.ml"
               : 'doBranch))
; (fun __caml_parser_env ->
    Obj.repr(
# 79 "ParRwhile.mly"
                ( BDoNone  )
# 434 "ParRwhile.ml"
               : 'doBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 82 "ParRwhile.mly"
                          ( BLoop _2 )
# 441 "ParRwhile.ml"
               : 'loopBranch))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "ParRwhile.mly"
                ( BLoopNone  )
# 447 "ParRwhile.ml"
               : 'loopBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp1) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 86 "ParRwhile.mly"
                         ( ECons (_2, _3) )
# 455 "ParRwhile.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 87 "ParRwhile.mly"
                ( EHd _2 )
# 462 "ParRwhile.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 88 "ParRwhile.mly"
                ( ETl _2 )
# 469 "ParRwhile.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp1) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 89 "ParRwhile.mly"
                    ( EEq (_2, _3) )
# 477 "ParRwhile.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 90 "ParRwhile.mly"
         (  _1 )
# 484 "ParRwhile.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'variable) in
    Obj.repr(
# 93 "ParRwhile.mly"
                ( EVar _1 )
# 491 "ParRwhile.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'valT) in
    Obj.repr(
# 94 "ParRwhile.mly"
         ( EVal _1 )
# 498 "ParRwhile.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 95 "ParRwhile.mly"
                    (  _2 )
# 505 "ParRwhile.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'pat1) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'pat1) in
    Obj.repr(
# 98 "ParRwhile.mly"
                         ( PCons (_2, _3) )
# 513 "ParRwhile.ml"
               : 'pat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'pat1) in
    Obj.repr(
# 99 "ParRwhile.mly"
         (  _1 )
# 520 "ParRwhile.ml"
               : 'pat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'variable) in
    Obj.repr(
# 102 "ParRwhile.mly"
                ( PVar _1 )
# 527 "ParRwhile.ml"
               : 'pat1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'valT) in
    Obj.repr(
# 103 "ParRwhile.mly"
         ( PVal _1 )
# 534 "ParRwhile.ml"
               : 'pat1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'pat) in
    Obj.repr(
# 104 "ParRwhile.mly"
                    (  _2 )
# 541 "ParRwhile.ml"
               : 'pat1))
; (fun __caml_parser_env ->
    Obj.repr(
# 107 "ParRwhile.mly"
               ( VNil  )
# 547 "ParRwhile.ml"
               : 'valT))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 108 "ParRwhile.mly"
         ( VAtom _1 )
# 554 "ParRwhile.ml"
               : 'valT))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'valT) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'valT) in
    Obj.repr(
# 109 "ParRwhile.mly"
                                ( VCons (_2, _4) )
# 562 "ParRwhile.ml"
               : 'valT))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'rIdent) in
    Obj.repr(
# 112 "ParRwhile.mly"
                  ( Var _1 )
# 569 "ParRwhile.ml"
               : 'variable))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 116 "ParRwhile.mly"
                    ( RIdent (_1))
# 576 "ParRwhile.ml"
               : 'rIdent))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 117 "ParRwhile.mly"
                ( Atom (_1))
# 583 "ParRwhile.ml"
               : 'atom))
(* Entry pProgram *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry pValT *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let pProgram (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : AbsRwhile.program)
let pValT (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : AbsRwhile.valT)
