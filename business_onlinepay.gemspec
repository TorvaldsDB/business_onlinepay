# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'business_onlinepay/version'

Gem::Specification.new do |s|
  s.name          = "business_onlinepay"
  s.version       = BusinessOnlinepay::VERSION
  s.authors       = ["杜冰"]
  s.email         = ["dubing@reocar.com"]
  s.homepage      = "TODO: Put your gem's website or public repo URL here."
  s.summary       = %q{Business onlinepay gem}
  s.description   = %q{The gem is about business onlinepay}
  s.license       = "MIT"
  s.require_paths = ["lib"]
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|s|features)/})
  end
  s.bindir        = "exe"

  s.add_development_dependency "bundler", "~> 1.14"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "faraday", "~> 0.11.0"
  s.add_development_dependency "stripe"
end
