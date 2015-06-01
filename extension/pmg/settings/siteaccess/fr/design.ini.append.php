<?php /* #?ini charset="utf-8"?

# -------------------------------------------------------------
# CSS

[StylesheetSettings]
CSSFileList[]=reset.css
CSSFileList[]=pagelayout.css
CSSFileList[]=common.css
CSSFileList[]=konami/fonts.css
CSSFileList[]=konami/layout.css
CSSFileList[]=libs/flexslider.css
CSSFileList[]=libs/fancybox/source/jquery.fancybox.css

CSSFileListSpec[]
# Exemple (conditions acceptees : class_identifier, section, context_ui, ui_component...)
# fichier : fichier sans l'extension !
#CSSFileListSpec[ficher]=condition;valeur,valeur,valeur...
#CSSFileListSpec[ficher]=class_identifier;homepage,contact
CSSFileListSpec[class/homepage]=class_identifier;homepage
CSSFileListSpec[class/news_container]=class_identifier;news,project
CSSFileListSpec[class/news]=class_identifier;news,homepage
CSSFileListSpec[class/project]=class_identifier;project,homepage,projects_container
CSSFileListSpec[class/projects_container]=class_identifier;projects_container
CSSFileListSpec[class/event]=class_identifier;event,homepage,news,project,events_container
CSSFileListSpec[class/events_container]=class_identifier;events_container
CSSFileListSpec[class/page]=class_identifier;page
CSSFileListSpec[class/feedback]=class_identifier;contact_form
CSSFileListSpec[class/user]=class_identifier;user,team_page

#CSSFileListIE[]=ie.css

#CSSFileListIE6[]=ie6.css

# -------------------------------------------------------------
# JS

[JavaScriptSettings]
JSFileListInit[]=libs/jquery.min.js
JSFileListInit[]=libs/jquery-ui.min.js
JSFileListInit[]=libs/jquery.flexslider-min.js
JSFileListInit[]=libs/fancybox/source/jquery.fancybox.pack.js

JSFileListInitIE6[]=libs/iepngfix_tilebg.js

JSFileListFirst[]

JSFileList[]=libs/jquery.swfobject.1-1-1.min.js
JSFileList[]=libs/jquery.input_replacement.pack.js
JSFileList[]=application.js

# Konami Game
# Core
#JSFileList[]=konami/core/misc/functions.js
#JSFileList[]=konami/core/misc/Input.js
#JSFileList[]=konami/core/lib/ImageInGame/IIG.js
# Main
#JSFileList[]=konami/main/Game.js
#JSFileList[]=konami/main/Player.js
#JSFileList[]=konami/main/PlayerManager.js
#JSFileList[]=konami/main/Enemy.js
#JSFileList[]=konami/main/EnemyManager.js
#JSFileList[]=konami/main/Projectile.js
#JSFileList[]=konami/main/Gauge.js
# Conf
#JSFileList[]=konami/conf/game.cfg.js
#JSFileList[]=konami/conf/player.cfg.js
#JSFileList[]=konami/conf/playerManager.cfg.js
#JSFileList[]=konami/conf/enemy.cfg.js
#JSFileList[]=konami/conf/projectile.cfg.js
#JSFileList[]=konami/conf/gauge.cfg.js

# Exemple (conditions acceptees : class_identifier, section, context_ui, ui_component...)
# fichier : fichier sans l'extension !
#JSFileListSpec[ficher]=condition;valeur,valeur,valeur...
#JSFileListSpec[ficher]=class_identifier;homepage,contact
JSFileListSpec[class/events]=class_identifier;event,homepage,news,project,events_container
JSFileListSpec[class/news]=class_identifier;news,project
JSFileListSpec[class/projects]=class_identifier;projects_container,project

#JSFileListIE[]=

#JSFileListIE6[]=

*/ ?>
