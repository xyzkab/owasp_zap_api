require 'http'
require 'requester'
require 'ui/context'
require 'ui/pscan_only_in_scope'
require 'core/alert'
require 'core/message'

module OwaspZapApi
  URL = "http://127.0.0.1:8080/"
  def self.pscan_only_in_scope?
    ps = PscanOnlyInScope.new
    ps.view['scanOnlyInScope'] == "true" ? true : false
  end
  def self.pscan_only_in_scope_setrue
    pscan_only_in_scope_set(true)
  end
  def self.pscan_only_in_scope_set(scope = false)
    ps = PscanOnlyInScope.new(scope: scope)
    ps.set
  end
  def self.contexts
    cx = Context.new
    cx.list
  end
  def self.context_new(name)
    cx = Context.new(name: name)
    cx.create
  end
  def self.context_import(file)
    cx = Context.new(file: file)
    cx.import
  end
  def self.context_imported?(name)
    contexts['contextList'].include?(name)
  end
  def self.context_export(name,file)
    cx = Context.new(name: name, file: file)
    cx.export
  end
  def self.context_remove(name)
    cx = Context.new(name: name)
    cx.remove
  end
  def self.context_include(name,regex)
    cx = Context.new(name: name, regex: regex)
    cx.include_in_context
  end
  def self.context_exclude(name,regex)
    cx = Context.new(name: name, regex: regex)
    cx.exclude_from_context
  end
  def self.context_include_regexs(name)
    cx = Context.new(name: name)
    cx.include_regexs
  end
  def self.context_exclude_regexs(name)
    cx = Context.new(name: name)
    cx.exclude_regexs
  end
  def self.alerts(baseurl = nil, start = nil, count = nil)
    al = Alert.new(baseurl: baseurl, start: start, count: count)
    al.alerts['alerts']
  end
  def self.total_alerts(baseurl = nil)
    na = Alert.new(baseurl: baseurl)
    na.number['numberOfAlerts'].to_i
  end
  def self.message(id)
    ms = Message.new(id: id)
    ms.message['message']
  end
  def self.message_ctype(id)
    message(id)['responseHeader'].match(/Content-Type: (.*)\r/)
    $1
  end
  def self.messages(baseurl = nil, start = nil, count = nil)
    ms = Message.new(baseurl: baseurl, start: start, count: count)
    ms.messages['messages']
  end
  def self.total_messages(baseurl = nil)
    tm = Message.new(baseurl: baseurl)
    tm.number['numberOfMessages'].to_i
  end
end