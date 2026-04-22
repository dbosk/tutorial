SUBDIR_GOALS=	all clean distclean

SUBDIR+=		src/tutorial
SUBDIR+=		tests
SUBDIR+=		doc


.PHONY: all
all: compile doc/tutorial.pdf test

.PHONY: compile
compile:
	${MAKE} -C src/tutorial all
	poetry build

.PHONY: test
test: compile
	${MAKE} -C tests test

doc/tutorial.pdf:
	${MAKE} -C $(dir $@) $(notdir $@)


.PHONY: clean
clean:

.PHONY: distclean
distclean:
	${RM} -R build dist tutorial.egg-info src/tutorial.egg-info


INCLUDE_MAKEFILES=makefiles
include ${INCLUDE_MAKEFILES}/subdir.mk
