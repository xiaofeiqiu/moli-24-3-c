@ECHO OFF
echo ����ֹͣNginx����......
plugin\Process -k nginx.exe
plugin\Process -k nginx.exe
del /Q /F nginx\logs\nginx.pid
echo ����ֹͣPHP(FastCGI)����......
plugin\Process -k php-cgi.exe
plugin\Process -k mysqld.exe
del /Q /F mariadb\data\%COMPUTERNAME%.pid