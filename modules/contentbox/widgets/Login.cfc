component extends="contentbox.models.ui.BaseWidget" singleton{

	Login function init(required any controller){
		// super init
		super.init( arguments.controller );

		// Widget Properties
		setName("loginForm");
		setVersion("1.0");
		setDescription("A widget that renders the user login form.");
		setAuthor("Reuben Brown");
		//setAuthorURL("");
		setForgeBoxSlug("cbLogin");
		setIcon("wpforms");
		setCategory("Login");
		return this;
	}


	any function renderIt(){
		var content = runEvent(event='security:security.login',eventArguments=arguments);
		if( !isNull(content) ){
			return content;
		}
		return;
	}

}
