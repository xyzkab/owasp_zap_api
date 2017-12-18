Gem::Specification.new do |s|
  s.name        = 'owasp_zap_api'
  s.version     = '0.0.1'
  s.date        = '2017-12-17'
  s.summary     = 'owasp_zap_api is just a simple interface for owasp_zap rest'
  s.description = %q{
    owasp_zap_api is just a simple interface for owasp_zap rest
  }
  s.add_dependency('bundler')
  s.add_dependency('http')
  s.authors     = 'xyzkab'
  s.email       = 'xyzkab@l33tzapj'
  s.files       = Dir['{bin,lib,config}/**/*', 'README*'] & `git ls-files -z`.split("\0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f)}
  s.homepage    = 'https://github.com/xyzkab/owasp_zap_api'
  s.license     = 'Nonstandard'
end