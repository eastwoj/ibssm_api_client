module IbssmApiClient
  class Role < Base

    def update_all_roles(token,user)
      path = "roles/update"
      payload = build_role_json(user.roles)
      response = post_data(token,path,{'coeus_user_id' => user.id, 'roles' => payload})
      debug_response(response)
      response      
    end
    
    def roles(token,user_id)
      coeus_roles = Array.new
      path = "roles/show"
      response = get_data(token,path,'?coeus_user_id=' + user_id.to_s)
      if role_data = response["roles"]
        role_data.each do |map|
          coeus_role = coeus_role_for_ibssm_role(map['name'])
          coeus_roles << coeus_role if !coeus_role.blank?
        end
      end
      coeus_roles.to_json
    end
    
    def build_role_json(roles)
      bucket = Array.new
      roles.each do |role|
        bucket << ibssm_role_for_coeus_role(role.name)
      end
      bucket.to_json
    end
    
    def build_role_json_with_names(role_names)
      bucket = Array.new
      role_names.each do |role_name|
        bucket << ibssm_role_for_coeus_role(role_name)
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
    
    def coeus_role_for_ibssm_role(role_name)
      dictionary = {
        'g-office_staff' => 'office_staff',
        'g-intern' => 'intern', 
        'g-staff' => 'staff',
        'g-student' => 'student',
        'g-administrator' => 'admin',
        'g-superuser' => 'root',
        'g-approve_first_year' => '1st_year_approver',
        'authenticate_attendance_stations' => 'authenticate_attendance_stations',
        'interview_first_year_students' => '1st_year_interviewer',
        'interview_2nd_year_students' => '2nd_year_interviewer', 
        'view_applications' => 'application_viewer',
        'travel_admin' => 'travel_admin',
        'travel_manager' => 'travel_manager',
        'travel_leader' => 'travel_leader',
        'travel_finance_admin' => 'travel_finance_admin',
        'view_travel' => 'travel_viewer',
        'api_admin' => 'api_admin',
        'accept_2nd_year_students' => '2nd_year_approver',
        'missions_staff' => 'missions_staff',
        'missions_finance_admin' => 'missions_finance_admin',
        'missions_admin' => 'missions_admin'
      }
      
      dictionary[role_name]      
    end
    
  end
end