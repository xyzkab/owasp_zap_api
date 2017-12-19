module OwaspZapApi
  class PscanOnlyInScope
    def initialize(params = {})
      @scope = params[:scope]
      @format = params[:format] || 'JSON'
      @url = ZAPI + "#{@format}/pscan/"
    end
    def set
      url = @url + "action/setScanOnlyInScope/"
      query = {:zapapiformat => @format,:onlyInScope => @scope}
      Requester.get(url,query)
    end
    def view
      url = @url + "view/scanOnlyInScope/"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
  end
end