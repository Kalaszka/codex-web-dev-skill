@echo off
REM Codex Web Dev Skill - Windows Installation Script
REM Requires: Codex installed, Git installed
REM Optional: Tailscale for multi-machine sync

setlocal enabledelayedexpansion

echo ===== Codex Web Dev Skill Installation (Windows) =====
echo.

REM Check if Codex is installed
where codex >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Codex not found. Please install Codex first.
    echo Visit: https://github.com/VoltAgent/codex
    pause
    exit /b 1
)

echo [OK] Codex found

REM Determine Codex skills directory
set CODEX_SKILLS_DIR=%APPDATA%\.codex\skills
echo Skills directory: %CODEX_SKILLS_DIR%

REM Create directory if it doesn't exist
if not exist "%CODEX_SKILLS_DIR%" (
    mkdir "%CODEX_SKILLS_DIR%"
)

REM Check if already installed
if exist "%CODEX_SKILLS_DIR%\codex-web-dev-skill" (
    echo [INFO] Updating existing installation...
    cd /d "%CODEX_SKILLS_DIR%\codex-web-dev-skill"
    git pull origin main
) else (
    echo [INFO] Cloning repository...
    cd /d "%CODEX_SKILLS_DIR%"
    git clone https://github.com/Kalaszka/codex-web-dev-skill.git
)

REM Copy skill config
echo [INFO] Configuring skill...
copy "%CODEX_SKILLS_DIR%\codex-web-dev-skill\codex-web-dev-skill.toml" "%CODEX_SKILLS_DIR%\"

REM Verify installation
if exist "%CODEX_SKILLS_DIR%\codex-web-dev-skill.toml" (
    echo [OK] Skill configuration installed
) else (
    echo [ERROR] Installation failed
    pause
    exit /b 1
)

REM Check Codex config
set CODEX_CONFIG=%APPDATA%\.codex\config.toml

if exist "%CODEX_CONFIG%" (
    findstr /M "codex-web-dev-skill" "%CODEX_CONFIG%" >nul
    if !errorlevel! equ 0 (
        echo [OK] Skill already in config
    ) else (
        echo [WARN] Please manually add 'codex-web-dev-skill' to [skills] active list in:
        echo %CODEX_CONFIG%
    )
) else (
    echo [WARN] Codex config not found at %CODEX_CONFIG%
    echo [WARN] Please create it and add: [skills]
    echo [WARN] active = ["codex-web-dev-skill"]
)

echo.
echo ===== Installation Complete =====
echo Skill installed at: %CODEX_SKILLS_DIR%\codex-web-dev-skill
echo.
echo Next: 
 echo 1. Add 'codex-web-dev-skill' to your Codex config
 echo 2. Restart Codex
echo.

REM Machine info
echo Machine Information:
echo Hostname: %COMPUTERNAME%
echo OS: Windows

REM Check Tailscale
where tailscale >nul 2>nul
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('tailscale ip -4 2^>nul') do set TAILSCALE_IP=%%i
    if not "!TAILSCALE_IP!"==" " (
        echo Tailscale IP: !TAILSCALE_IP!
    )
)

pause
