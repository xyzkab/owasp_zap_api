module OwaspZapApi
  class Users
    def initialize(params = {})
      @id = params[:id]
      @name = params[:name]
      @enabled = params[:enabled]
      @username = params[:username]
      @password = params[:password]
      @context_id = params[:context_id]
      @format = params[:format] || 'JSON'
      @url = OwaspZapApi.url + "#{@format}/users/"
    end
    def save(name = nil, context_id = nil)
      @name ||= name
      @context_id ||= context_id
      url = @url + "action/newUser"
      query = {:zapapiformat => @format, :contextId => @context_id, :name => @name}
      Requester.get(url,query)
    end
    def destroy(id = nil, context_id = nil)
      @id ||= id
      @context_id ||= context_id
      url = @url + "action/removeUser"
      query = {:zapapiformat => @format, :contextId => @context_id, :userId => @id}
      Requester.get(url,query)
    end
    def update_name(id = nil, context_id = nil, name = nil)
      @id ||= nil
      @context_id ||= context_id
      @name ||= name
      url = @url + "action/setUserName"
      query = {:zapapiformat => @format, :contextId => @context_id, :userId => @id, :name => @name}
      Requester.get(url,query)
    end
    def enable(id = nil, context_id = nil, e = true)
      @id ||= id
      @context_id ||= context_id
      @enabled = !!@enabled == @enabled ? @enabled : e
      url = @url + "action/setUserEnabled"
      query = {:zapapiformat => @format, :contextId => @context_id, :userId => @id, :enabled => @enabled}
      Requester.get(url,query)
    end
    def authentication_credential_set(id = nil, context_id = nil, usernae = nil, password = nil)
      @id ||= id
      @context_id ||= context_id
      @username ||= username
      @password ||= password
      cred_params = {:username => @username,:password => @password}.to_param
      url = @url + "action/setAuthenticationCredentials"
      query = {:zapapiformat => @format, :contextId => @context_id, :userId => @id, :authCredentialsConfigParams => cred_params}
      Requester.get(url,query)
    end
    def list
      url = @url + "view/usersList"
      query = {:zapapiformat => @format, :contextId => @context_id}
      Requester.get(url,query)
    end
    def find(id = nil, context_id = nil)
      @id ||= id
      @context_id ||= context_id
      url = @url + "view/getUserById"
      query = {:zapapiformat => @format, :contextId => @context_id, :userId => @id}
      Requester.get(url,query)
    end
    def authentication_credentials(id = nil, context_id = nil)
      @context_id ||= context_id
      @id ||= id
      url = @url + "view/getAuthenticationCredentials"
      query = {:zapapiformat => @format, :contextId => @context_id, :userId => @id}
      Requester.get(url,query)
    end
    def authentication_credentials_config_params(context_id = nil)
      @context_id ||= context_id
      url = @url + "view/getAuthenticationCredentialsConfigParams"
      query = {:zapapiformat => @format, :contextId => @context_id}
      Requester.get(url,query)
    end
  end
end