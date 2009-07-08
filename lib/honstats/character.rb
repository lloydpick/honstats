$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    class Character
      attr_reader :account_id, :character_name, :account, :building, :clan,
                  :creep, :gamestats, :hero, :last_match, :neutral

      alias_method :to_s, :character_name
      alias_method :to_i, :account_id

      def initialize(data, api = nil)
        @api = api

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
          data = data.body
          @account_id =           HonStats::API.get_data("account_id", data).to_i
          @character_name =       HonStats::API.get_data("nickname", data).to_s
          @account =              Account.new(data)
          @building =             Building.new(data)
          @clan =                 SimpleClan.new(data)
          @creep =                Creep.new(data)
          @hero =                 Hero.new(data)
          @gamestats =            GameStats.new(data, @hero, @creep)
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
			attr_reader :id, :name, :created_at, :last_login, :last_activity

			def initialize(data)
        @id =             HonStats::API.get_data("account_id", data).to_i
        @name =           HonStats::API.get_data("nickname", data).to_s
				@created_at =     Time.parse(HonStats::API.get_data("create_date", data).to_s)
        @last_login =     Time.parse(HonStats::API.get_data("last_login", data).to_s)
        @last_activity =  Time.parse(HonStats::API.get_data("last_activity", data).to_s)
			end
		end

    # Consilidated game stats
		class GameStats
			attr_reader :wins, :losses, :win_percentage, :disconnects, :time_played,
                  :level, :gold_earned, :gold_spent, :xp_earned, :actions_made,
                  :average_score, :xp_earned_per_minute, :gold_earned_per_minute,
                  :actions_per_minute, :average_game_length_in_seconds, :played,
                  :average_kills_per_game, :average_deaths_per_game,
                  :average_assists_per_game, :disconnect_percentage,
                  :average_xp_earned_per_game, :average_creep_kills_per_game,
                  :average_creep_denies_per_game

			def initialize(data, hero_stats, creep_stats)
				@wins =           HonStats::API.get_data("acc_wins", data).to_i
        @losses =         HonStats::API.get_data("acc_losses", data).to_i
        @disconnects =    HonStats::API.get_data("acc_discos", data).to_i
        @played =         @wins + @losses
        @disconnect_percentage = "%.02f" % ((@disconnects.to_f / @played) * 100)
        @win_percentage = "%.02f" % ((@wins.to_f / @played) * 100)
        @time_played =    HonStats::API.get_data("acc_secs", data).to_i
        @level =          HonStats::API.get_data("level", data).to_i
        @gold_earned =    HonStats::API.get_data("acc_gold", data).to_i
        @gold_spent =     HonStats::API.get_data("acc_gold_spent", data).to_i
        @xp_earned =      HonStats::API.get_data("acc_exp", data).to_i
        @actions_made =   HonStats::API.get_data("acc_actions", data).to_i
        @average_score =  HonStats::API.get_data("acc_avg_score", data).to_f
        
        if @time_played > 0
          minutes_played = @time_played / 60
          @xp_earned_per_minute = "%.02f" % (@xp_earned.to_f / minutes_played.to_f)
          @gold_earned_per_minute = "%.02f" % (@gold_earned.to_f / minutes_played.to_f)
          @actions_per_minute = "%.02f" % (@actions_made.to_f / minutes_played.to_f)

          @average_game_length_in_seconds = (@time_played.to_f / @played).to_i

          @average_kills_per_game = "%.02f" % (hero_stats.kills.to_f / @played)
          @average_deaths_per_game = "%.02f" % (hero_stats.deaths.to_f / @played)
          @average_assists_per_game = "%.02f" % (hero_stats.assists.to_f / @played)

          @average_xp_earned_per_game = "%.02f" % (@xp_earned.to_f / @played)

          @average_creep_kills_per_game = "%.02f" % (creep_stats.kills.to_f / @played)
          @average_creep_denies_per_game = "%.02f" % (creep_stats.denies.to_f / @played)
        end
			end
		end

    # Consilidated clan info
    class SimpleClan
      attr_reader :id, :name, :tag, :rank, :icon

      def initialize(data)
        @id =       HonStats::API.get_data("clan_id", data).to_i
        @name =     HonStats::API.get_data("name", data).to_s
        @tag =      HonStats::API.get_data("tag", data).to_s
        @rank =     HonStats::API.get_data("rank", data).to_s
        @icon =     HonStats::API.get_data("file_name", data).to_s
      end
    end

    # Consilidated creep stats
		class Creep
			attr_reader :kills, :damage, :xp, :gold, :denies, :denied_xp, :kills_per_minute,
                  :xp_per_minute, :denies_per_minute, :denied_xp_per_minute

			def initialize(data)
				@kills =     HonStats::API.get_data("acc_teamcreepkills", data).to_i
        @damage =    HonStats::API.get_data("acc_teamcreepdmg", data).to_i
        @xp =        HonStats::API.get_data("acc_teamcreepexp", data).to_i
        @gold =      HonStats::API.get_data("acc_teamcreepgold", data).to_i
        @denies =    HonStats::API.get_data("acc_denies", data).to_i
        @denied_xp = HonStats::API.get_data("acc_exp_denied", data).to_i

        minutes_played = HonStats::API.get_data("acc_secs", data).to_i / 60
        @kills_per_minute = "%.02f" % (@kills.to_f / minutes_played.to_f)
        @xp_per_minute = "%.02f" % (@xp.to_f / minutes_played.to_f)
        @denies_per_minute = "%.02f" % (@denies.to_f / minutes_played.to_f)
        @denied_xp_per_minute = "%.02f" % (@denied_xp.to_f / minutes_played.to_f)
			end
		end

    # Consilidated neutral creep stats
		class Neutral
			attr_reader :kills, :damage, :xp, :gold, :kills_per_minute, :xp_per_minute

			def initialize(data)
				@kills =  HonStats::API.get_data("acc_neutralcreepkills", data).to_i
        @damage = HonStats::API.get_data("acc_neutralcreepdmg", data).to_i
        @xp =     HonStats::API.get_data("acc_neutralcreepexp", data).to_i
        @gold =   HonStats::API.get_data("acc_neutralcreepgold", data).to_i

        minutes_played = HonStats::API.get_data("acc_secs", data).to_i / 60
        @kills_per_minute = "%.02f" % (@kills.to_f / minutes_played.to_f)
        @xp_per_minute = "%.02f" % (@xp.to_f / minutes_played.to_f)
			end
		end

    # Consilidated hero stats
		class Hero
			attr_reader :kills, :damage, :xp, :gold, :assists, :deaths, :gold_lost, 
                  :seconds_dead, :buybacks, :kills_per_minute, :xp_per_minute,
                  :time_dead_percentage, :assists_per_minute, :kill_death_ratio

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

        seconds_played = HonStats::API.get_data("acc_secs", data).to_i
        minutes_played = seconds_played / 60
        @kills_per_minute = "%.02f" % (@kills.to_f / minutes_played.to_f)
        @assists_per_minute = "%.02f" % (@assists.to_f / minutes_played.to_f)
        @xp_per_minute = "%.02f" % (@xp.to_f / minutes_played.to_f)
        @time_dead_percentage = "%.02f" % ((@seconds_dead.to_f / seconds_played.to_f) * 100)
        @kill_death_ratio = "%.02f" % (@kills.to_f / @deaths.to_f)
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
        @date = Time.parse(HonStats::API.get_data("mdt", data).to_s)
			end
		end

    class	SearchCharacter < Character
		end
  end
end
