<?php

$schema['cs_staff'] = array (
    'content' => array (
        'cs_staff' => array (
           'type' => 'function',
           'function' => array('fn_get_staff'),
        ),
    ),

    'templates' => array (
        'addons/cs_staff/views/cs_staff/view.tpl' => array(),
    ),
    'wrappers' => 'blocks/wrappers',
    'brief_info_function' => 'fn_block_get_block_with_items_info'
);

return $schema;
