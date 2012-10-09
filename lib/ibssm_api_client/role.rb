module IbssmApiClient
  class Role < Base

    # def update_role(user,role_name,token)
      # path = "roles/update"
      # role_name = ibssm_role_for_coeus_role(role_name)
      # payload = build_role_json([role_name])
      # post_data(path,token,{'coeus_user_id' => user.id, 'roles' => payload})      
    # end
    
    def update_all_roles(token,user)
      path = "roles/update"
      payload = build_role_json(user.roles)
      response = post_data(token,path,{'coeus_user_id' => user.id, 'roles' => payload})
      debug_response(response)
      response      
    end
    
    private
      
    def build_role_json(roles)
      bucket = Array.new
      roles.each do |role|
        bucket << ibssm_role_for_coeus_role(role.name)
      end
      bucket.to_json
    end
    
    def ibssm_role_for_coeus_role(role_name)
      dictionary = {
        'office_staff' => 'g-office_staff',
        'intern' => 'g-intern', 
        'staff' => 'g-staff',
        'student' => 'g-student',
        'admin' => 'g-administrator',
        'root' => 'g-superuser',
        '1st_year_approver' => 'g-approve_first_year',
        'authenticate_attendance_stations' => 'authenticate_attendance_stations',
        '1st_year_interviewer' => 'interview_first_year_students',
        '2nd_year_interviewer' => 'interview_2nd_year_students', 
        'application_viewer' => 'view_applications',
        'travel_admin' => 'travel_admin',
        'travel_manager' => 'travel_manager',
        'travel_leader' => 'travel_leader',
        'travel_finance_admin' => 'travel_finance_admin',
        'travel_viewer' => 'view_travel',
        'api_admin' => 'api_admin',
        '2nd_year_approver' => 'accept_2nd_year_students',
        'missions_staff' => 'missions_staff',
        'missions_finance_admin' => 'missions_finance_admin',
        'missions_admin' => 'missions_admin'
      }
      
      dictionary[role_name]
    end
    
  end
end