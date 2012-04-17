# -*- encoding: utf-8 -*-
require File.expand_path('../lib/unrar/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["JR Boyens"]
  gem.email         = ["jr.boyens@chacha.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "unrar"
  gem.require_paths = ["lib"]
  gem.version       = Unrar::VERSION

  gem.add_development_dependency 'rspec', '~> 2.9'
  gem.add_development_dependency 'autotest'
end
