@echo off
chcp 65001 >nul
net session >nul 2>&1 || (powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b)
call "%~dp0ortak.cmd" || exit /b 1
sc stop GoodbyeDPI >nul 2>&1
sc delete GoodbyeDPI >nul 2>&1
sc create GoodbyeDPI binPath= "\"%GDPI_EXE%\" %GDPI_ARGS%" start= auto
sc description GoodbyeDPI "Discord erisimi icin DPI atlatma"
sc start GoodbyeDPI
echo.
echo Kuruldu. Artik bilgisayar her acildiginda otomatik calisacak.
echo NOT: Bu klasoru silme / tasima. Tasiyacaksan once otomatik-kaldir.cmd calistir.
pause
