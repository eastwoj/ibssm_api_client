module IbssmApiClient
  class Homework < Base
    
    # Returns a summary of a student's homework.
    def summary(token,student_profile_id)
      path = "homework/index"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def completed(token,student_profile_id)
      path = "homework/completed"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def missing(token,student_profile_id)
      path = "homework/missing"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def future(token,student_profile_id)
      path = "homework/future"
      return get_data(token,path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def homework_by_type(token,student_profile_id,homework_type)
      case homework_type
      when "completed"
        completed(token,student_profile_id)
      when "future"
        future(token,student_profile_id)
      else
        # fail
      end
    end
  end
end