NOWEB_SUFFIXES+=	.md

MODULES+=	using-tutorials.md using-tutorials.tex
MODULES+=	writing-tutorials.md writing-tutorials.tex
MODULES+=	shell-basics.md shell-basics.tex

.PHONY: all
all: ${MODULES}

using-tutorials.md: using-tutorials.nw
writing-tutorials.md: writing-tutorials.nw
shell-basics.md: shell-basics.nw


.PHONY: clean
clean:
	${RM} ${MODULES}

.PHONY: distclean
distclean:
	${RM} -Rf ltxobj


INCLUDE_MAKEFILES=../../../makefiles
include ${INCLUDE_MAKEFILES}/tex.mk
include ${INCLUDE_MAKEFILES}/noweb.mk
