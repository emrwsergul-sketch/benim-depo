@echo off
rem Ortak ayarlar: GoodbyeDPI indir ve parametreleri tanimla.
set "GDPI_VER=0.2.3rc3-2"
set "GDPI_URL=https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.2.3rc3/goodbyedpi-%GDPI_VER%.zip"
set "BASE=%~dp0"
set "GDPI_DIR=%BASE%goodbyedpi-%GDPI_VER%"

if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set "ARCH=x86_64") else if /i "%PROCESSOR_ARCHITEW6432%"=="AMD64" (set "ARCH=x86_64") else (set "ARCH=x86")
set "GDPI_EXE=%GDPI_DIR%\%ARCH%\goodbyedpi.exe"

rem Turkiye icin calisan ayarlar: DPI atlatma (-5 + TTL) ve DNS'i Yandex'e (1253 portu) yonlendirme
set "GDPI_ARGS=-5 --set-ttl 5 --dns-addr 77.88.8.8 --dns-port 1253 --dnsv6-addr 2a02:6b8::feed:0ff --dnsv6-port 1253"

if exist "%GDPI_EXE%" goto :eof
echo GoodbyeDPI indiriliyor...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12'; Invoke-WebRequest -UseBasicParsing '%GDPI_URL%' -OutFile '%BASE%gdpi.zip'; Expand-Archive -Force '%BASE%gdpi.zip' '%BASE%'; Remove-Item '%BASE%gdpi.zip'"
if not exist "%GDPI_EXE%" (
  echo HATA: GoodbyeDPI indirilemedi. Internet baglantini kontrol et.
  pause
  exit /b 1
)
