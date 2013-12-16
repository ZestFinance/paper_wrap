desc "Open an irb session preloaded with this library"
task :console do
  ENV["RUBY_ENV"] ||= "development"
  sh "irb -I lib -r paper_wrap"
end

require "bundler/gem_tasks"
