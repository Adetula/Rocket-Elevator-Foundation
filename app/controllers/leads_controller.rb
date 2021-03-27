class LeadsController < ApplicationController
    def sendGrid_email_sender
        # require 'sendgrid-ruby'
        mail = SendGrid::Mail.new
        mail.from = SendGrid::Email.new(email: 'olaadetula@gmail.com')
        custom = SendGrid::Personalization.new
        custom.add_to(SendGrid::Email.new(email: @lead[:email]))
        custom.add_dynamic_template_data({
            # Don't change the code below, keep it as it is
            subject: 'Greetings ' + @lead[:full_name_of_contact],  
            project_name: @lead.project_name
        })
        mail.add_personalization(custom)

        # Our template ID to display the one we want & our API key connector
        mail.template_id ='d-23cdd97cd72a426288b8dc1a91c92386'
        our_key = SendGrid::API.new(api_key: ENV['SENDGRID_API'])

        # Sends the info above to the API's website
        begin
          response = our_key.client.mail._('send').post(request_body: mail.to_json)
        rescue Exception => e
            puts e.message
        end

        # Print info into terminal
        puts response.status_code
        puts response.body
        puts response.headers
    end


    # POST /quotes or /quotes.json
    def create
        
        @lead = Lead.new(lead_params)
        
     #===================================================================================================
     # DECLARING VARIABLES  
     #===================================================================================================
        attachment = params["attachment"]
        #@lead.file_name = attachment
     
     #===================================================================================================
     # SAVER  
     #===================================================================================================
        @lead.save

     #===================================================================================================
     # PRINTS PARAMS INTO TERMINAL WINDOW
     #===================================================================================================
        puts "===========START================"
        puts params
        puts "=============END================"

     #===================================================================================================
     # FORM SUBMISSION & FILE ATTACHMENT LOGIC (converts into binary code, submission alert, redirecting, rendering, errors) 
     #===================================================================================================
        if attachment != nil
            @lead.attachment = attachment.read
            @lead.file_name = attachment.original_filename
        end  
        
        if @lead.save!
            # Redirect back
            redirect_back fallback_location: root_path, notice: "Your Request was successfully created and sent!"
            
            # Sender
            sendGrid_email_sender()
        end 
    end   
       
     #===================================================================================================
     # DEFINING @lead = Lead.new(lead_params) BELOW:
     #===================================================================================================

     # Only allow a list of trusted parameters through.
    def lead_params
        params.required(:leads).permit!
    end

    
end