@echo off

echo �������������������������������ͻ
echo �          DELETE CACHE          �
echo �������������������������������ͼ

:: nom du repertoir du prjet dans /var
set dir=pmg

echo deleting var\cache

rmdir var\cache /s /q

echo deleting var\%dir%\cache

rmdir var\%dir%\cache /s /q