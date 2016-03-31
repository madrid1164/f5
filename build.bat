@echo off
PATH=%PATH%;c:\Python27;c:\Python26
SET BUILDOPT=

IF NOT "%1"=="" SET BUILDOPT=-a %1
IF NOT "%2"=="" SET BUNDLEDIR=-b %2

mkdir tmp
IF NOT EXIST parts mkdir parts

echo Generating APL...
python util/build_apl.py src\presentation_layer.json > tmp\apl.build

echo Generating docs...
python util/build_doc.py src\presentation_layer.json > OPTIONS.html

echo Assembling template...
echo BUILDOPT=%BUILDOPT%
python util\build_tmpl.py %BUILDOPT% %BUNDLEDIR% "%cd%"
python util\build_tmpl.py %BUILDOPT% %BUNDLEDIR% -o parts\iapp.tcl -r src\implementation_only.template "%cd%" > NUL
python util\build_tmpl.py %BUILDOPT% %BUNDLEDIR% -o parts\iapp.apl -r tmp\apl.build "%cd%" > NUL
del tmp\apl.build
del tmp\bundler.build

rmdir tmp

