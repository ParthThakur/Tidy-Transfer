class ShortLinkController < ApplicationController
    # Short link controller generates and processes short (tidy) links for 
    # the uploaded files.

    def post
        # Create a tidy link for a particular transfer.
        @transfer = Transfer.find_by_id(params[:id])
        tries = 0
        begin
            @transfer.sharable_link = get_short_link
            @transfer.save
            redirect_to request.referrer
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
        end
    end

    private
        def get_short_link
            # Generate a random 6 character string.
            charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
            return Array.new(6) { charset.sample }.join
        end
end
