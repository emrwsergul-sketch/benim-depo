@echo off
title Discord DPI - BU PENCEREYI KAPATMA
rem Yonetici olarak calismiyorsa kendini yonetici olarak yeniden baslat
net session >nul 2>&1 || (powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b)
set "GDPI_CALLER=1"
call "%~dp0ortak.cmd" || exit /b 1

:menu
cls
echo ==================================================
echo   Discord'a VPN'siz giris
echo ==================================================
echo.
echo  Once 1'i dene. Discord yine acilmazsa veya
echo  "Update failed" derse buraya donup 2, 3, 4'u dene.
echo.
echo   1 - Standart ayar
echo   2 - Alternatif A
echo   3 - Alternatif B
echo   4 - Alternatif C
echo   5 - Cikis (her seyi kapat)
echo.
choice /c 12345 /n /m "Numara bas (1-5): "
set "MODE=%errorlevel%"
if "%MODE%"=="5" goto cikis
if "%MODE%"=="1" set "GDPI_ARGS=-5 --set-ttl 5 %GDPI_DNS%"
if "%MODE%"=="2" set "GDPI_ARGS=-9 %GDPI_DNS%"
if "%MODE%"=="3" set "GDPI_ARGS=-6 --set-ttl 3 %GDPI_DNS%"
if "%MODE%"=="4" set "GDPI_ARGS=-5 %GDPI_DNS%"

echo.
echo [1/4] Discord ve eski GoodbyeDPI kapatiliyor...
taskkill /f /im Discord.exe >nul 2>&1
taskkill /f /im Update.exe >nul 2>&1
sc stop GoodbyeDPI >nul 2>&1
taskkill /f /im goodbyedpi.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo [2/4] Windows'un DNS hafizasi temizleniyor...
ipconfig /flushdns >nul

echo [3/4] GoodbyeDPI baslatiliyor (ayar %MODE%)...
start "GoodbyeDPI - KAPATMA" /min "%GDPI_EXE%" %GDPI_ARGS%
timeout /t 3 /nobreak >nul
tasklist /fi "imagename eq goodbyedpi.exe" | find /i "goodbyedpi.exe" >nul
if errorlevel 1 (
  echo.
  echo HATA: GoodbyeDPI calismadi. Antivirus engellemis olabilir.
  echo Bu ekranin fotografini cekip gonder.
  echo.
  pause
  goto menu
)
rem Calisan ayari otomatik-kur.cmd icin kaydet
> "%~dp0secilen-ayar.cmd" echo set "GDPI_ARGS=%GDPI_ARGS%"

echo [4/4] Discord aciliyor...
if exist "%LocalAppData%\Discord\Update.exe" (
  start "" "%LocalAppData%\Discord\Update.exe" --processStart Discord.exe
) else (
  echo Discord uygulamasi bulunamadi, kendin ac: Baslat menusu ^> Discord
)
echo.
echo --------------------------------------------------
echo  Tamam. Discord acilana kadar 1 dakika bekle.
echo  Bu pencereyi KAPATMA (kapatirsan Discord gider).
echo.
echo  Acilmadiysa / "Update failed" derse: bir tusa bas,
echo  menuden baska numara sec.
echo --------------------------------------------------
pause >nul
goto menu

:cikis
taskkill /f /im goodbyedpi.exe >nul 2>&1
exit /b
