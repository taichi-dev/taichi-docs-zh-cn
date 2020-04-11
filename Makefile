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

TAICHI_CLONE := ./tmp/taichi/
SPHINX_CONF := $(TAICHI_CLONE)/docs/conf.py
LANGUAGE := zh_cn
LC_MESSAGES := $(TAICHI_CLONE)/docs/locales/$(LANGUAGE)/LC_MESSAGES
VENV := ./.venvs/taichi-docs-zh-cn/
PYTHON := $(shell which python3)
BRANCH = $(shell git describe --contains --all HEAD)


.PHONY: all
all: $(VENV)/bin/sphinx-build $(SPHINX_CONF)
	. $(VENV)/bin/activate; cd $(TAICHI_CLONE)/docs; sphinx-build -M gettext . build


$(SPHINX_CONF):
	git clone --depth 1 --no-single-branch https://github.com/taichi-dev/taichi.git $(TAICHI_CLONE)
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
	$(shell msgcat *.po */*.po | msgattrib --translated | grep -c '^msgid') \
	$(shell msgcat *.po */*.po | grep -c '^msgid')


.PHONY: todo
todo:
	for file in *.po */*.po; do echo $$(msgattrib --untranslated $$file | grep ^msgid | sed 1d | wc -l ) $$file; done | grep -v ^0 | sort -gr


.PHONY: merge
merge: upgrade_venv
ifneq "$(shell cd $(TAICHI_CLONE) 2>/dev/null && git describe --contains --all HEAD)" "$(BRANCH)"
	$(error "You're merging from a different branch")
endif
	(cd $(TAICHI_CLONE)/docs; git pull)
	mkdir -p $(LC_MESSAGES)
	cp ./*.po $(LC_MESSAGES)
	(. $(VENV)/bin/activate; cd $(TAICHI_CLONE)/docs; sphinx-build -M gettext . build; sphinx-intl update -p build/gettext -l zh_cn)
	cp $(LC_MESSAGES)/*.po .
	rm $(LC_MESSAGES)/*.po


.PHONY: fuzzy
fuzzy:
	for file in *.po */*.po; do echo $$(msgattrib --only-fuzzy --no-obsolete "$$file" | grep -c '#, fuzzy') $$file; done | grep -v ^0 | sort -gr
