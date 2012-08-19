module IbssmApiClient
  class ResponseHandler 
    
    def handle(response)
      debug_response(response) if IBSSM_API_CONFIG["debug"]
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
      puts "API RESPONSE:"
      puts "code: #{response.code}"
      puts "cache control: #{response["cache-control"]}"
      puts "content type: #{response["Content-Type"]}"
      puts "token: #{response['X-Response-Token']}"    
      puts "body: #{response.body}"
    end
    
  end
end

