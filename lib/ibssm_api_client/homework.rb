module IbssmApiClient
  class Homework < Base
    
    # Returns a summary of a student's homework.
    # id: the student's id
    # token: the student's authentication token
    def summary(student_profile_id)
      path = "homework/index"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def completed(student_profile_id)
      path = "homework/completed"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def missing(student_profile_id)
      path = "homework/missing"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def future(student_profile_id)
      path = "homework/future"
      return get_data(path,'?student_profile_id=' + student_profile_id.to_s)
    end
    
    def homework_by_type(student_profile_id,homework_type)
      case homework_type
      when "completed"
        completed(student_profile_id)
      when "future"
        future(student_profile_id)
      else
        # fail
      end
    end
  end
end