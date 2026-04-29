NOTANGLEFLAGS.py=

MODULES+=	__init__.py tutorial.tex
MODULES+=	catalog.py catalog.tex
MODULES+=	model.py model.tex
MODULES+=	state.py state.tex
MODULES+=	shell.py shell.tex
MODULES+=	run.py run.tex
MODULES+=	cli.py cli.tex

.PHONY: all
all: ${MODULES}
	${MAKE} -C tutorials all

__init__.py: tutorial.nw
	${NOTANGLE.py}

catalog.py: catalog.nw
model.py: model.nw
state.py: state.nw
shell.py: shell.nw
run.py: run.nw
cli.py: cli.nw


.PHONY: clean
clean:
	${RM} ${MODULES}
	${MAKE} -C tutorials clean

.PHONY: distclean
distclean:
	${RM} -Rf __pycache__
	${MAKE} -C tutorials distclean


INCLUDE_MAKEFILES=../../makefiles
include ${INCLUDE_MAKEFILES}/tex.mk
include ${INCLUDE_MAKEFILES}/noweb.mk
