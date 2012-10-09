module IbssmApiClient
  class Stat < Base
    
    def stat_summary(token)
      path = "stats/index"
      return get_data(token,path)
    end
    
    def stats_by_year(token,year)
      path = "stats/statsByYear"
      return get_data(token,path,'?year=' + year.to_s)
    end
    
  end
end