<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD']	== 'POST') {

    fn_trusted_vars('cs_staff', 'staff_data');
    $suffix = '';

    if ($mode == 'update') {
        $staff_id = fn_cs_staff_update_staff($_REQUEST['staff_data'], $_REQUEST['staff_id'], DESCR_SL);

        $suffix = ".update?staff_id=$staff_id";
    }

    if ($mode == 'delete') {
        if (!empty($_REQUEST['staff_id'])) {
            fn_delete_staff_by_id($_REQUEST['staff_id']);
        }

        $suffix = '.manage';
    }

    return array(CONTROLLER_STATUS_OK, 'cs_staff' . $suffix);
}


if ($mode == 'update') {
    $cs_staff = fn_get_staff_data($_REQUEST['staff_id'], DESCR_SL);
    if (empty($cs_staff)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('cs_staff', $cs_staff);

} elseif ($mode == 'manage') {
	list($cs_staff, $params) = fn_get_staff($_REQUEST, DESCR_SL , Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign(array(
        'cs_staff'  => $cs_staff,
        'search' => $params,
    ));
}




