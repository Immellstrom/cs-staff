<?php
use Tygh\Registry;
use Tygh\Languages\Languages;
use Tygh\BlockManager\Block;
use Tygh\Tools\SecurityHelper;

if (!defined('BOOTSTRAP')) { die('Access denied'); }


function fn_get_staff($params = array(), $lang_code = CART_LANGUAGE, $items_per_page = 0)
{
    // Set default values to input params
    $default_params = array(
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    if (AREA == 'C') {
        $params['status'] = 'A';
    }

    $sortings = array(
        'firstname' => '?:staff_table.firstname',
        'lastname' => '?:staff_table.lastname',
        'position' => '?:staff_table.position',
        'status' => '?:staff_table.status',
        'creation_date' => '?:staff_table.creation_date',
    );

    $condition = $limit = $join = '';

    if (!empty($params['limit'])) {
        $limit = db_quote(' LIMIT 0, ?i', $params['limit']);
    }

    $sorting = db_sort($params, $sortings, 'firstname', 'asc');

    if (!empty($params['item_ids'])) {
        $condition .= db_quote(' AND ?:staff_table.staff_id IN (?n)', explode(',', $params['item_ids']));
    }

    if (!empty($params['firstname'])) {
        $condition .= db_quote(' AND ?:staff_table.firstname = ?s', $params['firstname']);
    }

    if (!empty($params['lastname'])) {
        $condition .= db_quote(' AND ?:staff_table.lastname = ?s', $params['lastname']);
    }

    if (!empty($params['position'])) {
        $condition .= db_quote(' AND ?:staff_table.position = ?s', $params['position']);
    }

    if (!empty($params['status'])) {
        $condition .= db_quote(' AND ?:staff_table.status = ?s', $params['status']);
    }

    if (!empty($params['creation_date'])) {
        $condition .= db_quote(' AND ?:staff_table.creation_date = ?s', $params['creation_date']);
    }

    if (!empty($params['period']) && $params['period'] != 'A') {
        list($params['time_from'], $params['time_to']) = fn_create_periods($params);
        $condition .= db_quote(' AND (?:staff_table.creation_date >= ?i AND ?:staff_table.creation_date <= ?i)', $params['time_from'], $params['time_to']);
    }

    $fields = array (
        '?:staff_table.staff_id',
        '?:staff_table.firstname',
        '?:staff_table.lastname',
        '?:staff_table.position',
        '?:staff_table.status',
        '?:staff_table.creation_date',
     
    );
   
    fn_set_hook('get_staff', $params, $condition, $sorting, $limit, $lang_code, $fields);

    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(*) FROM ?:staff_table");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $cs_staff = db_get_hash_array(
        "SELECT ?p FROM ?:staff_table " .
        "WHERE 1 ?p ?p ?p",
        'staff_id', implode(', ', $fields), $condition, $sorting, $limit
    );

    if (!empty($params['item_ids'])) {
        $cs_staff = fn_sort_by_ids($cs_staff, explode(',', $params['item_ids']), 'staff_id');
    }

    fn_set_hook('get_staff_post', $cs_staff, $params);

    return array($cs_staff, $params);
}

function fn_get_staff_data($staff_id, $lang_code = CART_LANGUAGE)
{
    // Unset all SQL variables
    $fields = $joins = array();
    $condition = '';

    $fields = array (
        '?:staff_table.staff_id',
        '?:staff_table.firstname',
        '?:staff_table.lastname',
        '?:staff_table.position',
        '?:staff_table.status',
        '?:staff_table.creation_date',
    );

    $condition = db_quote("WHERE ?:staff_table.staff_id = ?i", $staff_id);
    $condition .= (AREA == 'A') ? '' : " AND ?:staff_table.status IN ('A', 'H') ";

    fn_set_hook('get_staff_data', $staff_id, $lang_code, $fields, $condition);

    $cs_staff = db_get_row("SELECT " . implode(", ", $fields) . " FROM ?:staff_table " ." $condition");

    fn_set_hook('get_staff_data_post', $staff_id, $lang_code, $cs_staff);

    return $cs_staff;
}


function fn_delete_staff_by_id($staff_id)
{
    if (!empty($staff_id)) {
        db_query("DELETE FROM ?:staff_table WHERE staff_id = ?i", $staff_id);

        fn_set_hook('delete_staff', $staff_id);

        Block::instance()->removeDynamicObjectData('cs_staff', $staff_id);

    }
}


function fn_cs_staff_update_staff($data, $staff_id, $lang_code = DESCR_SL)
{
    SecurityHelper::sanitizeObjectData('staff', $data);

    if (isset($data['creation_date'])) {
        $data['creation_date'] = fn_parse_date($data['creation_date']);
    }

    if (!empty($staff_id)) {
        db_query("UPDATE ?:staff_table SET ?u WHERE staff_id = ?i", $data, $staff_id);

    } else {
        $staff_id = $data['staff_id'] = db_query("REPLACE INTO ?:staff_table ?e", $data);
    }

    return $staff_id;
}


