$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    class Character
      attr_reader :account_id, :character_name, :account, :building, :creep,
                  :game, :hero, :last_match, :neutral

      alias_method :to_s, :character_name
      alias_method :to_i, :account_id

      def initialize(data, api = nil)
        @api = api
        data = data.body

        if data.is_a?(String)
          output = data.split(";")

          split = output[3].split("\"")
          @account_id = split[1].to_i

        elsif data.is_a?(Integer)
          @account_id = data
        end

        url = base + @api.requester_file
        data = Net::HTTP.post_form(URI.parse(url), {"f"=>"get_all_stats", "account_id[0]"=>"#{@account_id}"})
        if data.class.to_s == "Net::HTTPOK"

          @account_id =           HonStats::API.get_data("account_id", data).to_i
          @character_name =       HonStats::API.get_data("nickname", data).to_s
          @account =              Account.new(data)
          @building =             Building.new(data)
          @creep =                Creep.new(data)
          @game =                 Game.new(data)
          @hero =                 Hero.new(data)
          @last_match =           LastMatch.new(data)
          @neutral =              Neutral.new(data)

        end
      end

      protected

      # Return the base_url of the API if available, otherwise send back the default
			def base
				if @api
					return @api.base_url
				else
					return 'http://masterserver.hon.s2games.com/'
				end
			end

    end

    # Consilidated Account stats
		class Account
			attr_reader :id, :name, :created_at

			def initialize(data)
        @id =         HonStats::API.get_data("account_id", data).to_i
        @name =       HonStats::API.get_data("nickname", data).to_s
				@created_at = HonStats::API.get_data("create_date", data).to_s
			end
		end

    # Consilidated game stats
		class Game
			attr_reader :wins, :losses, :win_percentage, :disconnects, :time_played,
                  :level, :gold_earned, :gold_spent, :xp_earned, :actions_made
                  :average_score

			def initialize(data)
				@wins =           HonStats::API.get_data("acc_wins", data).to_i
        @losses =         HonStats::API.get_data("acc_losses", data).to_i
        @win_percentage = "%.02f" % ((@wins.to_f / (@wins + @losses)) * 100)
        @disconnects =    HonStats::API.get_data("acc_discos", data).to_i
        @time_played =    HonStats::API.get_data("acc_secs", data).to_i
        @level =          HonStats::API.get_data("level", data).to_i
        @gold_earned =    HonStats::API.get_data("acc_gold", data).to_i
        @gold_spent =     HonStats::API.get_data("acc_gold_spent", data).to_i
        @xp_earned =      HonStats::API.get_data("acc_exp", data).to_i
        @actions_made =   HonStats::API.get_data("acc_actions", data).to_i
        @average_score =  HonStats::API.get_data("acc_avg_score", data).to_f
			end
		end

    # Consilidated creep stats
		class Creep
			attr_reader :kills, :damage, :xp, :gold, :denies, :denied_xp

			def initialize(data)
				@kills =     HonStats::API.get_data("acc_teamcreepkills", data).to_i
        @damage =    HonStats::API.get_data("acc_teamcreepdmg", data).to_i
        @xp =        HonStats::API.get_data("acc_teamcreepexp", data).to_i
        @gold =      HonStats::API.get_data("acc_teamcreepgold", data).to_i
        @denies =    HonStats::API.get_data("acc_denies", data).to_i
        @denied_xp = HonStats::API.get_data("acc_exp_denied", data).to_i
			end
		end

    # Consilidated neutral creep stats
		class Neutral
			attr_reader :kills, :damage, :xp, :gold

			def initialize(data)
				@kills =  HonStats::API.get_data("acc_neutralcreepkills", data).to_i
        @damage = HonStats::API.get_data("acc_neutralcreepdmg", data).to_i
        @xp =     HonStats::API.get_data("acc_neutralcreepexp", data).to_i
        @gold =   HonStats::API.get_data("acc_neutralcreepgold", data).to_i
			end
		end

    # Consilidated hero stats
		class Hero
			attr_reader :kills, :damage, :xp, :gold, :assists, :deaths, :gold_lost, :seconds_dead, :buybacks

			def initialize(data)
				@kills =        HonStats::API.get_data("acc_herokills", data).to_i
        @damage =       HonStats::API.get_data("acc_herodmg", data).to_i
        @xp =           HonStats::API.get_data("acc_heroexp", data).to_i
        @gold =         HonStats::API.get_data("acc_herokillsgold", data).to_i
        @assists =      HonStats::API.get_data("acc_heroassists", data).to_i
        @deaths =       HonStats::API.get_data("acc_deaths", data).to_i
        @gold_lost =    HonStats::API.get_data("acc_goldlost2death", data).to_i
        @seconds_dead = HonStats::API.get_data("acc_secs_dead", data).to_i
        @buybacks =     HonStats::API.get_data("acc_buybacks", data).to_i
			end
		end

    # Consilidated neutral creep stats
		class Building
			attr_reader :damage, :xp, :raized, :gold

			def initialize(data)
				@damage = HonStats::API.get_data("acc_bdmg", data).to_i
        @xp =     HonStats::API.get_data("acc_bdmgexp", data).to_i
        @raized = HonStats::API.get_data("acc_razed", data).to_i
        @gold =   HonStats::API.get_data("acc_bgold", data).to_i
			end
		end

    # Consilidated last match stats
		class LastMatch
			attr_reader :id, :date

			def initialize(data)
				@id =   HonStats::API.get_data("match_id", data).to_i
        @date = HonStats::API.get_data("mdt", data).to_s
			end
		end

    class	SearchCharacter < Character
		end
  end
end