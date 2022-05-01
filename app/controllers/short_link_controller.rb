class ShortLinkController < ApplicationController
    def post
        @transfer = Transfer.find_by_id(params[:id])
        tries = 0
        begin
            @transfer.sharable_link = get_short_link
            @transfer.save
            redirect_to request.referrer
        rescue ActiveRecord::RecordInvalid
            tries += 1
            unless tries > 10
                retry
            end
            raise e
        end
    end

    def show
        @transfer = Transfer.find_by(sharable_link: params[:url])
        unless @transfer.nil?
            redirect_to url_for(@transfer)
        else
            redirect_to 'errors/404', status: 404
        end
    end

    private
        def get_short_link
            charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
            return Array.new(6) { charset.sample }.join
        end
end
