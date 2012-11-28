module IbssmApiClient
  class Role < Base

    # updates a user by clearing his roles and assigning the symfony roles passed
    def update_all_roles(token,external_user_id,symfony_roles)
      path = "roles/update"
      response = post_data(token,path,{'coeus_user_id' => external_user_id, 'roles' => symfony_roles.to_json})
      debug_response(response)
      response      
    end
    
    # adds a role by symfony role name
    def add_role(token,external_user_id,symfony_role_name)
      path = "roles/add"
      response = post_data(token,path,{'coeus_user_id' => external_user_id, 'role' => symfony_role_name})
      debug_response(response)
      response
    end
    
    # removes the symfony role by name
    def remove_role(token,external_user_id,symfony_role_name)
      path = "roles/remove"
      response = post_data(token,path,{'coeus_user_id' => external_user_id, 'role' => symfony_role_name})
      debug_response(response)
      response
    end
    
    # returns a list of symfony roles for this user
    def roles(token,user_id)
      roles = Array.new
      path = "roles/show"
      response = get_data(token,path,'?coeus_user_id=' + user_id.to_s)
      if role_data = response["roles"]
        role_data.each do |role|
          roles << role['name']
        end
      end
      roles.to_json
    end
  end
end

