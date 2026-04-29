LATEXFLAGS += -shell-escape

.PHONY: all weave clean distclean
all: tutorial.pdf

weave: tutorial.tex

../src/tutorial/tutorial.tex: ../src/tutorial/tutorial.nw
../src/tutorial/catalog.tex: ../src/tutorial/catalog.nw
../src/tutorial/model.tex: ../src/tutorial/model.nw
../src/tutorial/state.tex: ../src/tutorial/state.nw
../src/tutorial/shell.tex: ../src/tutorial/shell.nw
../src/tutorial/run.tex: ../src/tutorial/run.nw
../src/tutorial/cli.tex: ../src/tutorial/cli.nw
../src/tutorial/tutorials/using-tutorials.tex: ../src/tutorial/tutorials/using-tutorials.nw
../src/tutorial/tutorials/writing-tutorials.tex: ../src/tutorial/tutorials/writing-tutorials.nw
../src/tutorial/tutorials/shell-basics.tex: ../src/tutorial/tutorials/shell-basics.nw

%.tex: %.nw
	${MAKE} -C $(dir $@) $(notdir $@)

../src/%.tex: ../src/%.nw
	${MAKE} -C $(dir $@) $(notdir $@)

tutorial.pdf: tutorial.tex
tutorial.pdf: ../src/tutorial/tutorial.tex
tutorial.pdf: ../src/tutorial/catalog.tex
tutorial.pdf: ../src/tutorial/model.tex
tutorial.pdf: ../src/tutorial/state.tex
tutorial.pdf: ../src/tutorial/shell.tex
tutorial.pdf: ../src/tutorial/run.tex
tutorial.pdf: ../src/tutorial/cli.tex
tutorial.pdf: ../src/tutorial/tutorials/using-tutorials.tex
tutorial.pdf: ../src/tutorial/tutorials/writing-tutorials.tex
tutorial.pdf: ../src/tutorial/tutorials/shell-basics.tex
tutorial.pdf: abstract.tex preamble.tex

clean:
	${RM} tutorial.tex tutorial.pdf

distclean:

INCLUDE_MAKEFILES = ../makefiles
include ${INCLUDE_MAKEFILES}/noweb.mk
include ${INCLUDE_MAKEFILES}/tex.mk
