module IbssmApiClient
  class User < Base
    
    def create_staff(staff)
      path = "users/create"
      role_api = IbssmRoles.new
      roles = role_api.build_role_json(staff.user.roles)
      response = post_data(path,{'coeus_user_id' => staff.user.id,
                                      'roles' => roles,
                                      'first_name' => 'name',
                                      'last_name' => 'last',
                                      'email' => staff.user.email,
                                      'username' => staff.user.email,
                                      'type' => staff.class.name.downcase
                                      })
      debug_response(response)
      response         
    end
  end
end