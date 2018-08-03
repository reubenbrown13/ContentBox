<cfoutput>
<div class="container-fluid">
    <div class="col-md-4" id="login-wrapper">
        <div class="panel panel-primary animated fadeInDown">
            <div class="panel-heading">
                <h3 class="panel-title">
                   <i class="fa fa-key"></i> User Registration
                </h3>
            </div>
            <div class="panel-body">
	        	<!--- Render Messagebox. --->
				#getModel( "messagebox@cbMessagebox" ).renderit()#

                #html.startForm(
                	action		= prc.xehDoRegister,
                	ssl 		= event.isSSL(),
                	name		= "registerForm",
                	novalidate	= "novalidate",
                	class		= "form-horizontal"
                )#
					#html.hiddenField( name="_securedURL", value=rc._securedURL )#

					<!--- Registration Text --->
					<cfif len( prc.registrationText )>#prc.registrationText#</cfif>

                	<!--- Event --->
					#announceInterception( "cbadmin_beforeregisterForm" )#

	                <div class="form-group">
	                    <div class="col-md-12 controls">
	                        #html.textfield(
	                        	name			= "username",
	                        	required		= "required",
	                        	class			= "form-control",
	                        	value			= prc.rememberMe,
	                        	placeholder		= cb.r( "common.username@security" ),
	                        	autocomplete	= "off"
	                        )#
	                        <i class="fa fa-user"></i>
	                    </div>
	                </div>
	                <div class="form-group">
	                   <div class="col-md-12 controls">
	                        #html.passwordField(
	                        	name			= "password",
	                        	required		= "required",
	                        	class			= "form-control",
	                        	placeholder		= cb.r( "common.password@security" ),
	                        	autocomplete	= "off"
	                        )#
	                        <i class="fa fa-lock"></i>

	                    </div>
	                    <div class="col-md-12">
							<a href="#event.buildLink( prc.xehRegisterUser )#" class="help-block">#cb.r( "register@security" )#?</a>
						</div>
            </div>
            <div class="form-group">
            	<div class="col-md-12">
						</div>
					</div>
          <div class="form-group">
             <div class="col-md-12 text-center">
             		<button type="submit" class="btn btn-primary">
             			#cb.r( "common.login@security" )#
             		</button>
              </div>
          </div>

          <!--- Event --->
					#announceInterception( "cbadmin_afterregisterForm" )#

                #html.endForm()#
            </div>
        </div>
    </div>
</div>
</cfoutput>
