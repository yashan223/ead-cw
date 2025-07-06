@echo off
cd /d "c:\Users\Yashan Perera\Documents\NetBeansProjects\JAVACW"
echo Cleaning and building project...
rmdir /s /q build\classes 2>nul
mkdir build\classes 2>nul
javac -cp "src;src\javacw\lib\*" -d build\classes src\javacw\dao\*.java src\javacw\model\*.java src\javacw\gui\*.java src\javacw\*.java
if errorlevel 1 (
    echo Build failed!
    pause
    exit /b 1
)
echo Build successful! Running application...
java -cp "build\classes;src\javacw\lib\*" javacw.Main
pause
