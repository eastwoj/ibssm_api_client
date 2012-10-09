module IbssmApiClient
  class Payment < Base
    
    # Returns all of the student's payments 
    def summary(token,student_id)
      path = "students/payments"
      return get_data(token,path,'?student_profile_id=' + student_id.to_s)
    end    
    
  end
end