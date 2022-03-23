rem update submodule
git submodule update --init --recursive

rem build core
cd Core
mkdir build
cd build
cmake .. -A x64 -D USE_MSVC_RUNTIME_LIBRARY_DLL=OFF
cmake --build . --config Release
cmake --build . --config Debug

rem build
cd ../../
dotnet build Altseed2.sln --configuration CI
dotnet build Altseed2.sln --configuration Release

rem run test
cd Build/CI/net5.0
TestForMacLinux.exe
cd ../../../Scripts
python test_screenshot.py