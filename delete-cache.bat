@echo off

echo 浜様様様様様様様様様様様様様様様�
echo �          DELETE CACHE          �
echo 藩様様様様様様様様様様様様様様様�

:: nom du repertoir du prjet dans /var
set dir=pmg

echo deleting var\cache

rmdir var\cache /s /q

echo deleting var\%dir%\cache

rmdir var\%dir%\cache /s /q