
require File.expand_path("../lib/uv-priority-queue/version", __FILE__)


Gem::Specification.new do |s|
  s.name        = "uv-priority-queue"
  s.version     = UV::PriorityQueue::VERSION
  s.license     = 'MIT'
  s.authors     = ["Stephen von Takach", "Mike Lewis"]
  s.email       = ["steve@cotag.me", "ft.mikelewis@gmail.com"]
  s.homepage    = "https://github.com/cotag/uv-priority-queue"
  s.summary     = %q{Libuv Priority Queue}
  s.description = %q{Asynchronous Priority Queue for use with Libuv}

  s.files         = Dir["lib/**/*"] + %w(Rakefile uv-priority-queue.gemspec README.md LICENSE)
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]


  s.add_runtime_dependency "libuv"
  s.add_runtime_dependency "algorithms"


  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency "delorean", ">= 1.1.1"
end
