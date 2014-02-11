# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby/class/unloading/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-class-unloading'
  spec.version       = Ruby::Class::Unloading::VERSION
  spec.authors       = ['Kimberley Scott']
  spec.email         = ['kim_scott@not.a.real.address.com']
  spec.description   = %q{Simply show how class loading and unloading works}
  spec.summary       = %q{Simply show how class loading and unloading works}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  # Use awesome print for displays in all environments
  spec.add_dependency 'awesome_print'

end
