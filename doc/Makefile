LATEXFLAGS += -shell-escape

.PHONY: all weave clean distclean
all: pytorial.pdf

weave: pytorial.tex

../src/pytorial/pytorial.tex: ../src/pytorial/pytorial.nw
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

pytorial.pdf: pytorial.tex
pytorial.pdf: ../src/pytorial/pytorial.tex
pytorial.pdf: ../src/pytorial/catalog.tex
pytorial.pdf: ../src/pytorial/model.tex
pytorial.pdf: ../src/pytorial/state.tex
pytorial.pdf: ../src/pytorial/shell.tex
pytorial.pdf: ../src/pytorial/run.tex
pytorial.pdf: ../src/pytorial/cli.tex
pytorial.pdf: ../src/pytorial/tutorials/using-tutorials.tex
pytorial.pdf: ../src/pytorial/tutorials/writing-tutorials.tex
pytorial.pdf: ../src/pytorial/tutorials/shell-basics.tex
pytorial.pdf: abstract.tex preamble.tex

clean:
	${RM} pytorial.tex pytorial.pdf

distclean:

INCLUDE_MAKEFILES = ../makefiles
include ${INCLUDE_MAKEFILES}/noweb.mk
include ${INCLUDE_MAKEFILES}/tex.mk
