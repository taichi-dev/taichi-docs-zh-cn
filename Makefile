# Makefile for Chinese (Simplified) Taichi Documentation
#
# Here is what you can do:
#
# - make  # Automatically build an html local version
# - make todo  # To list remaining tasks
# - make merge  # To merge pot from upstream
# - make fuzzy  # To find fuzzy strings
# - make progress  # To compute current progression
# - make upgrade_venv  # To upgrade the venv that compiles the doc
#
# Credits: Taichi Documentation Chinese Translation Team (https://github.com/stephenark30/taichi-docs-zh-cn)

TAICHI_CLONE := ./taichi
LANGUAGE := zh_CN
LC_MESSAGES := ./locales/$(LANGUAGE)/LC_MESSAGES
VENV := ./.venvs/taichi-docs-zh-cn
PYTHON := $(shell which python3)
BRANCH = $(shell git symbolic-ref --short -q HEAD)


.PHONY: all
all: $(TAICHI_CLONE)/docs $(VENV)/bin/sphinx-build merge


$(TAICHI_CLONE)/docs:
	git submodule init
	git submodule update
	cd $(TAICHI_CLONE) && git checkout $(BRANCH)


$(VENV)/bin/activate:
	mkdir -p $(VENV)
	$(PYTHON) -m venv $(VENV)


$(VENV)/bin/sphinx-build: $(VENV)/bin/activate
	. $(VENV)/bin/activate; python3 -m pip install Sphinx sphinx_rtd_theme sphinx-intl


.PHONY: upgrade_venv
upgrade_venv: $(VENV)/bin/activate
	. $(VENV)/bin/activate; python3 -m pip install --upgrade Sphinx sphinx_rtd_theme sphinx-intl


.PHONY: progress
progress:
	@python3 -c 'import sys; print("{:.1%}".format(int(sys.argv[1]) / int(sys.argv[2])))'  \
	$(shell msgcat $(LC_MESSAGES)/*.po | msgattrib --translated | grep -c '^msgid') \
	$(shell msgcat $(LC_MESSAGES)/*.po | grep -c '^msgid')


.PHONY: todo
todo:
	for file in $(LC_MESSAGES)/*.po; do echo $$(msgattrib --untranslated $$file | grep ^msgid | sed 1d | wc -l ) $$file; done | grep -v ^0 | sort -gr


.PHONY: merge
merge: upgrade_venv
ifneq "$(shell cd $(TAICHI_CLONE) 2>/dev/null && git symbolic-ref --short -q HEAD)" "$(BRANCH)"
	$(error "You're merging from a different branch, please cd $(TAICHI_CLONE) && git checkout $(BRANCH)")
endif
	# files might be renamed in the origin doc, so we have to delete old files
	rm -rf ./*.rst ./*.jpg ./*.png ./_static ./version ./conf.py
	cd $(TAICHI_CLONE); git checkout -- ./; git pull;
	
	cp $(TAICHI_CLONE)/docs/*.rst ./
	cp $(TAICHI_CLONE)/docs/*.jpg ./
	cp $(TAICHI_CLONE)/docs/*.png ./
	cp -r $(TAICHI_CLONE)/docs/_static ./
	cp $(TAICHI_CLONE)/docs/version ./
	cp $(TAICHI_CLONE)/docs/conf.py ./
	echo "gettext_additional_targets = ['literal-block']" >> conf.py
	echo "language = '$(LANGUAGE)'" >> conf.py
	echo "locale_dirs = ['locales/']" >> conf.py
	. $(VENV)/bin/activate; $(VENV)/bin/sphinx-build -M gettext . build; $(VENV)/bin/sphinx-intl update -p build/gettext -l $(LANGUAGE)


.PHONY: html
html:
	. $(VENV)/bin/activate; sphinx-build -M html . build -D language='$(LANGUAGE)'


.PHONY: fuzzy
fuzzy:
	for file in $(LC_MESSAGES)/*.po; do echo $$(msgattrib --only-fuzzy --no-obsolete "$$file" | grep -c '#, fuzzy') $$file; done | grep -v ^0 | sort -gr
