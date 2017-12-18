module OwaspZapApi
  class Message
    attr_accessor :start,:count
    def initialize(params = {})
      @start = params[:start]
      @count = params[:count]
      @format = params[:format] || 'JSON'
      @baseurl = params[:baseurl]
      @url = ZAPI + "#{@format}/core/"
    end
    def list
      @url += "view/messages"
      query = {:zapapiformat => @format,:baseurl => @baseurl,:start => @start,:count => @count}
      Requester.get(@url,query)
    end
    def number
      @url += "view/numberOfMessages/"
      query = {:zapapiformat => @format,:baseurl => @baseurl}
      Requester.get(@url,query)
    end
  end
end
