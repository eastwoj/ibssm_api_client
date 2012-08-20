require "net/http"
require "uri"

module IbssmApiClient
  class Base
    
    def initialize
      @@response_handler = IbssmApiClient::ResponseHandler.new
    end
    
    def base_url
      IBSSM_API_CONFIG["base_ibssm_api_url"] + IBSSM_API_CONFIG["ibssm_services"]
    end
    
    def set_token(token)
      @@token = token
    end
    
    def debug_response(response)
      @@response_handler.debug_response(response)
    end
    
    def exec_report
      path = 'exec-report';
      return get_data(path,'')
    end
    
    def find_all
      path = "list-all"
      return get_data(path,'')
    end
    
    # A short summary about the student profile
    def profile_summary(student_profile_id)
      path = "students/profileSummary"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
  
    # A detailed version of the student's profile
    def profile(student_profile_id)
      path = "students/profile"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def post_data(path,data)
      
       begin
          url = URI.parse(base_url + path)
          req = Net::HTTP::Post.new(url.path)

          req.add_field("X-Request-Token", @@token)
          req.set_form_data(data)
          
          if IBSSM_API_CONFIG["debug"]
            puts "API POST: #{url}"
            puts "token: #{@@token}"
            puts "data:"
            data.each do |k,v|
              puts "key: #{k}  value: #{v}"
            end
          end

          res = Net::HTTP.new(url.host, url.port).start do |http|
            http.request(req)
          end
          
        @@response_handler.handle(res)

        rescue Errno::ECONNREFUSED
          Rails.logger.info "Connection to IBSSM API refused"
          raise IbssmApiConnectionError
        rescue Timeout::Error
          Rails.logger.info "Connection to IBSSM API timed out"
          raise IbssmApiConnectionError
        rescue Net::ProtocolError
          Rails.logger.info "Protocol Error with connection to IBSSM API"
          raise IbssmApiConnectionError
        rescue IOError
          Rails.logger.info "Protocol Error with connection to IBSSM API"
          raise IbssmApiConnectionError
        end
      
    end
    
    def get_data(path,params)
      begin
        url = URI.parse(base_url + path)
        req = Net::HTTP::Get.new(url.path + params)
        req.add_field("X-Request-Token", @@token)
        Rails.logger.info "API REQUEST: #{url + params }"
        puts "API REQUEST: #{url + params }" if IBSSM_API_CONFIG["debug"]
        res = Net::HTTP.new(url.host, url.port).start do |http|
          http.request(req)
        end
        
        @@response_handler.handle(res)
        json = ActiveSupport::JSON.decode(res.body)
        
      rescue Errno::ECONNREFUSED
        Rails.logger.info "Connection to IBSSM API refused"
        raise IbssmApiConnectionError
      rescue Timeout::Error
        Rails.logger.info "Connection to IBSSM API timed out"
        raise IbssmApiConnectionError
      rescue Net::ProtocolError
        Rails.logger.info "Protocol Error with connection to IBSSM API"
        raise IbssmApiConnectionError
      rescue Net::HTTPInternalServerError
        Rails.logger.info "Internal server error with connection to IBSSM API"
        rails IbssmApiConnectionError
      rescue IOError
        Rails.logger.info "Protocol Error with connection to IBSSM API"
        raise IbssmApiConnectionError
      end 
      Rails.logger.info "JSON RETURN: #{json}"
      puts "JSON RETURN: #{json}"
      return json
    end
  end  
end
