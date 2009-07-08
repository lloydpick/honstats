$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    module Banlist
      class Banlist
        attr_reader :id, :bans
        alias_method :to_i, :id

        def initialize(data)
          if bans[0]
            bans = []
            data.each do |ban|
              bans << Ban.new(ban)
            end
            @bans =    bans
            @id =      HonStats::API.get_data("account_id", bans[0]).to_i
          end
        end

      end

      class Ban
        attr_reader :account_id, :banned_id, :nickname, :reason, :banned_at

        def initialize(data)
          @account_id =     HonStats::API.get_data("account_id", data).to_i
          @banned_id =      HonStats::API.get_data("banned_id", data).to_i
          @nickname =       HonStats::API.get_data("nickname", data).to_s
#  				@reason =         HonStats::API.get_data("reason", data).to_s
#	  			@banned_at =      Time.parse(HonStats::API.get_data("ban_date", data).to_s)
        end
      end
    end
  end
end