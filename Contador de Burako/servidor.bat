@echo off
chcp 65001 > nul
echo.
echo  ╔═══════════════════════════════════════╗
echo  ║     Contador de Burako — Servidor     ║
echo  ╚═══════════════════════════════════════╝
echo.

REM Buscar IP local de WiFi
set "LOCAL_IP="
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "127.0.0.1"') do (
  if not defined LOCAL_IP (
    set "RAW=%%a"
    setlocal enabledelayedexpansion
    set "LOCAL_IP=!RAW: =!"
    endlocal & set "LOCAL_IP=%LOCAL_IP%"
  )
)

if not defined LOCAL_IP set "LOCAL_IP=TU-IP"

echo  Desde tu celular (misma red WiFi), abre:
echo.
echo     http://%LOCAL_IP%:8080
echo.
echo  Manten esta ventana abierta mientras jugas.
echo  Presiona Ctrl+C para cerrar el servidor.
echo.
echo ─────────────────────────────────────────
echo.

python -m http.server 8080 2>nul
if %errorlevel% neq 0 (
  python3 -m http.server 8080 2>nul
)
if %errorlevel% neq 0 (
  echo.
  echo  [!] Python no encontrado.
  echo.
  echo  Instala Python desde: https://python.org/downloads
  echo  (Marcá la opcion "Add to PATH" durante la instalacion)
  echo.
  pause
)
