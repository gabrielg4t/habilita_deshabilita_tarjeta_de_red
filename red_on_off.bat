@echo off
COLOR 0A
MODE con:cols=50 lines=30

:red
cls
echo ������������������������������������������ͻ
echo   Deshabilitar y Depurar Tarjeta de RED
echo ��������������������������������������������
echo �                                          �
echo �     1 ) Deshabilitar RED "Ethernet"      �
echo �     2 ) Habilitar RED    "Ethernet"      �
echo �     3 ) Depurar RED      "Ethernet"      �
echo �                                          �
echo �     4 ) Listar Interfaces de RED         �
echo �                                          �
echo �     5 ) Deshabilitar RED "Wi-Fi"         �
echo �     6 ) Habilitar RED    "Wi-Fi"         �
echo �     7 ) Depurar RED      "Wi-Fi"         �
echo �                                          �
echo �                                          �
echo ��������������������������������������������
echo                 [ github.com/rdz-lab ]
echo.
echo.
set /p clave= Ingresa un valor : 

if "%clave%"=="1" goto deshabilita
if "%clave%"=="2" goto habilita
if "%clave%"=="3" goto reiniciar
if "%clave%"=="4" goto listar
if "%clave%"=="5" goto deshabilitawifi
if "%clave%"=="6" goto habilitawifi
if "%clave%"=="7" goto reiniciarwifi
goto red

# ----------------------------------------------------------------------------------------------------

:deshabilita
set interface="Ethernet"
ipconfig | find %interface% >NUL

rem if errorlevel 1 goto LAN

if %errorlevel% EQU 1 goto inicio
:inicio
echo "Deshabilitando Interfaz Ethernet"
netsh interface set interface %interface% disabled
timeout -t 4 >> nul
goto red

# ----------------------------------------------------------------------------------------------------

:habilita
echo "Habilitando Interfaz Ethernet"
netsh interface set interface %interface% enable
timeout -t 4 >> nul
goto red

# ----------------------------------------------------------------------------------------------------

:reiniciar
set interface="Ethernet"
ipconfig | find %interface% >NUL

rem if errorlevel 1 goto LAN

if %errorlevel% EQU 1 goto r1
:r1
echo "Deshabilitando Interfaz Ethernet"
netsh interface set interface %interface% disabled
timeout -t 4 >> nul
goto depurando

:depurando
MODE con:cols=80 lines=30
cls
echo.
echo.
echo.
echo  [ 20%% ] �������۰����������������������� 
echo         Listando ARP                      
echo.
arp -a
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 30%% ] ��������۰����������������������
echo         Borrando ARP Cache
echo.
ipconfig /displaydns
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 40%% ] ������������۰������������������
echo         Listando DNS                   
echo.
ipconfig /displaydns
timeout -t 2 >> nul


cls
echo.
echo.
echo.
echo  [ 50%% ] ���������������۰���������������
echo         BOrrando DNS
echo.
ipconfig /flushdns
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 60%% ] �����������������۰�������������
echo         Depurando WINS
echo.
nbtstat -RR && nbtstat -r & nbtstat -c
nbtstat -RR
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 70%% ] ��������������������۰����������
echo         Depurando Winsock
echo.
netsh winsock reset
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 95%% ] �����������������������������۰�
echo      Renovando conex con adaptadores 
echo.
echo "Habilitando Interfaz Ethernet"
netsh interface set interface %interface% enable
timeout -t 4 >> nul
goto red


# ----------------------------------------------------------------------------------------------------

:deshabilitawifi
set interface2="Wi-Fi"
ipconfig | find %interface2% >NUL

rem if errorlevel 1 goto LAN

if %errorlevel% EQU 1 goto apaga_wifi
:apaga_wifi
echo "Deshabilitando Interfaz Wi-Fi"
netsh interface set interface %interface2% disabled
timeout -t 4 >> nul
goto red

# ----------------------------------------------------------------------------------------------------

:habilitawifi
netsh interface set interface %interface2% enable
timeout -t 4 >> nul
goto red

# ----------------------------------------------------------------------------------------------------

:reiniciarwifi
set interface2="Wi-Fi"
ipconfig | find %interface2% >NUL

rem if errorlevel 1 goto LAN

if %errorlevel% EQU 1 goto apaga_wifi
:apaga_wifi
echo "Deshabilitando Interfaz Wi-Fi"
netsh interface set interface %interface2% disabled
timeout -t 4 >> nul
goto depurando2

:depurando2
MODE con:cols=80 lines=30
cls
echo.
echo.
echo.
echo  [ 20%% ] �������۰����������������������� 
echo         Listando ARP                      
echo.
arp -a
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 30%% ] ��������۰����������������������
echo         Borrando ARP Cache
echo.
ipconfig /displaydns
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 40%% ] ������������۰������������������
echo         Listando DNS                   
echo.
ipconfig /displaydns
timeout -t 2 >> nul


cls
echo.
echo.
echo.
echo  [ 50%% ] ���������������۰���������������
echo         BOrrando DNS
echo.
ipconfig /flushdns
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 60%% ] �����������������۰�������������
echo         Depurando WINS
echo.
nbtstat -RR && nbtstat -r & nbtstat -c
nbtstat -RR
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 70%% ] ��������������������۰����������
echo         Depurando Winsock
echo.
netsh winsock reset
timeout -t 2 >> nul

cls
echo.
echo.
echo.
echo  [ 95%% ] �����������������������������۰�
echo      Renovando conex con adaptadores 
echo.
echo "Habilitando Interfaz Wi-Fi"
netsh interface set interface %interface2% enable
timeout -t 4 >> nul
goto red

# ----------------------------------------------------------------------------------------------------

:listar
cls
MODE con:cols=100 lines=20
echo ������������������������������������������ͻ
echo   Interfaces Disponibles
echo ��������������������������������������������
echo �                                          �
netsh interface show interface
echo �                                          �
echo ��������������������������������������������
echo                 [ github.com/rdz-lab ]
echo.
pause
goto red