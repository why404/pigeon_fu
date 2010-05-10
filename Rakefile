require 'rake'
require 'rake/gempackagetask'
require File.dirname(__FILE__) + '/lib/pigeon_fu/version'

PKG_FILES = FileList[
  '[a-zA-Z-]*', 
  'lib/**/*',
  'examples/*', 
  'bin/*'
]

spec = Gem::Specification.new do |s|
  s.name = "pigeon_fu" 
  s.version = PigeonFu::VERSION 
  s.author = "why404" 
  s.email = "why404@gmail.com" 
  s.homepage = "http://rubygems.org/gems/pigeon_fu" 
  s.platform = Gem::Platform::RUBY 
  s.summary = "SDK written in Ruby for the ChinaTelecom Open Platform." 
  s.description = "PigeonFu is a Ruby gem (also can be as a Rails plugin, it'll support Rails 3.0.0 or above ASAP) as an unofficial Ruby SDK for the ChinaTelecom Open Platform(http://open.189works.com/)." 
  s.files = PKG_FILES.to_a 
  s.require_path = "lib" 
  s.has_rdoc = false 
  s.extra_rdoc_files = ["README.markdown"] 
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
