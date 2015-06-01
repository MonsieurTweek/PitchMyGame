@echo off

echo ษอออออออออออออออออออออออออออออออป
echo บ          DELETE CACHE          บ
echo ศอออออออออออออออออออออออออออออออผ

:: nom du repertoir du prjet dans /var
set dir=pmg

echo deleting var\cache

rmdir var\cache /s /q

echo deleting var\%dir%\cache

rmdir var\%dir%\cache /s /q