@echo off
chcp 65001 >nul
net session >nul 2>&1 || (powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b)
sc stop GoodbyeDPI
sc delete GoodbyeDPI
sc stop WinDivert >nul 2>&1
sc delete WinDivert >nul 2>&1
echo Otomatik baslatma kaldirildi.
pause
