module OwaspZapApi
  class Alert
    attr_accessor :start,:count
    def initialize(params = {})
      @start = params[:start]
      @count = params[:count]
      @format = params[:format] || 'JSON'
      @baseurl = params[:baseurl]
      @url = OwaspZapApi.url + "#{@format}/core/"
    end
    def alerts
      url = @url + "view/alerts/"
      query = {:zapapiformat => @format,:baseurl => @baseurl,:start => @start,:count => @count}
      Requester.get(url,query)
    end
    def number
      url = @url + "view/numberOfAlerts"
      query = {:zapapiformat => @format,:baseurl => @baseurl}
      Requester.get(url,query)
    end
  end
end
