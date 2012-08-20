module IbssmApi
  class Attendance < Base
    
    # Returns a summary of a student's absences and tardies. 
    def summary(student_profile_id)
      path = "attendance/index"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def missed(id)
      
    end
    
    def tardy(id)
      
    end
    
    def attended(id)
      
    end
  end
end