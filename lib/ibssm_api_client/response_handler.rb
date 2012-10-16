module IbssmApiClient
  class ResponseHandler 
    
    def handle(response)
      debug_response(response) if IbssmApiClient.debug
      body = ActiveSupport::JSON.decode(response.body)
      
      if response.code == '500'
        puts body["message"]
        raise IbssmApiError
      elsif response.code == '403'
        puts body["message"]
        puts "unauthenticated"
        raise IbssmAuthenticationError
      elsif response.code == '404'
        puts body["message"]
        raise IbssmNotFoundError             
      end    
    end    
    
    def debug_response(response)
      puts "debugging response"
      if response.blank? 
        IbssmApiClient.logger.debug "IbssmApiClient>> NO response."
        return
      end
      
      puts "IbssmApiClient>> response:"
      puts "code: #{response.code}"
      puts "cache control: #{response["cache-control"]}"
      puts "content type: #{response["Content-Type"]}"
      puts "token: #{response['X-Response-Token']}"    
      puts "body: #{response.body}"
      
      IbssmApiClient.logger.debug "IbssmApiClient>> response:"
      IbssmApiClient.logger.debug "code: #{response.code}"
      IbssmApiClient.logger.debug "cache control: #{response["cache-control"]}"
      IbssmApiClient.logger.debug "content type: #{response["Content-Type"]}"
      IbssmApiClient.logger.debug "token: #{response['X-Response-Token']}"    
      IbssmApiClient.logger.debug "body: #{response.body}"
    end
    
  end
end

