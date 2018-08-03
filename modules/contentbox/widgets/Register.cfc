component extends="contentbox.models.ui.BaseWidget" singleton{

	Register function init(required any controller){
		// super init
		super.init( arguments.controller );

		// Widget Properties
		setName("registrationForm");
		setVersion("1.0");
		setDescription("A widget that renders the user registration form.");
		setAuthor("Reuben Brown");
		//setAuthorURL("");
		setForgeBoxSlug("cbLogin");
		setIcon("wpforms");
		setCategory("Login");
		return this;
	}


	any function renderIt(){
		var content = runEvent(event='security:security.register',eventArguments=arguments);
		if( !isNull(content) ){
			return content;
		}
		return;
	}

}
