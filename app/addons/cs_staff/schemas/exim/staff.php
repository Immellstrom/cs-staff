<?php

return array(
    'section' => 'staff',
    'pattern_id' => 'staff',
    'name' => __('cs_staff.staff_menu'),
    'key' => array('staff_id'),
    'table' => 'staff_table',
    'permissions' => array(
        'import' => 'manage_cs_staff',
        'export' => 'view_cs_staff',
    ),
    'export_fields' => array (
        'Staff id' => array(
            'db_field' => 'staff_id',
            'alt_key' => true,
        ),
        'First name' => array(
            'db_field' => 'firstname',
        ),
        'Last name' => array(
            'db_field' => 'lastname'
        ),
        'Position' => array(
            'db_field' => 'position'
        ),
        'Status' => array(
            'db_field' => 'status'
        ),
        'Date' => array (
            'db_field' => 'creation_date',
            'process_get' => array('fn_timestamp_to_date', '#this'),
            'convert_put' => array('fn_date_to_timestamp', '#this'),
            'default' => array('time')
        ),
    ),
);
