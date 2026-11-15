@echo off
rem BU DOSYAYA TIKLAMA. discord-baslat.cmd bunu kendisi kullanir.
if not defined GDPI_CALLER (
  echo.
  echo Bu dosyaya tiklaman gerekmiyor.
  echo Bunun yerine "discord-baslat.cmd" dosyasina cift tikla.
  echo.
  pause
  exit /b 1
)
set "GDPI_VER=0.2.3rc3-2"
set "GDPI_URL=https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.2.3rc3/goodbyedpi-%GDPI_VER%.zip"
set "BASE=%~dp0"
set "GDPI_DIR=%BASE%goodbyedpi-%GDPI_VER%"

if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set "ARCH=x86_64") else if /i "%PROCESSOR_ARCHITEW6432%"=="AMD64" (set "ARCH=x86_64") else (set "ARCH=x86")
set "GDPI_EXE=%GDPI_DIR%\%ARCH%\goodbyedpi.exe"

rem DNS'i Yandex'e (1253 portu) yonlendir: operatorun sahte DNS cevabini atlatir
set "GDPI_DNS=--dns-addr 77.88.8.8 --dns-port 1253 --dnsv6-addr 2a02:6b8::feed:0ff --dnsv6-port 1253"
set "GDPI_ARGS=-5 --set-ttl 5 %GDPI_DNS%"
rem discord-baslat.cmd'de calisan ayar secildiyse onu kullan
if exist "%BASE%secilen-ayar.cmd" call "%BASE%secilen-ayar.cmd"

if exist "%GDPI_EXE%" exit /b 0
echo GoodbyeDPI indiriliyor...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12'; Invoke-WebRequest -UseBasicParsing '%GDPI_URL%' -OutFile '%BASE%gdpi.zip'; Expand-Archive -Force '%BASE%gdpi.zip' '%BASE%'; Remove-Item '%BASE%gdpi.zip'"
if exist "%GDPI_EXE%" exit /b 0
echo.
echo HATA: GoodbyeDPI indirilemedi veya antivirus sildi.
echo Antivirusun karantinasina bak, "goodbyedpi" veya "WinDivert" varsa geri yukle / izin ver.
pause
exit /b 1
