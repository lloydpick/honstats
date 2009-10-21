require 'rubygems'

gem 'libxml-ruby', '>= 0.8.3'
require 'xml'

gem 'eventmachine', '>= 0.12.8'
require 'eventmachine'
include EM::Deferrable

require 'activesupport'
require 'uri'
require 'cgi'
require 'fileutils'

require "#{File.dirname(__FILE__)}/honstats/base.rb"
Dir["#{File.dirname(__FILE__)}/honstats/*.rb"].each { |source_file| require source_file }