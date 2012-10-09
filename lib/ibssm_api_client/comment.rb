module IbssmApiClient
  class Comment < Base
    
    # Creates a comment for a student
    def create_comment(token,comment,student_id)
      path = "comments/create"
      post_data(token,path,{'comment' => comment, "student_id"=> student_id })
    end
  
    # Returns all of the comments for a student
    def comments(token,student_id)
      path = "comments/index"
      return get_data(token,path,'?student_id=' + student_id.to_s)
    end    
  end 
end