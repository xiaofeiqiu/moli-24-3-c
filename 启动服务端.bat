@ECHO OFF
@cls
Color 0A
>"%tmp%\t.t" echo;WSH.Echo(/[\u4E00-\u9FFF]/.test(WSH.Arguments(0)))
for /f %%a in ('cscript -nologo -e:jscript "%tmp%\t.t" "%~dp0"') do if %%a neq 0 (goto ansierr) else goto startserver

:startserver
echo.
echo.
echo.
echo.
@echo  ****************************************************************************
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                            ħ������cgmsv����                             *
@echo  *                              www.cgmsv.com                               *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *        �м�ʹ�� Ctrl + C ��ʽ�رշ���˺���д N ���ر���վ���ݿ�!        *
@echo  *                                                                          *
@echo  *                  ����ᵼ����Ϸ��¼���Ż����ݿ��쳣!!!                   *
@echo  *                                                                          *
@echo  *                            5���ʼ��������                             *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  ****************************************************************************
echo.
echo.
echo.
echo.
echo.
@ECHO OFF
cscript /nologo %~dp0nmp\plugin\sleep.vbs 5000
@cls
Color 07
%~d0
cd %~dp0
del /q gmsv\gmsvlog*
del /q gmsv\log\*.log
del /q gmsv\log\*20*
del /q gmsv\Dengon\*
del /q gmsv\store\dungeon\*
del /q gmsv\store\house\*
del /q gmsv\store\itemcount\*
::del /q gmsv\store\*.txt
del /q gmsv\store\dungeonnpc.txt
del /q gmsv\store\dungeonencount.txt
del /q gmsv\store\dungeontech_area.txt
del /q gmsv\store\mapjob.txt
del /q gmsv\store\activedungeon.txt
del /q gmsv\store\makeseq.txt
del /q gmsv\store\itembox.txt
del /q gmsv\store\petmail.txt
del /q gmsv\store\*itemgold*
del /q gmsv\dump\*
::del /q nmp\mariadb\data\*logfile*
::del /q nmp\mariadb\data\ibdata*
::del /q nmp\mariadb\data\*.err
cd %~dp0nmp
for /f "tokens=3 delims=: " %%a in ('netstat -an') do (
if "%%a"=="3306" goto mysqlcheck
)
:check80port
for /f "tokens=3 delims=: " %%a in ('netstat -an') do (
if "%%a"=="80" goto nginxcheck
)

:runnmp
@cls
Color 07
call %~dp0nmp\nmp_run.bat
@cls
Color 07
cd %~dp0gmsv
for /f "tokens=1* delims=[" %%a in ('ver') do set b=%%b
set b=%b:* =%
if "%b:~0,3%"=="5.1" goto winxp
start /b /WAIT /AFFINITY 0x3 %~dp0gmsv\cgmsv.exe
cd %~dp0nmp
call %~dp0nmp\nmp_stop.bat
@ECHO OFF
Color 0A
echo.
echo.
echo.
echo.
@echo  ****************************************************************************
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                      (������Ѿ��ر�,��������˳�)                       *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  ****************************************************************************
echo.
echo.
echo.
echo.
@ECHO OFF
pause
exit

:winxp
start /b /WAIT %~dp0gmsv\cgmsv.exe
cd %~dp0nmp
call %~dp0nmp\nmp_stop.bat
@ECHO OFF
Color 0A
echo.
echo.
echo.
echo.
@echo  ****************************************************************************
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                      (������Ѿ��ر�,��������˳�)                       *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  ****************************************************************************
echo.
echo.
echo.
echo.
@ECHO OFF
pause
exit

:mysqlcheck
tasklist | find /i "mysqld.exe"
if "%errorlevel%"=="1" (goto portused3306) else (goto check80port)

:nginxcheck
tasklist | find /i "nginx.exe"
if "%errorlevel%"=="1" (goto portused80) else (goto runnmp)

:portused3306
@ECHO OFF
Color 0A
@cls
echo.
echo.
echo.
echo.
@echo  ****************************************************************************
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                   ��⵽���ݿ������ 3306 �˿��ѱ�ռ��                   *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                 ���潫�޷���������,���ȴ���˿�ռ������                  *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                            (��������˳�)                                *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  ****************************************************************************
echo.
echo.
echo.
echo.
echo.
@ECHO OFF
pause
exit

:portused80
@ECHO OFF
Color 0A
@cls
echo.
echo.
echo.
echo.
@echo  ****************************************************************************
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                      ��⵽��վ����� 80 �˿��ѱ�ռ��                    *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                   ���潫��������,��ע����ҳ�����޷�ʹ��!                 *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                         (�밴�����������������)                         *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  ****************************************************************************
echo.
echo.
echo.
echo.
echo.
@ECHO OFF
pause
@cls
goto runnmp

:ansierr
@ECHO OFF
Color 0A
@cls
echo.
echo.
echo.
echo.
@echo  ****************************************************************************
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *           ��⵽����˴��·���к�������,����˽��޷���������            *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *             �뽫������ļ����ƶ����������ĵ�·������������               *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  *                                                                          *
@echo  ****************************************************************************
echo.
echo.
echo.
echo.
@ECHO OFF
pause
exit