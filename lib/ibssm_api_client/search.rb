module IbssmApiClient
  class Search < Base
    
    # Searches for ibssm.org students who contain the search parameter. 
    # q: a search string
    # token: a student's authentication token
    def search(q)
      path = "search"
      params = "?q=" + q
      begin
        json = get_data(path,params)
      rescue Net::HTTPForbidden
        raise IbssmAuthenticationError
      end
      return json
    end
  end
end