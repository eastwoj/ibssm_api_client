module IbssmApiClient
  class User < Base
    
    def create_staff(staff)
      path = "users/create"
      role_api = Role.new
      puts "roles in api" 
      staff.user.print_roles
      roles = role_api.build_role_json(staff.user.roles)
      puts "ROLES #{roles}"
      response = post_data(path,{'coeus_user_id' => staff.user.id,
                                      'roles' => roles,
                                      'first_name' => staff.first_name,
                                      'last_name' => staff.last_name,
                                      'email' => staff.user.email,
                                      'username' => staff.user.email,
                                      'type' => staff.class.name.downcase
                                      })
      debug_response(response)
      response         
    end
  end
end