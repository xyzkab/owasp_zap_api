module OwaspZapApi
  class Scanner
    def initialize(params = {})
      @ids = params[:ids] || []
      @format = params[:format] || 'JSON'
      @url = OwaspZapApi.url + "#{@format}/ascan/"
      @scan_policy = params[:scan_policy] || "Default Policy"
    end

    def disable_scanners
      url = @url + "action/disableScanners"
      query = {:zapapiformat => @format, :ids => @ids.join(","), :scanPolicyName => @scan_policy}
      Requester.get(url,query)
    end

    def lists
      url = @url + "view/scanners"
      query = {:zapapiformat => @format, :scanPolicyName => @scan_policy}
      Requester.get(url,query)
    end
  end
end