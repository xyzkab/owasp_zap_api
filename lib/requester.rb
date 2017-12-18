module OwaspZapApi
  module Requester
    def self.get(url, data = {})
      jp(HTTP.get(url, :params => data))
    end
    def self.post(url, data = {})
      jp(HTTP.post(url, :json => data))
    end
    def self.jp(string)
      JSON.parse string
    end
  end
end