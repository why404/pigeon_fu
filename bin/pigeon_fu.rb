#!/usr/bin/env ruby
 
require 'rubygems'
require 'optparse'
require 'fileutils'
require 'tempfile'
require 'pigeon_fu'

options = Hash.new

OptionParser.new do |opts|
  opts.banner = "Usage: Pigeon_Fu [options]"
  opts.on('-v', '--version') { puts "Pigeon_Fu v#{Pigeon_Fu::VERSION}"; exit(0) }
  opts.on('-w', '--write-crontab') { options[:write] = true }
  opts.on('-i', '--update-crontab [identifier]', 'Default: full path to schedule.rb file') do |identifier|
    options[:update] = true
    options[:identifier] = identifier if identifier
  end
  opts.on('-f', '--load-file [schedule file]', 'Default: config/schedule.rb') do |file|
    options[:file] = file if file
  end
  opts.on('-u', '--user [user]', 'Default: current user') do |user| 
    options[:user] = user if user
  end
  opts.on('-s', '--set [variables]', 'Example: --set environment=staging&path=/my/sweet/path') do |set|
    options[:set] = set if set
  end
end.parse!
 
Pigeon_Fu::CommandLine.execute(options)