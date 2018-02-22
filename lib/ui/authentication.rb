module OwaspZapApi
  class Authentication
    def initialize(params = {})
      @name = params[:name] || 'formBasedAuthentication'
      @context_id = params[:context_id]
      @format = params[:format] || 'JSON'
      @login_url = params[:login_url]
      @login_regex = params[:login_regex]
      @logout_regex = params[:logout_regex]
      @login_data = params[:login_data] || {}
      @url = OwaspZapApi.url + "#{@format}/authentication/"
    end
    def authentication_method_set(context_id = nil)
      @context_id ||= context_id
      url = @url + "action/setAuthenticationMethod"
      data = ""
      @login_data.each{|k,v|
        if ['username','email'].include?(k)
          data += encode_data(k,"{%username%}")
        elsif ['password','pass','pwd'].include?(k)
          data += encode_data(k,"{%password%}")
        else
          data += "#{k}%3D#{v}%26"
        end
      }
      data = "loginRequestData=" + data + "&loginUrl=#{@login_url}"
      query = {:zapapiformat => @format, :contextId => @context_id, :authMethodName => @name, :authMethodConfigParams => data}
      Requester.get(url,query)
    end
    def authentication_method(context_id = nil)
      @context_id ||= context_id
      url = @url + "view/getAuthenticationMethod"
      query = {:zapapiformat => @format, :contextId => @context_id}
      Requester.get(url,query)
    end
    def method_config_params(name = nil)
      @name ||= name
      url = @url + "view/getAuthenticationMethodConfigParams"
      query = {:zapapiformat => @format, :authMethodName => @name}
      Requester.get(url,query)
    end
    def logged_indicator(context_id = nil)
      @context_id ||= context_id
      url = @url + "view/getLoggedInIndicator"
      query = {:zapapiformat => @format, :contextId => @context_id}
      Requester.get(url,query)
    end
    def logged_indicator_set(context_id = nil, regex = nil)
      @context_id ||= context_id
      @login_regex ||= regex
      url = @url + "action/setLoggedInIndicator"
      query = {:zapapiformat => @format, :contextId => @context_id, :loggedInIndicatorRegex => @login_regex}
      Requester.get(url,query)
    end
    def logout_indicator(context_id = nil)
      @context_id ||= context_id
      url = @url + "view/getLoggedOutIndicator"
      query = {:zapapiformat => @format, :contextId => @context_id}
      Requester.get(url,query)
    end
    def supported_methods
      url = @url + "view/getSupportedAuthenticationMethods"
      query = {:zapapiformat => @format}
      Requester.get(url,query)
    end
    private
    def encode_data(k,v)
      URI.escape("#{k}=#{v}&",/=|{|}|%|&/)
    end
  end
end