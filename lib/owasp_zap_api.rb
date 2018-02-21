require 'http'
require 'requester'
require 'ui/context'
require 'ui/users'
require 'ui/authentication'
require 'ui/pscan_only_in_scope'
require 'core/alert'
require 'core/message'
require 'core/message_results'
require 'core/alert_results'
require 'core/shutdown'
require 'ascan/scan'

module OwaspZapApi
  #URL = "http://127.0.0.1:8080/"
  URL = "http://l33tzaph:8080/"
  def self.auth_method(cid)
    au = Authentication.new(context_id: cid)
    au.authentication_method
  end
  def self.auth_method_set(cid,url,data)
    au = Authentication.new(context_id: cid,login_url: url,login_data: data)
    au.authentication_method_set
  end
  def self.auth_method_conf_param(name)
    au = Authentication.new(name: name)
    au.method_config_params
  end
  def self.auth_form_based
    auth_method_conf_param('formBasedAuthentication')['methodConfigParams']
  end
  def self.auth_logged_indicator_set(cid,regex)
    au = Authentication.new(context_id: cid, login_regex: regex)
    au.logged_indicator_set
  end
  def self.auth_logged_indicator(cid)
    au = Authentication.new(context_id: cid)
    re = au.logged_indicator['logged_in_regex'].to_s
    re.empty? ? false : re
  end
  def self.auth_logout_indicator(cid)
    au = Authentication.new(context_id: cid)
    re = au.logout_indicator['logged_out_regex'].to_s
    re.empty? ? false : re
  end
  def self.auth_supported_methods
    au = Authentication.new
    au.supported_methods
  end
  def self.users(cid)
    us = Users.new(context_id: cid)
    us.list
  end
  def self.user(id,cid)
    us = Users.new(id: id,context_id: cid)
    us.find
  end
  def self.user_auth_creds_conf_params(cid)
    us = Users.new(context_id: cid)
    us.authentication_credentials_config_params
  end
  def self.user_auth_creds(id,cid)
    us = Users.new(id: id,context_id: cid)
    us.authentication_credentials
  end
  def self.user_save(name,cid)
    us = Users.new(name: name, context_id: cid)
    us.save['userId']
  end
  def self.user_remove(id,cid)
    us = Users.new(id: id, context_id: cid)
    us.destroy['Result'] == "OK" ? true : false
  end
  def self.user_enable(id,cid)
    us = Users.new(id: id, context_id: cid, enabled: true)
    us.enable
  end
  def self.user_disable(id,cid)
    us = Users.new(id: id, context_id: cid, enabled: false)
    us.enable
  end
  def self.user_auth_cred_set(id,cid,username,password)
    us = Users.new(id: id, context_id: cid, username: username, password: password)
    us.authentication_credential_set['Result'] ? true : false
  end
  def self.scan(url,cid)
    as = Scan.new(url_target: url, context_id: cid)
    as.scan
  end
  def self.scan_status(id)
    as = Scan.new(id: id)
    as.status['status']
  end
  def self.scan_exist?(id)
    scan_status(id) ? true : false
  end
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
  def self.context(context)
    cx = Context.new(name: context)
    cx.context['context']
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
    cx.exclude_regexs["excludeRegexs"]
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
    MessageResults.new(ms.message['message'])
  end
  def self.messages(baseurl = nil, start = nil, count = nil)
    ms = Message.new(baseurl: baseurl, start: start, count: count)
    ms.messages['messages']
  end
  def self.total_messages(baseurl = nil)
    tm = Message.new(baseurl: baseurl)
    tm.number['numberOfMessages'].to_i
  end
  def self.ascans
    as = Scan.new
    as.scans['scans']
  end
  def self.exclude_from_scan(regex)
    as = Scan.new(regex: regex)
    as.exclude_from_scan
  end
  def self.excluded_from_scans
    as = Scan.new
    as.excluded_from_scans['excludedFromScan']
  end
  def self.shutdown
    sh = Shutdown.new
    sh.now['Result']
  end
end