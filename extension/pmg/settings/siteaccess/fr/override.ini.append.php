<?php /* #?ini charset="utf-8"?

# Override Summary
# 0 - Block
# 1 - Medias
# 2 - Homepage
# 3 - News 
# 4 - News container
# 5 - Project
# 6 - Project container
# 7 - Event
# 8 - Events container
# 9 - Image
# 10 - Page
# 11 - Feedback
# 12 - Page équipe
# 13 - User

# -------------------------------------------------------------
# 0 - Block

[embed_block]
Source=block/view/view.tpl
MatchFile=block/embed_block.tpl
Subdir=templates
Match[type]=EmbedBlock

[next_event_block]
Source=block/view/view.tpl
MatchFile=block/next_event_block.tpl
Subdir=templates
Match[type]=NextEventBlock

[related_content_block]
Source=block/view/view.tpl
MatchFile=block/related_content_block.tpl
Subdir=templates
Match[type]=RelatedContent

[related_project_block]
Source=block/view/view.tpl
MatchFile=block/related_project_block.tpl
Subdir=templates
Match[type]=RelatedProject

[related_news_block]
Source=block/view/view.tpl
MatchFile=block/related_news_block.tpl
Subdir=templates
Match[type]=RelatedNews

# -------------------------------------------------------------
# 1 - Medias

[embed_file]
Source=content/view/embed.tpl
MatchFile=embed/file.tpl
Subdir=templates
Match[class_identifier]=file

[embed_image]
Source=content/view/embed.tpl
MatchFile=embed/image.tpl
Subdir=templates
Match[class_identifier]=image

# -------------------------------------------------------------
# 2 - Homepage

[full_homepage]
Source=node/view/full.tpl
MatchFile=full/homepage.tpl
Subdir=templates
Match[class_identifier]=homepage

# -------------------------------------------------------------
# 3 - News

[list_news]
Source=node/view/list.tpl
MatchFile=list/news.tpl
Subdir=templates
Match[class_identifier]=news

[embed_news]
Source=node/view/embed.tpl
MatchFile=embed/news.tpl
Subdir=templates
Match[class_identifier]=news

[full_news]
Source=node/view/full.tpl
MatchFile=full/news.tpl
Subdir=templates
Match[class_identifier]=news

[line_news]
Source=node/view/line.tpl
MatchFile=line/news.tpl
Subdir=templates
Match[class_identifier]=news

# -------------------------------------------------------------
# 4 - News container

[block_news_container]
Source=node/view/block.tpl
MatchFile=block/news_container.tpl
Subdir=templates
Match[class_identifier]=news_container

[embed_news_container]
Source=node/view/embed.tpl
MatchFile=embed/news_container.tpl
Subdir=templates
Match[class_identifier]=news_container

# -------------------------------------------------------------
# 5 - Project

[full_project]
Source=node/view/full.tpl
MatchFile=full/project.tpl
Subdir=templates
Match[class_identifier]=project

[embed_project]
Source=node/view/embed.tpl
MatchFile=embed/project.tpl
Subdir=templates
Match[class_identifier]=project

[list_project]
Source=node/view/list.tpl
MatchFile=list/project.tpl
Subdir=templates
Match[class_identifier]=project

# -------------------------------------------------------------
# 6 - Project container

[full_projects_container]
Source=node/view/full.tpl
MatchFile=full/projects_container.tpl
Subdir=templates
Match[class_identifier]=projects_container

# -------------------------------------------------------------
# 7 - Event

[block_event]
Source=node/view/block.tpl
MatchFile=block/next_event_block.tpl
Subdir=templates
Match[class_identifier]=event

[embed_event]
Source=node/view/embed.tpl
MatchFile=embed/event.tpl
Subdir=templates
Match[class_identifier]=event

[list_event]
Source=node/view/list.tpl
MatchFile=list/event.tpl
Subdir=templates
Match[class_identifier]=event

[footer_event]
Source=node/view/footer.tpl
MatchFile=footer/event.tpl
Subdir=templates
Match[class_identifier]=event

# -------------------------------------------------------------
# 8 - Events container

[full_events_container]
Source=node/view/full.tpl
MatchFile=full/events_container.tpl
Subdir=templates
Match[class_identifier]=events_container

# -------------------------------------------------------------
# 9 - Image

[slideshow_image]
Source=node/view/slideshow.tpl
MatchFile=slideshow/image.tpl
Subdir=templates
Match[class_identifier]=image

# -------------------------------------------------------------
# 10 - Page

[full_page]
Source=node/view/full.tpl
MatchFile=full/page.tpl
Subdir=templates
Match[class_identifier]=page

# -------------------------------------------------------------
# 11 - Feedback

[full_feedback]
Source=node/view/full.tpl
MatchFile=full/feedback.tpl
Subdir=templates
Match[class_identifier]=feedback

# -------------------------------------------------------------
# 12 - Page équipe

[full_team_page]
Source=node/view/full.tpl
MatchFile=full/team_page.tpl
Subdir=templates
Match[class_identifier]=team_page

# -------------------------------------------------------------
# 13 - User

[list_user]
Source=node/view/list.tpl
MatchFile=list/user.tpl
Subdir=templates
Match[class_identifier]=user



*/ ?>
