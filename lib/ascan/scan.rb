module OwaspZapApi
  class Scan
    def initialize(params = {})
      @id = params[:id]
      @format = params[:format] || 'JSON'
      @url = OwaspZapApi.url + "#{@format}/ascan/"
      @regex = params[:regex]
      @url_target = params[:url_target]
      @context_id = params[:context_id]
      @user_id = params[:user_id]
    end
    def scan(url_target = nil, context_id = nil)
      @context_id ||= context_id
      @url_target ||= url_target
      url = @url + "action/scan"
      query = {:zapapiformat => @format, :url => @url_target, :contextId => @context_id}
      Requester.get(url,query)
    end
    def scan_as(url_target = nil, context_id = nil, user_id = nil)
      @user_id ||= user_id
      @context_id ||= context_id
      @url_target ||= url_target
      url = @url + "action/scanAsUser"
      query = {:zapapiformat => @format, :url => @url_target, :contextId => @context_id, :userId => @user_id}
      Requester.get(url,query)
    end
    def status(id = nil)
      @id ||= id ? id : Time.now.to_i
      url = @url + "view/status"
      query = {:zapapiformat => @format, :scanId => @id}
      Requester.get(url,query)
    end
    def scans
      url = @url + "view/scans"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    def exclude_from_scan(regex = nil)
      @regex ||= regex
      url = @url + "action/excludeFromScan"
      query = {:zapapiformat => @format,:regex => @regex}
      Requester.get(url,query)
    end
    def excluded_from_scans
      url = @url + "view/excludedFromScan"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    def max_results_to_list(count = 1000)
      return if count.to_i == 1000
      url = @url + "action/setOptionMaxResultsToList"
      query = {:zapapiformat => @format, :Integer => count}
      Requester.get(url,query)
    end
  end
end
