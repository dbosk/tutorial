# Makefile for test suite
#
# Tests are written in .nw files throughout the src/ tree using
# chunks named "<<test [[modulename.py]]>>". This Makefile automatically
# discovers those chunks and tangles them to tests/unit/test_*.py files.

define find_tests
( \
	find ../src -name '*.nw' | xargs grep -l '<<test \[\[.*\.py\]\]>>' | \
		while read file; do \
			grep -o '<<test \[\[\([^]]*\)\.py\]\]>>' "$$file" | sort -u | \
			sed 's/<<test \[\[\(.*\)\.py\]\]>>/\1/' | \
			while read chunk; do \
				chunk_safe=$$(echo "$$chunk" | sed 's/ /%20/g'); \
				echo "unit/test_$${chunk_safe}.py:$$file:test%20[[$$chunk_safe.py]]"; \
			done; \
		done; \
) | sort -u
endef

define def_target
$(shell echo $1 | cut -d: -f1): $(shell echo $1 | cut -d: -f2)
	@mkdir -p $$(dir $$@)
	notangle -R"$(shell echo $1 | cut -d: -f3 | sed 's/%20/ /g')" $$< \
	  | cpif $$@ && noroots $$<
endef

TESTS := $(shell $(find_tests))
TEST_MODULES := $(foreach entry,$(TESTS),$(shell echo $(entry) | cut -d: -f1))


.PHONY: all
all: $(TEST_MODULES)

$(foreach entry,$(TESTS),$(eval $(call def_target,$(entry))))

.PHONY: test
test: all compile
	poetry run pytest -v

.PHONY: compile
compile:
	$(MAKE) -C ../src/pytorial all

.PHONY: clean
clean:
	$(RM) $(TEST_MODULES)
	$(RM) -r .pytest_cache __pycache__ unit/__pycache__
	$(RM) -r htmlcov .coverage
