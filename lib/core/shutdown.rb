module OwaspZapApi
  class Shutdown
    def initialize(params = {})
      @format = params[:format] || 'JSON'
      @url = OwaspZapApi.url + "#{@format}/core/"
    end
    def now
      url = @url + "action/shutdown/"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
  end
end