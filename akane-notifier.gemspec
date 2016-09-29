# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'akane/notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "akane-notifier"
  spec.version       = Akane::Notifier::VERSION
  spec.authors       = ["Sorah Fukumori"]
  spec.email         = ["her@sorah.jp"]

  spec.summary       = %q{akane plugin that fire notifications to several services}
  spec.homepage      = "https://github.com/sorah/akane-notifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "akane", ">= 0.1.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
