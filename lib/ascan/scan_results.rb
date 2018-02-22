module OwaspZapApi
  class ScanResults
    attr_reader :progress
    def initialize(data = {})
      @id = data['scan'] || nil
      @progress = data['status'].to_i || nil
    end
    def id
      @id ? @id.to_i : @id
    end
  end
end