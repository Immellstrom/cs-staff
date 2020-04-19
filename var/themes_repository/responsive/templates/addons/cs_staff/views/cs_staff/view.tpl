
{if $cs_staff}
	<table class="ty-table cs-staff-table">
		<thead>
			<tr>
			    <th>{__("first_name")}</th>
			    <th>{__("last_name")}</th>
			    <th>{__("cs_staff.position")}</th>
			    <th>{__("date")}</th>
			</tr>
		</thead>
		<tbody>
	        {foreach from=$cs_staff item=staff}
	        <tr>
	            <td>{$staff.firstname}</td>
	            <td>{$staff.lastname}</td>
	            <td>{$staff.position}</td>
	            <td class="cs-staff-calenader"> 
	            	{include file="common/calendar.tpl" date_id="creation_date_`$id`" date_name="staff[creation_date]" date_val=$staff.creation_date|default: "" start_year=$settings.Company.company_start_year}
	            </td>
	        </tr>
	        {foreachelse}
	        <tr class="ty-table__no-items">
	            <td colspan="4"><p class="ty-no-items">{__("cs_staff.staff_no_orders")}</p></td>
	        </tr>
	    	{/foreach}
	    </tbody>
	</table>
{/if}

{capture name="mainbox_title"}{__("cs_staff.cs_staff_title")}{/capture}
