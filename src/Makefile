OCAMLC=ocamlfind ocamlc -g -package extlib -linkpkg
#OCAMLC=ocamlfind ocamlopt -warn-error A -package extlib -linkpkg

all: ri

ri: BNFC_Util.ml AbsRwhile.ml ShowRwhile.ml PrintRwhile.ml ParRwhile.mli ParRwhile.ml LexRwhile.ml InvRwhile.ml MacroRwhile.ml EvalRwhile.ml Program2DataRwhile.ml Main.ml
	$(OCAMLC) -o $@ $^

LexRwhile.ml: LexRwhile.mll
	ocamllex LexRwhile.mll

ParRwhile.mli: ParRwhile.mly
	ocamlyacc ParRwhile.mly

BNFC_Util.ml: Rwhile.cf
# bnfc(Haskell) はロケール既定の文字符号化で .cf を読む。LANG が C の環境
# （コンテナ・CI・cron）だと Rwhile.cf の UTF-8 で落ちるので、明示する。
	LC_ALL=C.UTF-8 bnfc -ocaml Rwhile.cf
	touch BNFC_Util.ml

clean:
	-rm -f *.cmi *.cmo *.o *.mli *.cmx ri

distclean: clean
	-rm -f LexRwhile.* ParRwhile.* LayoutRwhile.* SkelRwhile.* PrintRwhile.* ShowRwhile.* TestRwhile.* AbsRwhile.* TestRwhile BNFC_Util.ml\
	 	ri

install: ri
	mkdir -p ../bin
	cp -f ./ri ../bin/

test: ri
	./ri ../public/examples/rep.rwhile ../public/examples/list123.val
	./ri -inverse ../public/examples/ri.rwhile
	./ri -exp ../public/examples/ri.rwhile
	./ri -p2d ../public/examples/reverse.rwhile
	./ri ../public/examples/ri.rwhile ../public/examples/id_and_nil.p_val
	./ri ../public/examples/ri.rwhile ../public/examples/reverse_and_list123.p_val
	./ri ../public/examples/ri.rwhile ../public/examples/piorder.p_val
	# ./ri ../public/examples/ri.rwhile ../public/examples/ri_reverse_list123.p_val    # 6.6s かかった
	# ./ri ../public/examples/ri.rwhile ../public/examples/ri_piorder_atree.p_val      # 1分以上かかるかも
	# ./ri ../public/examples/ri.rwhile ../public/examples/ri_ri_reverse_list123.p_val # 1:31:39.23もかかった
	./ri ../public/examples/enumeration.rwhile ../public/examples/nil.val
	./ri ../public/examples/length.rwhile ../public/examples/list123.val
	# ./ri ../public/examples/perm_to_code.rwhile ../public/examples/perm_to_code.val  # failed?
	./ri ../public/examples/compare.rwhile ../public/examples/compare0.val
	./ri ../public/examples/minus.rwhile ../public/examples/minus.val
	./ri ../public/examples/rle.rwhile ../public/examples/rle0.val
	./ri ../public/examples/rle.rwhile ../public/examples/rle1.val
	./ri ../public/examples/rle.rwhile ../public/examples/rle2.val
	./ri ../public/examples/rle.rwhile ../public/examples/rle3.val
	./ri ../public/examples/rle.rwhile ../public/examples/rle4.val
	#./ri ../public/examples/infinite.rwhile ../public/examples/nil.val   #停止しない例
	./ri ../public/examples/lookup_ppl2015.rwhile ../public/examples/nil.val
	./ri ../public/examples/lookup.rwhile ../public/examples/nil.val
