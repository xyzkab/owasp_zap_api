require 'http'
require 'ui/context'
require 'core/alert'
require 'core/message'

module OwaspZapApi
  ZAPI = "http://127.0.0.1:9090/"
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
  def self.context_import(file)
    cx = Context.new(file: file)
    cx.import
  end
end