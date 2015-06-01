@echo off

echo --------------------------------
echo -      REGENERATE AUTOLOAD     -
echo --------------------------------

:: nom du repertoir du prjet dans /var
php bin\php\ezpgenerateautoloads.php

set /P INPUT=Press Enter to close