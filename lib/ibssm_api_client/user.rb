module IbssmApiClient
  class User < Base
    
    def create_staff(token,staff)
      path = "users/create"
      role_api = Role.new
      roles = role_api.build_role_json(staff.user.roles)
      response = post_data(token,path,{
        'coeus_user_id' => staff.user.id,
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