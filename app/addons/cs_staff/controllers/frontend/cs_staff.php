<?php


use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }


if ($mode == 'view') {
    $cs_staff = fn_get_staff($_REQUEST, DESCR_SL);

    Tygh::$app['view']->assign(array(
        'cs_staff'  => $cs_staff
    ));
}






