module OwaspZapApi
  class PscanOnlyInScope
    def initialize(params = {})
      @scope = params[:scope]
      @format = params[:format] || 'JSON'
      @url = ZAPI + 
    end
    def set
      url = ZAPI + "#{@format}/pscan/action/setScanOnlyInScope/"
      query = {:zapapiformat => @format,:onlyInScope => @scope}
      Requester.get(url,query)
    end
    def view
      url = ZAPI + "#{@format}/pscan/view/scanOnlyInScope/"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
  end
end