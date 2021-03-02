# fronzen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sql_analyzer/version"

Gem::Specification.new do |spec|
  spec.name          = "sql_analyzer"
  spec.version       = SqlAnalyzer::VERSION
  spec.authors       = ["furuhama"]
  spec.email         = ["furuhama@users.noreply.github.com"]

  spec.summary       = %q{Analyze database transactions and queries}
  spec.description   = %q{Analyze database transactions and JOIN SQLs for ActiveRecord and MySQL}
  spec.homepage      = "https://furuhama.github.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '>= 5.2', '< 6.2'
  spec.add_dependency 'mysql2', '~> 0.5.0'

  spec.add_development_dependency "bundler", "> 2.0.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
