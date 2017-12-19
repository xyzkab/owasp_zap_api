module OwaspZapApi
  class Context
    def initialize(params = {})
      @file = params[:file]
      @name = params[:name]
      @regex = params[:regex]
      @format = params[:format] || 'JSON'
      @url = ZAPI + "#{@format}/context/"
    end
    def list
      url = @url + "view/contextList/"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    def create(name = nil)
      @name ||= name
      url = @url + "action/newContext"
      query = {:zapapiformat => @format,:contextName => @name}
      Requester.get(url,query)
    end
    def import(file = nil)
      @file ||= file
      url = @url + "action/importContext/"
      query = {:zapapiformat => @format,:contextFile => @file}
      Requester.get(url,query)
    end
    def export(name = nil, file = nil)
      @name ||= name
      @file ||= file
      url = @url + "action/exportContext"
      query = {:zapapiformat => @format,:contextName => @name,:contextFile => @file}
      Requester.get(url,query)
    end
    def remove
      url = @url + "action/removeContext/"
      query = {:zapapiformat => @format,:contextName => @name}
      Requester.get(url,query)
    end
    def include_in_context(name = nil,regex = nil)
      @name ||= name
      @regex ||= regex
      url = @url + "action/includeInContext"
      query = {:zapapiformat => @format,:contextName => @name,:regex => @regex}
      Requester.get(url,query)
    end
  end
end
