require 'rubygems'

gem 'libxml-ruby', '>= 1.1.4'
require 'xml'

gem 'eventmachine', '>= 0.12.10'
require 'eventmachine'
include EM::Deferrable

require 'active_support'
require 'uri'
require 'cgi'
require 'fileutils'

require "#{File.dirname(__FILE__)}/honstats/base.rb"
Dir["#{File.dirname(__FILE__)}/honstats/*.rb"].each { |source_file| require source_file }
Dir["#{File.dirname(__FILE__)}/honstats/clan/*.rb"].each { |source_file| require source_file }
require "#{File.dirname(__FILE__)}/honstats/match/team.rb"
require "#{File.dirname(__FILE__)}/honstats/match/team_player.rb"
require "#{File.dirname(__FILE__)}/honstats/match/team_stat.rb"