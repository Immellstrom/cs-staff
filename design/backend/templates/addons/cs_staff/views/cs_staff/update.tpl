{if $cs_staff}
    {assign var="id" value=$cs_staff.staff_id}
{else}
    {assign var="id" value=0}
{/if}


{** staff section **}

{$allow_save = $cs_staff|fn_allow_save_object:"cs_staff"}
{$hide_inputs = ""|fn_check_form_permissions}

{capture name="mainbox"}


<form action="{""|fn_url}" method="post" class="form-horizontal form-edit{if !$allow_save || $hide_inputs} cm-hide-inputs{/if}" name="staff_form" enctype="multipart/form-data">
<input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
<input type="hidden" class="cm-no-hide-input" name="staff_id" value="{$id}" />

{capture name="tabsbox"}
    <div id="content_general">
        {hook name="cs_staff:general_content"}
        <div class="control-group">
            <label for="elm_cs_firstname" class="control-label cm-required">{__("first_name")}</label>
            <div class="controls">
            <input type="text" name="staff_data[firstname]" id="elm_cs_firstname" value="{$cs_staff.firstname}" size="25" class="input-large" /></div>
        </div>

        <div class="control-group">
            <label for="elm_cs_lastname" class="control-label cm-required">{__("last_name")}</label>
            <div class="controls">
            <input type="text" name="staff_data[lastname]" id="elm_cs_lastname" value="{$cs_staff.lastname}" size="25" class="input-large" /></div>
        </div>

        <div class="control-group">
            <label for="elm_cs_position" class="control-label cm-required">{__("cs_staff.position")}</label>
            <div class="controls">
            <input type="text" name="staff_data[position]" id="elm_cs_position" value="{$cs_staff.position}" size="25" class="input-large" /></div>
        </div>

        <div class="control-group">
            <label class="control-label" for="elm_cs_creation_date_{$id}">{__("creation_date")}</label>
            <div class="controls">
            {include file="common/calendar.tpl" date_id="elm_cs_creation_date_`$id`" date_name="staff_data[creation_date]" date_val=$cs_staff.creation_date|default:$smarty.const.TIME start_year=$settings.Company.company_start_year}
            </div>
        </div>

        {include file="common/select_status.tpl" input_name="staff_data[status]" id="elm_status" obj_id=$id obj=$cs_staff hidden=true}
        {/hook}
    <!--content_general--></div>
   
    <div id="content_addons" class="hidden clearfix">
        {hook name="cs_staff:detailed_content"}
        {/hook}
    <!--content_addons--></div>

    {hook name="cs_staff:tabs_content"}
    {/hook}

{/capture}

{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}


{capture name="buttons"}
    {if !$id}
        {include file="buttons/save_cancel.tpl" but_role="submit-link" but_target_form="staff_form" but_name="dispatch[cs_staff.update]"}
    {else}
        {include file="buttons/save_cancel.tpl" but_name="dispatch[cs_staff.update]" but_role="submit-link" but_target_form="staff_form" hide_first_button=$hide_first_button hide_second_button=$hide_second_button save=$id}
    {/if}
{/capture}

</form>

{/capture}


{notes}
    {hook name="cs_staff:update_notes"}
    {__("cs_staff.cs_staff_details_notes", ["[layouts_href]" => fn_url('block_manager.manage')])}
    {/hook}
{/notes}

{if !$id}
    {$title = __("cs_staff.new_staff")}
{else}
    {$title_start = __("cs_staff.editing_staff")}
    {$title_end = $cs_staff.cs_staff}
{/if}

{include file="common/mainbox.tpl"
    title_start=$title_start
    title_end=$title_end
    title=$title
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
    select_languages=false}

{** cs_staff section **}
