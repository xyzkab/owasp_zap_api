module OwaspZapApi
  class Context
    def initialize(params = {})
      @file = params[:file]
      @name = params[:name]
      @format = params[:format] || 'JSON'
      @url = ZAPI + "#{@format}/context/"
    end
    def list
      url = @url + "view/contextList/"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    def import
      url = @url + "action/importContext/"
      query = {:zapapiformat => @format,:contextFile => @file}
      Requester.get(url,query)
    end
    def remove
      url = @url + "action/removeContext/"
      query = {:zapapiformat => @format,:contextName => @name}
      Requester.get(url,query)
    end
  end
end
