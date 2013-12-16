# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paper_wrap/version'

Gem::Specification.new do |spec|
  spec.name          = "paper_wrap"
  spec.version       = PaperWrap::VERSION
  spec.authors       = ["Jonathan Liang"]
  spec.email         = ["jhl@zestfinance.com"]
  spec.description   = %q{Ruby wrapper around papertrail http/json API}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry-debugger"


end
