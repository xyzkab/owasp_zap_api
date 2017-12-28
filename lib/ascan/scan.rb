module OwaspZapApi
  class Scan
    def initialize(params = {})
      @id = params[:id]
      @format = params[:format] || 'JSON'
      @url = URL + "#{@format}/ascan/"
      @regex = params[:regex]
    end
    def scans
      url = @url + "view/scans"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    def exclude_from_scan(regex = nil)
      @regex ||= regex
      url = @url + "action/excludeFromScan"
      query = {:zapapiformat => @format,:regex => @regex}
      Requester.get(url,query)
    end
    def excluded_from_scans
      url = @url + "view/excludedFromScan"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
  end
end