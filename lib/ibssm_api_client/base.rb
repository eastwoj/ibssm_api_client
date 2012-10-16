require "net/http"
require "uri"

module IbssmApiClient
  class Base
    
    def initialize
      @@response_handler = IbssmApiClient::ResponseHandler.new
    end
    
    def base_url
      IbssmApiClient.base_url
    end
    
    def debug_response(response)
      @@response_handler.debug_response(response)
    end
    
    def exec_report(token)
      path = 'exec-report';
      return get_data(token,path,'')
    end
    
    def find_all(token)
      path = "list-all"
      return get_data(token,path,'')
    end
    
    # A short summary about the student profile
    def profile_summary(token,student_profile_id)
      path = "students/profileSummary"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
  
    # A detailed version of the student's profile
    def profile(token,student_profile_id)
      path = "students/profile"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def post_data(token,path,data)
      
       if token.blank?  
         raise IbssmAuthenticationError.new("No authentication token found.")
       end
      
       begin
          url = URI.parse(base_url + path)
          req = Net::HTTP::Post.new(url.path)

          req.add_field("X-Request-Token", token)
          req.set_form_data(data)
          
            puts"IbssmApiClient>> POST: #{url}"
            puts "token: #{token}"
            puts "data:"
            data.each do |k,v|
              puts "key: #{k}  value: #{v}"
            end
          

            IbssmApiClient.logger.debug "IbssmApiClient>> POST: #{url}"
            IbssmApiClient.logger.debug "token: #{token}"
            IbssmApiClient.logger.debug "data:"
            data.each do |k,v|
              IbssmApiClient.logger.debug "key: #{k}  value: #{v}"
            end
            
            puts req

          res = Net::HTTP.new(url.host, url.port).start do |http|
            http.request(req)
          end
          
        @@response_handler.handle(res)

        rescue Errno::ECONNREFUSED
          IbssmApiClient.logger.info "Connection to IBSSM API refused"
          raise IbssmApiConnectionError
        rescue Timeout::Error
          IbssmApiClient.logger.info "Connection to IBSSM API timed out"
          raise IbssmApiConnectionError
        rescue Net::ProtocolError
          IbssmApiClient.logger.info "Protocol Error with connection to IBSSM API"
          raise IbssmApiConnectionError
        rescue IOError
          IbssmApiClient.logger.info "Protocol Error with connection to IBSSM API"
          raise IbssmApiConnectionError
        end
      
    end
    
    def get_data(token,path,params)
      begin
        url = URI.parse(base_url + path)
        req = Net::HTTP::Get.new(url.path + params)
        req.add_field("X-Request-Token", token)
        IbssmApiClient.logger.debug "IbssmApiClient>> GET: #{url + params }" 
        res = Net::HTTP.new(url.host, url.port).start do |http|
          http.request(req)
        end
        
        @@response_handler.handle(res)
        json = ActiveSupport::JSON.decode(res.body)
        
      rescue Errno::ECONNREFUSED
        IbssmApiClient.logger.info "Connection to IBSSM API refused"
        raise IbssmApiConnectionError
      rescue Timeout::Error
        IbssmApiClient.logger.info "Connection to IBSSM API timed out"
        raise IbssmApiConnectionError
      rescue Net::ProtocolError
        IbssmApiClient.logger.info "Protocol Error with connection to IBSSM API"
        raise IbssmApiConnectionError
      rescue Net::HTTPInternalServerError
        IbssmApiClient.logger.info "Internal server error with connection to IBSSM API"
        rails IbssmApiConnectionError
      rescue IOError
        IbssmApiClient.logger.info "Protocol Error with connection to IBSSM API"
        raise IbssmApiConnectionError
      end 
      json
    end
  end  
end
