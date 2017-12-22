module OwaspZapApi
  class Message
    attr_accessor :start,:count
    def initialize(params = {})
      @id = params[:id]
      @start = params[:start]
      @count = params[:count]
      @format = params[:format] || 'JSON'
      @baseurl = params[:baseurl]
      @url = URL + "#{@format}/core/"
    end
    def messages
      url = @url + "view/messages"
      query = {:zapapiformat => @format,:baseurl => @baseurl,:start => @start,:count => @count}
      Requester.get(url,query)
    end
    def message(id = nil)
      @id ||= id
      url = @url + "view/message"
      query = {:zapapiformat => @format,:id => @id}
      Requester.get(url,query)
    end
    def number
      url = @url + "view/numberOfMessages/"
      query = {:zapapiformat => @format,:baseurl => @baseurl}
      Requester.get(url,query)
    end
  end
end