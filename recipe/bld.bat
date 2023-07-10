mkdir build
cd build

curl -fsSOL https://software-network.org/client/sw-master-windows_x86_64-client.zip
if errorlevel 1 exit 1

unzip sw-master-windows_x86_64-client.zip -d .
if errorlevel 1 exit 1

set PATH=%PATH%;%CD%

sw setup
if errorlevel 1 exit 1

cmake -G "Ninja" ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D BUILD_PROG=1 ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D CMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
      -D CMAKE_LIBRARY_PATH=%LIBRARY_LIB% ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -D BUILD_SHARED_LIBS=ON ^
      -D CMAKE_MODULE_LINKER_FLAGS=-whole-archive ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Make copies of the .lib file without the embedded version number
copy %LIBRARY_LIB%\leptonica-1.82.0.lib %LIBRARY_LIB%\leptonica.lib
copy %LIBRARY_LIB%\leptonica-1.82.0.lib %LIBRARY_LIB%\lept.lib
