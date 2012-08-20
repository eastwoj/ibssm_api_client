module IbssmApiClient
  class Comment < Base
    
    # Creates a comment for a student
    def create_comment(comment,student_id)
      path = "comments/create"
      post_data(path,{'comment' => comment, "student_id"=> student_id })
    end
  
    # Returns all of the comments for a student
    def comments(student_id)
      path = "comments/index"
      return get_data(path,'?student_id=' + student_id.to_s)
    end    
  end 
end