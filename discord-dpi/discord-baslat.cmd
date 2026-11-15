@echo off
chcp 65001 >nul
rem Yonetici olarak calismiyorsa kendini yonetici olarak yeniden baslat
net session >nul 2>&1 || (powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b)
call "%~dp0ortak.cmd" || exit /b 1
echo.
echo GoodbyeDPI calisiyor. Bu pencere ACIK kaldigi surece Discord'a girebilirsin.
echo Kapatmak icin bu pencereyi kapat veya Ctrl+C bas.
echo.
"%GDPI_EXE%" %GDPI_ARGS%
pause
