module IbssmApiClient
  class User < Base
    
    def update(token,data)
      path = "users/update"
      response = post_data(token,path,{
        'coeus_user_id' => data['id'],
        'first_name' => data['first_name'],
        'last_name' => data['last_name'],
        'email' => data['email'],
        'username' => data['username'],
        'type' => data['type']
      })
      debug_response(response)
      response   
    end
    
    def create_staff(token,data)
      path = "users/create"
      roles = build_roles(data)
      response = post_data(token,path,{
        'coeus_user_id' => data['id'],
        'first_name' => data['first_name'],
        'last_name' => data['last_name'],
        'email' => data['email'],
        'username' => data['username'],
        'type' => data['type'],
        'roles' => roles
      })
      debug_response(response)
      response         
    end
    
    def build_roles(data)
      puts "Adding roles to Symfony: #{data['roles']}"
      role_api = Role.new
      role_api.build_role_json_with_names(data['roles'])
    end
  end
end