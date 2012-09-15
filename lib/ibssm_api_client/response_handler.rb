module IbssmApiClient
  class ResponseHandler 
    
    def handle(response)
      debug_response(response) if IbssmApiClient.debug
      body = ActiveSupport::JSON.decode(response.body)
      
      if response.code == '500'
        Rails.logger.info body["message"]
        raise IbssmApiError
      elsif response.code == '403'
        Rails.logger.info body["message"]
        Rails.logger.info "unauthenticated"
        raise IbssmAuthenticationError
      elsif response.code == '404'
        Rails.logger.info body["message"]
        raise IbssmNotFoundError             
      end    
    end    
    
    def debug_response(response)
      if response.blank? 
        logger.debug "IbssmApiClient>> NO response."
        return
      end
      
      logger.debug "IbssmApiClient>> response:"
      logger.debug "code: #{response.code}"
      logger.debug "cache control: #{response["cache-control"]}"
      logger.debug "content type: #{response["Content-Type"]}"
      logger.debug "token: #{response['X-Response-Token']}"    
      logger.debug "body: #{response.body}"
    end
    
  end
end

