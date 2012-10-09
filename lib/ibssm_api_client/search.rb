module IbssmApiClient
  class Search < Base
    
    # Searches for ibssm.org students who contain the search parameter. 
    # q: a search string
    def search(token,q)
      path = "search"
      params = "?q=" + q
      begin
        json = get_data(token,path,params)
      rescue Net::HTTPForbidden
        raise IbssmAuthenticationError
      end
      return json
    end
  end
end