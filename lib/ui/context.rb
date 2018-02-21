module OwaspZapApi
  class Context
    def initialize(params = {})
      @file = params[:file]
      @name = params[:name]
      @regex = params[:regex]
      @format = params[:format] || 'JSON'
      @url = URL + "#{@format}/context/"
    end
    def context(name = nil)
      @name ||= name
      url = @url + "view/context"
      query = {:zapapiformat => @format, :contextName => @name}
      Requester.get(url,query)
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
    def remove(name = nil)
      @name ||= name
      url = @url + "action/removeContext/"
      query = {:zapapiformat => @format,:contextName => @name}
      Requester.get(url,query)
    end
    def include_regexs(name = nil)
      @name ||= name
      url = @url + "view/includeRegexs/"
      query = {:zapapiformat => @format,:contextName => @name}
      Requester.get(url,query)
    end
    def exclude_regexs(name = nil)
      @name ||= name
      url = @url + "view/excludeRegexs/"
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
    def exclude_from_context(name = nil,regex = nil)
      @name ||= name
      @regex ||= regex
      url = @url + "action/excludeFromContext"
      query = {:zapapiformat => @format,:contextName => @name,:regex => @regex}
      Requester.get(url,query)
    end
  end
end