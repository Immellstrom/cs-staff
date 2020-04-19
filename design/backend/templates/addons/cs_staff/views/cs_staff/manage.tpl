{** cs_staff section **}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="cs_staff_form" class=" cm-hide-inputs" enctype="multipart/form-data">
<input type="hidden" name="fake" value="1" />
{include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id="pagination_contents_cs_staff"}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents_cs_staff"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{if $cs_staff}
<div class="table-responsive-wrapper">
    <table class="table table-middle table--relative table-responsive">
    <thead>
    <tr>
        <th width="1%" class="left mobile-hide">
            {include file="common/check_items.tpl" class="cm-no-hide-input"}</th>
        <th><a class="cm-ajax" href="{"`$c_url`&sort_by=firstname&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("first_name")}{if $search.sort_by == "firstname"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

        <th><a class="cm-ajax" href="{"`$c_url`&sort_by=lastname&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("last_name")}{if $search.sort_by == "lastname"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

        <th class="mobile-hide" width="5%"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

        {hook name="cs_staff:manage_header"}
        {/hook}
 
        <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=creation_date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("date")}{if $search.sort_by == "creation_date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
         <th width="6%" class="mobile-hide">&nbsp;</th>
    </tr>
    </thead>
    
    {foreach from=$cs_staff item=staff}
    
    <tr class="cm-row-status-{$staff.status|lower}">
        {assign var="allow_save" value=$staff|fn_allow_save_object:"cs_staff"}

        {if $allow_save}
            {assign var="no_hide_input" value="cm-no-hide-input"}
        {else}
            {assign var="no_hide_input" value=""}
        {/if}
 
        <td class="left mobile-hide">
            <input type="checkbox" name="staff_ids[]" value="{$cs_staff.staff_id}" class="cm-item {$no_hide_input}" /></td>
        <td class="{$no_hide_input}" data-th="{__("first_name")}">
            <a class="row-status" href="{"cs_staff.update?staff_id=`$staff.staff_id`"|fn_url}">{$staff.firstname}</a>
            {include file="views/companies/components/company_name.tpl" object=$staff}
        </td>

         <td class="{$no_hide_input}" data-th="{__("last_name")}">
            <a class="row-status" href="{"cs_staff.update?staff_id=`$staff.staff_id`"|fn_url}">{$staff.lastname}</a>
            {include file="views/companies/components/company_name.tpl" object=$staff}
        </td>

        <td class="right"  width="5%" data-th="{__("status")}">
            {include file="common/select_popup.tpl" id=$staff.staff_id status=$staff.status hidden=true object_id_name="staff_id" table="staff_table" popup_additional_class="`$no_hide_input` dropleft"}
        </td>
    
        <td class="right" data-th="{__("date")}">
           <div class="controls">
            {include file="common/calendar.tpl" date_id="creation_date_`$id`" date_name="staff[creation_date]" date_val=$staff.creation_date|default: "" start_year=$settings.Company.company_start_year}
            </div>
        </td>


        {hook name="cs_staff:manage_data"}
        {/hook}

        <td class="mobile-hide">
            {capture name="tools_list"}
                <li>{btn type="list" text=__("edit") href="cs_staff.update?staff_id=`$staff.staff_id`"}</li>
            {if $allow_save}
                <li>{btn type="list" class="cm-confirm" text=__("delete") href="cs_staff.delete?staff_id=`$staff.staff_id`" method="POST"}</li>
            {/if}
            {/capture}
            <div class="hidden-tools">
                {dropdown content=$smarty.capture.tools_list}
            </div>
        </td>
    </tr>
    {/foreach}

    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id="pagination_contents_cs_staff"}

{capture name="adv_buttons"}
    {hook name="cs_staff:adv_buttons"}
    {include file="common/tools.tpl" tool_href="cs_staff.add" prefix="top" hide_tools="true" title=__("cs_staff.add_staff") icon="icon-plus"}
    {/hook}
{/capture}

</form>

{/capture}

{capture name="sidebar"}
    {hook name="cs_staff:manage_sidebar"}
    {include file="common/saved_search.tpl" dispatch="cs_staff.manage" view_type="cs_staff"}
    {include file="addons/cs_staff/views/cs_staff/components/cs_staff_search_form.tpl" dispatch="cs_staff.manage"}
    {/hook}
{/capture}


{hook name="cs_staff:manage_mainbox_params"}
    {$page_title = __("cs_staff.staff_menu")}
    {$select_languages = false}
{/hook}

{include file="common/mainbox.tpl" title=$page_title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons select_languages=$select_languages sidebar=$smarty.capture.sidebar}

{** ad section **}