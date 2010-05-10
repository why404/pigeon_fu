#!/usr/bin/env ruby
 
require 'optparse'
require 'fileutils'

#TODO
OptionParser.new do |opts|
  opts.banner = "Usage: pigeonfu [path] \n(should be the applition root path)\n e.g \"pigeonfu . \"."
 
  begin
    opts.parse!(ARGV)
  rescue OptionParser::ParseError => e
    warn e.message
    puts opts
    exit 1
  end
end
