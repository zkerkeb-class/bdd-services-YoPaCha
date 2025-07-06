@echo off
echo Starting PostgreSQL database service...

REM Load environment variables from .env file
if exist .env (
    echo Loading environment variables from .env file...
    for /f "usebackq tokens=1,2 delims==" %%a in (.env) do (
        if not "%%a"=="" if not "%%b"=="" (
            set "%%a=%%b"
        )
    )
) else (
    echo .env file not found, using default values...
    set DB_HOST=localhost
    set DB_PORT=4000
    set DB_NAME=storygenerator
    set DB_USER=storygen_user
    set DB_PASSWORD=storygen_password
)

REM Create database if it doesn't exist
createdb -h %DB_HOST% -p %DB_PORT% -U postgres %DB_NAME% 2>nul

REM Create user if it doesn't exist
psql -h %DB_HOST% -p %DB_PORT% -U postgres -c "CREATE USER %DB_USER% WITH PASSWORD '%DB_PASSWORD%';" 2>nul

REM Grant privileges
psql -h %DB_HOST% -p %DB_PORT% -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE %DB_NAME% TO %DB_USER%;" 2>nul

REM Run schema and initialization
psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d %DB_NAME% -f schema.sql
psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d %DB_NAME% -f init.sql

echo Database service started on port %DB_PORT%
pause