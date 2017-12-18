module OwaspZapApi
  class Alert
    def initialize(params = {})
      @start = params[:start]
      @format = params[:format] || 'JSON'
      @baseurl = params[:baseurl]
      @url = ZAPI + "#{@format}/core/"
    end
    def alerts
      @url += "view/alerts/"
      query = {:zapapiformat => @format,:baseurl => @baseurl,:start => @start}
      Requester.get(@url,query)
    end
    def alerts_number
      @url += "view/numberOfAlerts"
      query = {:zapapiformat => @format,:baseurl => @baseurl}
      Requester.get(@url,query)
    end
  end
end
