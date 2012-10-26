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
        'type' => data['type'],
        'coeus_user_id' => data['id'],
        'type_id' => data['type_id'],
        'first_name' => data['first_name'],
        'last_name' => data['last_name'],
        'email' => data['email'],
        'username' => data['username'],
        'roles' => roles
      })
      debug_response(response)
      response         
    end
    
    def create_student(token,data)
      path = "students/create"
      response = post_data(token,path,{
        'coeus_user_id' => data['coeus_user_id'],
        'coeus_student_id' => data['coeus_student_id'],
        'first_name' => data['first_name'],
        'last_name' => data['last_name'],
        'email' => data['email']
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

