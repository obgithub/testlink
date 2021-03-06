{*
	Testlink Open Source Project - http://testlink.sourceforge.net/
	$Id: navBar.tpl,v 1.52 2010/02/12 08:47:12 erikeloff Exp $
	Purpose: smarty template - title bar + menu

	rev :
		20100212 - eloff - BUGID 3103 - remove js-timeout alert in favor of BUGID 3088
		20100131 - franciscom - moved get_docs() to javascript library
		20090902 - timeout warning 
		20080504 - access to local documentation
		20080211 - changes action for user management
		20070331 - BUGID 760 - added truncate to fix
* ----------------------------------------------------------------- *}
{lang_get var="labels"
          s="title_events,event_viewer,home,testproject,title_specification,title_execute,
             title_edit_personal_data,th_tcid,link_logout,title_admin,
             search_testcase,title_results,title_user_mgmt"}
{assign var="cfg_section" value=$smarty.template|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

{include file="inc_head.tpl" openHead="yes"}
</head>
<body style="min-width: 800px;">
<div style="float:left; height: 100%;">
	<a href="index.php" target="_parent">
	<img alt="Company logo"	title="logo" style="width: 130px; height: 50px;" 
	src="{$smarty.const.TL_THEME_IMG_DIR}{$tlCfg->company_logo}" /></a>
</div>
	
<div class="menu_title">

	{if $gui->TestProjects != ""}
	<div style="float: right; padding: 2px;">
		<form name="productForm" action="lib/general/navBar.php" method="get">
			<span style="font-size: 80%">{$labels.testproject}</span>
			<select class="menu_combo" name="testproject" onchange="this.form.submit();">
	      	{foreach key=tproject_id item=tproject_name from=$gui->TestProjects}
	  		  <option value="{$tproject_id}" title="{$tproject_name|escape}"
	  		    {if $tproject_id == $gui->tprojectID} selected="selected" {/if}>
	  		    {$tproject_name|truncate:#TESTPROJECT_TRUNCATE_SIZE#|escape}</option>
	  		{/foreach}
			</select>
		</form>
	</div>
	{/if}

	<span class="bold">TestLink {$tlVersion|escape} : {$gui->whoami|escape}</span>

</div>

<div class="menu_bar" style="margin: 0px 5px 0px 135px;">

	<span style="float: right;">
   		<a href='lib/usermanagement/userInfo.php' target="mainframe" accesskey="i"
      		tabindex="6">{$labels.title_edit_personal_data}</a>
	 | 	<a href="logout.php" target="_parent" accesskey="q">{$labels.link_logout}</a>
	</span>

	{$session.testprojectTopMenu}

{if $gui->tprojectID}

	{if $gui->grants->view_testcase_spec == "yes"}
		<form style="display:inline" target="mainframe" name="searchTC" id="searchTC"
		      action="lib/testcases/archiveData.php" method="get">
		<span style="font-size: 80%">{$labels.th_tcid}: </span>
		<input style="font-size: 80%;" type="text" size="{$gui->searchSize}"
		       title="{$labels.search_testcase}" name="targetTestCase" value="{$gui->tcasePrefix}" />
    	{* useful to avoid a call to method to get test case prefix in called page*}
		<input type="hidden" id="tcasePrefix" name="tcasePrefix" value="{$gui->tcasePrefix}" />
		<img src="{$smarty.const.TL_THEME_IMG_DIR}/magnifier.png"
		     title="{$labels.search_testcase}" alt="{$labels.search_testcase}"
		     onclick="document.getElementById('searchTC').submit()" class="clickable" />
		<input type="hidden" name="edit" value="testcase"/>
		<input type="hidden" name="allow_edit" value="0"/>
		</form>
	{/if}
{/if}
</div>

{if $gui->updateMainPage == 1}
{literal}
<script type="text/javascript">
	parent.mainframe.location = "{/literal}{$basehref}{literal}lib/general/mainPage.php";
</script>
{/literal}
{/if}

</body>
</html>
