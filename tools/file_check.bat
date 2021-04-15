@echo off
title Hackermode File Integrity Check
SETLOCAL EnableDelayedExpansion

<NUL set /p="Windows "
wmic os get version

echo ^

System dll dependencies check
set dll_list=ADVAPI32.dll KERNEL32.dll SHELL32.dll USER32.dll OPENGL32.dll WINMM.dll IMM32.dll D3DCOMPILER_43.dll ole32.dll MFPlat.DLL MFReadWrite.dll d3d11.dll WS2_32.dll WLDAP32.dll Normaliz.dll CRYPT32.dll D3DCOMPILER_47.dll RTWorkQ.DLL schannel.dll mskeyprotect.dll winmmbase.dll wdmaud.drv ksuser.dll AVRT.dll msacm32.drv MSACM32.dll midimap.dll ncrypt.dll ncryptsslp.dll ntasn1.dll

(for %%f in (%dll_list%) do ( 
	if exist C:\Windows\System32\%%f (
		call :colorEcho 0A "[+] %%f found!"
        echo.
	) else (
		if exist C:\Windows\System\%%f (
			call :colorEcho 0A "[+] %%f  found!"
            echo.
		) else (
			if exist C:\Windows\SysWOW64\%%f (
				call :colorEcho 0A "[+] %%f found!"
				echo.
			) else (
				if exist C:\Windows\WinSxS\%%f (
		        	call :colorEcho 0A "[+] %%f found!"
                    echo.
				) else (
					call :colorEcho 0C "[ ] %%f not found!"
                    echo.
				)
			)
		)
	)
))

pause>nul
exit

:colorEcho
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i