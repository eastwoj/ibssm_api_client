module IbssmApiClient
  class Payment < Base
    
    # Returns all of the student's payments + 
    # id: the student's id
    # token: the student's authentication token
    def summary(student_id)
      path = "students/payments"
      return get_data(path,'?student_profile_id=' + student_id.to_s)
    end    
    
  end
end