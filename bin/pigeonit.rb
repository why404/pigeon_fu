#!/usr/bin/env ruby
 
require 'optparse'
require 'fileutils'

OptionParser.new do |opts|
  opts.banner = "Usage: pigeonit [path] \n(should be the applition root path)\n e.g \"pigeonit . \"."
 
  begin
    opts.parse!(ARGV)
  rescue OptionParser::ParseError => e
    warn e.message
    puts opts
    exit 1
  end
end
 
if ARGV.empty?
  abort "Please specify your applition root directory. e.g. `#{File.basename($0)} .'"
elsif !File.exists?(ARGV.first)
  abort "`#{ARGV.first}' does not exist."
elsif !File.directory?(ARGV.first)
  abort "`#{ARGV.first}' is not a directory."
elsif ARGV.length > 1
  abort "Too many arguments; please specify only the applition root directory."
end
 
 
content = %Q{
app_uid: 
app_user: 
app_key: 
}
 
file = 'config/pigeon_fu.yml'
base = ARGV.shift
 
file = File.join(base, file)
if File.exists?(file)
  warn "[skip] `#{file}' already exists"
elsif File.exists?(file.downcase)
  warn "[skip] `#{file.downcase}' exists, which could conflict with `#{file}'"
elsif !File.exists?(File.dirname(file))
  warn "[skip] directory `#{File.dirname(file)}' does not exist"
else
  puts "[add] creating `#{file}'"
  puts "[add] writing `#{file}'"
  File.open(file, "w") { |f| f.write(content) }
end
 
puts "Created `#{file}.\n\n"
puts "Don't forget to update it with your development account that you have registered on the China Telecom open platform(http://www.189works.com/)!"