module OwaspZapApi
  class Pscan
    def initialize(params = {})
      @format = params[:format] || 'JSON'
      @enabled = params[:enabled] || true
      @only_in_scope = params[:only_in_scope] || false
      @url = OwaspZapApi.url + "#{@format}/pscan/"
    end
    def set_enabled
      url = @url + "action/setEnabled/"
      query = {:zapapiformat => @format,:enabled => @enabled}
      Requester.get(url,query)
    end
    def only_in_scope?
      url = @url + "view/scanOnlyInScope/"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    def set_only_in_scope
      url = @url + "action/setScanOnlyInScope/"
      query = {:zapapiformat => @format,:onlyInScope => @only_in_scope}
      Requester.get(url,query)
    end
  end
end