SUBDIR_GOALS=	all clean distclean

SUBDIR+=		src/tutorial
SUBDIR+=		tests
SUBDIR+=		doc

version=$(shell sed -n 's/^ *version *= *\"\([^\"]\+\)\"/\1/p' pyproject.toml)

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

.PHONY: publish
publish: publish-pypi publish-github

.PHONY: publish-pypi
publish-pypi: compile
	poetry publish

.PHONY: publish-github
publish-github: doc/tutorial.pdf
	git push
	gh release create -t v${version} v${version} doc/tutorial.pdf


.PHONY: clean
clean:

.PHONY: distclean
distclean:
	${RM} -R build dist tutorial.egg-info src/tutorial.egg-info


INCLUDE_MAKEFILES=makefiles
include ${INCLUDE_MAKEFILES}/subdir.mk
