<<<<<<< HEAD
set /p PROJECT_DIR="Enter project DIR: "
set /p PROJECT_NAME="Enter project NAME: "
set RESULT_DIR=C:\Users\Tuha9\Desktop\%PROJECT_NAME%_Compiled

set QT_MINGW_DIR=D:\Qt\5.14.1\mingw73_64
set QT_CREATORDIR=D:\Qt\Tools\QtCreator
set TOOLS_MINGW_DIR=D:\Qt\Tools\mingw730_64
set PATH=%QT_MINGW_DIR%\bin;%QT_CREATOR_DIR%/bin;%TOOLS_MINGW_DIR%/bin;%PATH%

mkdir %RESULT_DIR%
cd %RESULT_DIR%

D:\Qt\5.14.1\mingw73_64\bin\qmake.exe %PROJECT_DIR%\%PROJECT_NAME%.pro -spec win32-g++ "CONFIG+=qtquickcompiler" && %TOOLS_MINGW_DIR%/bin/mingw32-make.exe qmake_all
%TOOLS_MINGW_DIR%/bin/mingw32-make.exe
%TOOLS_MINGW_DIR%/bin/mingw32-make.exe clean

set WINDEPLOYQT_EXE=%QT_MINGW_DIR%/bin/windeployqt.exe
set QML_DIR=%PROJECT_DIR%
=======
set /p PROJECT_DIR="Enter project DIR: "
set /p PROJECT_NAME="Enter project NAME: "
set RESULT_DIR=C:\Users\Tuha9\Desktop\%PROJECT_NAME%_Compiled

set QT_MINGW_DIR=D:\Qt\5.14.1\mingw73_64
set QT_CREATORDIR=D:\Qt\Tools\QtCreator
set TOOLS_MINGW_DIR=D:\Qt\Tools\mingw730_64
set PATH=%QT_MINGW_DIR%\bin;%QT_CREATOR_DIR%/bin;%TOOLS_MINGW_DIR%/bin;%PATH%

mkdir %RESULT_DIR%
cd %RESULT_DIR%

D:\Qt\5.14.1\mingw73_64\bin\qmake.exe %PROJECT_DIR%\%PROJECT_NAME%.pro -spec win32-g++ "CONFIG+=qtquickcompiler" && %TOOLS_MINGW_DIR%/bin/mingw32-make.exe qmake_all
%TOOLS_MINGW_DIR%/bin/mingw32-make.exe
%TOOLS_MINGW_DIR%/bin/mingw32-make.exe clean

set WINDEPLOYQT_EXE=%QT_MINGW_DIR%/bin/windeployqt.exe
set QML_DIR=%PROJECT_DIR%
>>>>>>> b220e271b8a6f9edb650ada332f54104bce88df0
%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %RESULT_DIR%\%PROJECT_NAME%.exe