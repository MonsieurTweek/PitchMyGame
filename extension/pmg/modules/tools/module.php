<?php

$Module = array( 'name' => 'PitchMyGame Module' );

$ViewList['news_pager'] = array(
        'script' => 'news_pager.php',
        'params' => array( 'Offset', 'Limit', 'Direction', 'NodeID' )
);

$ViewList['post_to_view'] = array(
        'script' => 'post_to_view.php'
);

?>
