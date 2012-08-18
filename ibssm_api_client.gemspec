# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ibssm_api_client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Eastwood"]
  gem.email         = ["jasone@ibethel.org"]
  gem.description   = %q{A library wrapping ibssm.org's private API}
  gem.summary       = %q{A temporary gem summary}
  gem.homepage      = "https://github.com/eastwoj/ibssm_api_client"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ibssm_api_client"
  gem.require_paths = ["lib"]
  gem.version       = IbssmApiClient::VERSION
  
  #gem.add_development_dependency "rpsec-rails"
end
