@ECHO OFF
pushd %~dp0

set TAICHI_CLONE=.\taichi
set LANGUAGE=zh_CN
set LC_MESSAGES=.\locales\%LANGUAGE%\LC_MESSAGES
set VENV=.\.venvs\taichi-docs-zh-cn
for /f %%i in ('git symbolic-ref --short -q HEAD') do set BRANCH=%%i
set PROJECT_PATH=%cd%


if "%1" == "" goto all
if "%1" == "merge" goto merge
if "%1" == "html" goto html

:all
git submodule init
git submodule update
cd %TAICHI_CLONE% && git checkout %BRANCH%
cd ..
md "%VENV%"
python -m venv %VENV%
call python -m pip install Sphinx sphinx_rtd_theme sphinx-intl
goto merge


:merge
cd %TAICHI_CLONE%
for /f %%i in ('git symbolic-ref --short -q HEAD') do set SUB_BRANCH=%%i
cd %PROJECT_PATH%
if "%SUB_BRANCH%" == "%BRANCH%" (
	call %VENV%\Scripts\activate
	call python -m pip install --upgrade Sphinx sphinx_rtd_theme sphinx-intl
	del /q *.rst *.jpg *.png version conf.py
	rd /s /q _static
	cd %TAICHI_CLONE%
	git checkout -- ./
	git pull
	cd %PROJECT_PATH%
	copy %TAICHI_CLONE%\docs\*.rst
	copy %TAICHI_CLONE%\docs\*.jpg
	copy %TAICHI_CLONE%\docs\*.png
	copy %TAICHI_CLONE%\docs\version
	copy %TAICHI_CLONE%\docs\conf.py
	xcopy /s /Y /i /e %TAICHI_CLONE%\docs\_static _static\
	echo gettext_additional_targets = ['literal-block'] >> conf.py
	echo locale_dirs = ['locales'] >> conf.py
	call %VENV%\Scripts\sphinx-build -M gettext . build
	call %VENV%\Scripts\sphinx-intl update -p build/gettext -l %LANGUAGE%
	deactivate
	goto end
) else (
	echo "You're merging from a different branch, please cd %TAICHI_CLONE% && git checkout %BRANCH%"
	goto end
)


:html
call %VENV%\Scripts\activate
call %VENV%\Scripts\sphinx-build -M html . build -D language=%LANGUAGE%
deactivate
goto end


:end
popd