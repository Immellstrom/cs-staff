<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'view') {
    list($cs_staff, $params) = fn_get_staff($_REQUEST);

    Tygh::$app['view']->assign(array(
        'cs_staff'  => $cs_staff,
        'search' => $params,
    ));
}






