@echo off
echo Compilation du projet gRPC...
echo.

REM Vérifier si Maven est disponible
where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERREUR: Maven n'est pas installe ou n'est pas dans le PATH.
    echo.
    echo Veuillez:
    echo 1. Installer Maven depuis https://maven.apache.org/download.cgi
    echo 2. Ajouter Maven au PATH system
    echo 3. Ou utiliser votre IDE pour compiler le projet
    echo.
    pause
    exit /b 1
)

echo Maven trouve. Compilation en cours...
echo.

REM Nettoyer et compiler
call mvn clean compile

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Compilation reussie!
    echo ========================================
    echo.
    echo Les classes Protobuf ont ete generees dans:
    echo target\generated-sources\protobuf\
    echo.
) else (
    echo.
    echo ========================================
    echo ERREUR lors de la compilation
    echo ========================================
    echo.
)

pause

