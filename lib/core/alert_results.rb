module OwaspZapApi
  class AlertResults
    def initialize(data = {})
      @id = data['id'] || 0
      @url = data['url']
      @risk = data['risk']
      @name = data['name']
      @other = data['other']
      @cweid = data['cweid']
      @alert = data['alert']
      @param = data['param']
      @wascid = data['wascid']
      @attack = data['attack']
      @method = data['method']
      @solution = data['solution']
      @evidence = data['evidence']
      @pluginid = data['pluginId']
      @reference = data['reference']
      @source_id = data['sourceid']
      @message_id = data['messageId']
      @confidence = data['confidence']
      @description = data['description']
    end
    def url
      @url
    end
    def url_method
      @method
    end
    def param
      @param
    end
    def name
      @name
    end
    def risk
      @risk
    end
    def description
      @description
    end
    def payload
      @attack
    end
    def content_type
      OwaspZapApi.message(@message_id).content_type
    end
  end
end
