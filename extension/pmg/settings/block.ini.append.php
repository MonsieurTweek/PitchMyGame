<?php /*

[General]
#AllowedTypes[]=News
AllowedTypes[]=EmbedBlock
AllowedTypes[]=NextEventBlock
AllowedTypes[]=RelatedContent
AllowedTypes[]=RelatedProject
AllowedTypes[]=RelatedNews

#[Example]
# Name of the block type as shown in the editorial interface.
# Name=Fetch Name Shown In Editorial Interface
# ManualAddingOfItems=disabled|enabled
# CustomAttributes[]=node_id
# UseBrowseMode[node_id]=true
# CustomAttributes[]=number
# CustomAttributeName[number]=Number
# CustomAttributeTypes[number]=checkbox|text|string
#
# Used by browse mode for manual block,
# possibility to limit block items to specific class
# AllowedClasses[]=article
# possibility to limit block items to specific zone
# AllowedZones[]=sidebar

[EmbedBlock]
Name=Objet embarqué
ManualAddingOfItems=disabled
CustomAttributes[]=embed
UseBrowseMode[embed]=true
CustomAttributeName[embed]=Objet embarqué
AllowedZones[]=right_sidebar
AllowedZones[]=sidebar

[NextEventBlock]
Name=Prochain évènement
ManualAddingOfItems=disabled
AllowedZones[]=right_sidebar
AllowedZones[]=sidebar

[RelatedContent]
Name=Contenu lié
ManualAddingOfItems=disabled
AllowedZones[]=right_sidebar
AllowedZones[]=sidebar

[RelatedProject]
Name=Projets similaires
ManualAddingOfItems=disabled
AllowedZones[]=right_sidebar
AllowedZones[]=sidebar

[RelatedNews]
Name=News du projet
ManualAddingOfItems=disabled
AllowedZones[]=right_sidebar
AllowedZones[]=sidebar


*/ ?>