/**
* Manage system settings
*/
component extends="baseHandler"{

	// Dependencies
	property name="settingsService"		inject="id:settingService@bb";
	property name="htmlService"			inject="id:customHTMLService@bb";
	
	// index
	function index(event,rc,prc){
		event.paramValue("search","");
		event.paramValue("page",1);
		
		// Exit Handler
		rc.xehSaveHTML 		= "#prc.bbAdminEntryPoint#.customHTML.save";
		rc.xehRemoveHTML	= "#prc.bbAdminEntryPoint#.customHTML.remove";
		rc.xehEditorHTML	= "#prc.bbAdminEntryPoint#.customHTML.editor";
		
		// prepare paging plugin
		rc.pagingPlugin = getMyPlugin(plugin="Paging",module="blogbox");
		rc.paging 		= rc.pagingPlugin.getBoundaries();
		rc.pagingLink 	= event.buildLink('#prc.xehCustomHTML#.page.@page@?');
		
		// Append search to paging link?
		if( len(rc.search) ){ rc.pagingLink&="&search=#rc.search#"; }
		
		// get content pieces
		var entryResults = htmlService.search(search=rc.search,
											  offset=rc.paging.startRow-1,
											  max=prc.bbSettings.bb_paging_maxrows);
		rc.entries 		 = entryResults.entries;
		rc.entriesCount  = entryResults.count;
		
		// tab
		prc.tabSite				= true;
		prc.tabSite_customHTML	= true; 
		
		// view
		event.setView("customHTML/index");
	}
	
	// slugify remotely
	function slugify(event,rc,prc){
		event.renderData(data=getPlugin("HTMLHelper").slugify( rc.slug ),type="plain");
	}
	
	// editor
	function editor(event,rc,prc){
		// get new or persisted
		rc.content  = htmlService.get( event.getValue("contentID",0) );
		// exit handlers
		rc.xehContentSave = "#prc.bbAdminEntryPoint#.customHTML.save";
		rc.xehSlugify	  = "#prc.bbAdminEntryPoint#.customHTML.slugify";
		// view
		event.setView(view="customHTML/editor",layout="ajax");
	}
	
	// save html
	function save(event,rc,prc){
		
		// populate and get content
		var oContent = populateModel( htmlService.get(id=rc.contentID) );
		
		// validate it
		var errors = oContent.validate();
		if( !arrayLen(errors) ){
			// announce event
			announceInterception("bbadmin_preCustomHTMLSave",{content=oContent,contentID=rc.contentID});
			// save content
			htmlService.save( oContent );
			// announce event
			announceInterception("bbadmin_postCustomHTMLSave",{content=oContent});
			// Message
			getPlugin("MessageBox").info("Custom HTML saved! Isn't that majestic!");
		}
		else{
			getPlugin("MessageBox").warn(errorMessages=errors);
		}
		
		// relocate back to editor
		setNextEvent(prc.xehCustomHTML);
	}
	
	// remove
	function remove(event,rc,prc){
		event.paramValue("contentID","");
		event.paramValue("page","1");
		// check for length
		if( len(rc.contentID) ){
			// announce event
			announceInterception("bbadmin_preCustomHTMLRemove",{contentID=rc.contentID});
			// remove using hibernate bulk
			htmlService.deleteByID( listToArray(rc.contentID) );
			// announce event
			announceInterception("bbadmin_postCustomHTMLRemove",{contentID=rc.contentID});
			// message
			getPlugin("MessageBox").info("Custom HTML Content Removed!");
		}
		else{
			getPlugin("MessageBox").warn("No ID selected!");
		}
		setNextEvent(event=prc.xehCustomHTML,queryString="page=#rc.page#");
	}
	
}
