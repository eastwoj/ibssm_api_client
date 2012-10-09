module IbssmApi
  class Attendance < Base
    
    # Returns a summary of a student's absences and tardies. 
    def summary(token,student_profile_id)
      path = "attendance/index"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def missed(token,id)
      
    end
    
    def tardy(token,id)
      
    end
    
    def attended(token,id)
      
    end
  end
end