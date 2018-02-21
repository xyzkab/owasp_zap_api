module OwaspZapApi
  class MessageResults
    attr_reader :responsebody
    def initialize(data = {})
      @id = data['id'] || ""
      @rtt = data['rtt'] || ""
      @note = data['note'] || ""
      @type = data['type'] || ""
      @tags = data['tags'] || ""
      @timestamp = data['timestamp'] || ""
      @cookieparams = data['cookieParams'] || ""
      @requestbody = data['requestBody'] || ""
      @requestheader = data['requestHeader'] || ""
      @responsebody = data['responseBody'] || ""
      @responseheader = data['responseHeader'] || ""
    end
    def url
      @requestheader.split("\r\n").first.split(" ")[1]
    end
    def content_type
      @responseheader.match(/Content-Type: (.*)\r/i)
      $1
    end
    def response_code
      response_code_message.split(" ").first.to_i
    end
    def response_code_message
      @responseheader.match(/HTTP\/\d{1}.\d{1} (.*) *\r\n/i)
      $1
    end
    def requestbody
      Rack::Utils.parse_nested_query(@requestbody)
    end
  end
end