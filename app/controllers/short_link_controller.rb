class ShortLinkController < ApplicationController
    # Short link controller generates and processes short (tidy) links for 
    # the uploaded files.
    skip_before_action :authenticate_user!, only: :show

    def post
        # Create a tidy link for a particular transfer.
        @transfer = Transfer.find_by_id(params[:id])
        tries = 0
        begin
            @transfer.sharable_link = get_short_link
            @transfer.save
            if request.referrer
                redirect_to request.referrer
            else
                redirect_to user_url(current_user)
            end
        rescue ActiveRecord::RecordInvalid
            # Generate a new link if generated link already exists.
            tries += 1
            unless tries > 10
                # Regenerate the link only 10 times. If a random 6 character string isn't
                # found after 10 tries, no need to keep trying indefinitly.
                retry
            end
            raise e
        end
    end

    def show
        # Prosess the tidy link and display the proper file.
        @transfer = Transfer.find_by(sharable_link: params[:url])
        
        if @transfer.nil?
            redirect_to 'errors/404', status: 404
        else
            @blob_url = rails_blob_path(@transfer.file)
        end

        if current_user == @transfer.user
            redirect_to transfer_url(@transfer)
        end
    end

    private
        def get_short_link
            # Generate a random 6 character string.
            charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
            return Array.new(6) { charset.sample }.join
        end
end
