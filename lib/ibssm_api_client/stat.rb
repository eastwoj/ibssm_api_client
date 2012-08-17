module IbssmApiClient
  class Stat < Base
    
    def stat_summary
      path = "stats/index"
      return get_data(path)
    end
    
    def stats_by_year(year)
      path = "stats/statsByYear"
      return get_data(path,'?year=' + year.to_s)
    end
    
  end
end