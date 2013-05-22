# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'folder/version'

Gem::Specification.new do |spec|
  spec.name          = "folder"
  spec.version       = Folder::VERSION
  spec.authors       = ["tatat"]
  spec.email         = ["ioiioioloo@gmail.com"]
  spec.description   = %q{string keys make directory structure}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/tatat/folder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
