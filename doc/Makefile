LATEXFLAGS += -shell-escape

.PHONY: all weave clean distclean
all: tutorial.pdf

weave: tutorial.tex

../src/pytorial/tutorial.tex: ../src/pytorial/tutorial.nw
../src/pytorial/catalog.tex: ../src/pytorial/catalog.nw
../src/pytorial/model.tex: ../src/pytorial/model.nw
../src/pytorial/state.tex: ../src/pytorial/state.nw
../src/pytorial/shell.tex: ../src/pytorial/shell.nw
../src/pytorial/run.tex: ../src/pytorial/run.nw
../src/pytorial/cli.tex: ../src/pytorial/cli.nw
../src/pytorial/tutorials/using-tutorials.tex: ../src/pytorial/tutorials/using-tutorials.nw
../src/pytorial/tutorials/writing-tutorials.tex: ../src/pytorial/tutorials/writing-tutorials.nw
../src/pytorial/tutorials/shell-basics.tex: ../src/pytorial/tutorials/shell-basics.nw

%.tex: %.nw
	${MAKE} -C $(dir $@) $(notdir $@)

../src/%.tex: ../src/%.nw
	${MAKE} -C $(dir $@) $(notdir $@)

tutorial.pdf: tutorial.tex
tutorial.pdf: ../src/pytorial/tutorial.tex
tutorial.pdf: ../src/pytorial/catalog.tex
tutorial.pdf: ../src/pytorial/model.tex
tutorial.pdf: ../src/pytorial/state.tex
tutorial.pdf: ../src/pytorial/shell.tex
tutorial.pdf: ../src/pytorial/run.tex
tutorial.pdf: ../src/pytorial/cli.tex
tutorial.pdf: ../src/pytorial/tutorials/using-tutorials.tex
tutorial.pdf: ../src/pytorial/tutorials/writing-tutorials.tex
tutorial.pdf: ../src/pytorial/tutorials/shell-basics.tex
tutorial.pdf: abstract.tex preamble.tex

clean:
	${RM} tutorial.tex tutorial.pdf

distclean:

INCLUDE_MAKEFILES = ../makefiles
include ${INCLUDE_MAKEFILES}/noweb.mk
include ${INCLUDE_MAKEFILES}/tex.mk
