<?php

$schema['central']['website']['items']['cs_staff.staff_menu'] = array(
	'attrs' => array(
        'class'=>'is-addon'
    ),   
    'position' => 0,
    'href' => 'cs_staff.manage'
);

if (fn_allowed_for('MULTIVENDOR') && !Registry::get('runtime.company_id') || fn_allowed_for('ULTIMATE')) {
    $schema['top']['administration']['items']['export_data']['subitems']['cs_staff.staff_menu'] = array(
	    'href' => 'exim.export?section=staff',
	    'position' => 501
	);

	$schema['top']['administration']['items']['import_data']['subitems']['cs_staff.staff_menu'] = array(
	    'href' => 'exim.import?section=staff',
	    'position' => 501
	);
}

return $schema;