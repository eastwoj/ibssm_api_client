module IbssmApiClient
  class ResponseHandler 
    
    def handle(response)
      debug_response(response) if IbssmApiClient.debug
      body = ActiveSupport::JSON.decode(response.body)
      
      if response.code == '500'
        IbssmApiClient.logger.info body["message"]
        raise IbssmApiError
      elsif response.code == '403'
        IbssmApiClient.logger.info body["message"]
        IbssmApiClient.logger.info "unauthenticated"
        raise IbssmAuthenticationError
      elsif response.code == '404'
        IbssmApiClient.logger.info body["message"]
        raise IbssmNotFoundError             
      end    
    end    
    
    def debug_response(response)
      if response.blank? 
        IbssmApiClient.logger.debug "IbssmApiClient>> NO response."
        return
      end
      
      IbssmApiClient.debug "IbssmApiClient>> response:"
      IbssmApiClient.debug "code: #{response.code}"
      IbssmApiClient.debug "cache control: #{response["cache-control"]}"
      IbssmApiClient.debug "content type: #{response["Content-Type"]}"
      IbssmApiClient.debug "token: #{response['X-Response-Token']}"    
      IbssmApiClient.debug "body: #{response.body}"
    end
    
  end
end

