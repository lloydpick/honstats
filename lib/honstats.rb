#
# honstats - Heroes of Newerth Statistics Ruby Library
# Written by Lloyd Pick
# http://gibhub.com/lloydpick
# May not be used for commercial applications without prior concent
#

# usual requirements
require 'rubygems'
require 'activesupport'
require 'net/http'
require 'uri'
require 'fileutils'

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'honstats/character.rb'

module HonStats
  class API
    VERSION = '0.0.1'

    @@stats_url_base = "masterserver.hon.s2games.com/"
    @@requester_file = "client_requester.php"

    @@search_types = {
			:character => 'character'
		}

    cattr_accessor :stats_base_url, :requester_file
    attr_accessor :character_name

    # Constructor
		# Accepts an optional hash of parameters to create defaults for all API requests
		# * options (Hash) - Hash used to set default values for all API requests
    def initialize(options = {})
      @character_name = options[:character_name]
      @debug = options[:debug] || false
    end

    # As more API's are created, we might need a place to search for items/guilds/players etc
    # but for now, it's just for players
    def search(string, options = {})
      
			if (string.is_a?(Hash))
				options = string
			else
				options.merge!(:search => string)
			end

      options = merge_defaults(options)

			if options[:search].nil? || options[:search].empty?
				raise "no search string"
			end

			if !@@search_types.has_value?(options[:type])
				raise "invalid search type"
			end

      results = []

      case options[:type]
        when @@search_types[:character]
          results << HonStats::Classes::SearchCharacter.new(string, self)
      end

      return results
      
    end


    def search_characters(name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:search => name)
			end

			options.merge!(:type => @@search_types[:character])
			return search(options)
		end

    
    def get_character(name = @character_name, options = {})
      if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:character_name => name)
				options = {:character_name => @character_name}.merge(options) if (!@character_name.nil?)
			end

      options = merge_defaults(options)

      if options[:character_name].nil? || options[:character_name] == ""
				raise "characer name not specified"
      end

      url = self.base_url + @@requester_file
      character_account_id = Net::HTTP.post_form(URI.parse(url), {"f"=>"nick2id", "nickname[0]"=>"#{options[:character_name]}"})

      return HonStats::Classes::Character.new(character_account_id, self)
    end

    def base_url(options = {})
			str = ""

			if (options[:secure] == true)
				str += 'https://'
			else
				str += 'http://'
			end

  		str += @@stats_url_base

			return str
		end

    # Used to fetch the data from the messy JSON type string sent back from the
    # server, might be a better/faster/cleaner way of doing this
    def self.get_data(attribute, data)
      data = data.body
      data = data.split(attribute)
      data = data[1].split(";")
      data = data[1].split("\"")
      data[1]
    end

    protected

		# Merge the defaults specified in the constructor with those supplied,
		# overriding any defaults with those supplied
		def merge_defaults(options = {})
			defaults = {}
			defaults[:debug] = @debug if @debug

			# overwrite defaults with any given options
			defaults.merge!(options)
		end

  end
end