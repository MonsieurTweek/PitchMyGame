<?php /* #?ini charset="utf-8"?

[ImageMagick]
IsEnabled=false

[MIMETypeSettings]
Quality[]=image/jpeg;100

[AliasSettings]
AliasList[]=news_full
AliasList[]=news_list
AliasList[]=news_max_width
AliasList[]=project_list
AliasList[]=star_project
AliasList[]=video_thumbnail
AliasList[]=user_list

[news_full]
Filters[]
Filters[]=geometry/scalewidthdownonly=200
Filters[]=geometry/crop=200;200

[news_list]
Filters[]
Filters[]=geometry/scalewidthdownonly=120
Filters[]=geometry/crop=120;120

[news_max_width]
Filters[]
Filters[]=geometry/scalewidthdownonly=530

[project_list]
Filters[]
Filters[]=geometry/scalewidthdownonly=420
Filters[]=geometry/crop=420;150

[star_project]
Filters[]
Filters[]=geometry/scalewidthdownonly=285
Filters[]=geometry/crop=285;150

[video_thumbnail]
Filters[]
Filters[]=geometry/scalewidthdownonly=185
Filters[]=geometry/crop=185;104

[user_list]
Filters[]
Filters[]=geometry/scalewidthdownonly=150
Filters[]=geometry/crop=150;150

*/ ?>
