$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    class Character
      attr_reader :account_id, :character_name, :level, :wins, :losses, :buybacks,
                  :disconnects, :average_score, :hero_kills, :hero_damage, :hero_xp,
                  :hero_kills_gold, :hero_assists, :deaths, :gold_lost_to_deaths,
                  :seconds_dead, :creep_kills, :creep_kills_damage, :creep_kill_xp,
                  :creep_kills_gold, :creep_denies, :creep_denies_xp, :neutral_kills,
                  :neutral_kill_damage, :neutral_kill_xp, :neutral_kill_gold,
                  :building_damage, :building_xp, :building_raized, :building_gold,
                  :gold_earned, :gold_spent, :xp_earned, :actions_made, :time_played,
                  :account_created, :last_match_id, :last_match_date

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

          @level =                get_data("level", data).to_i
          @wins =                 get_data("acc_wins", data).to_i
          @losses =               get_data("acc_losses", data).to_i
          @buybacks =             get_data("acc_buybacks", data).to_i
          @disconnects =          get_data("acc_discos", data).to_i
          @average_score =        get_data("acc_avg_score", data).to_f
          @hero_kills =           get_data("acc_herokills", data).to_i
          @hero_damage =          get_data("acc_herodmg", data).to_i
          @hero_xp =              get_data("acc_heroexp", data).to_i
          @hero_kills_gold =      get_data("acc_herokillsgold", data).to_i
          @hero_assists =         get_data("acc_heroassists", data).to_i
          @deaths =               get_data("acc_deaths", data).to_i
          @gold_lost_to_deaths =  get_data("acc_goldlost2death", data).to_i
          @seconds_dead =         get_data("acc_secs_dead", data).to_i
          @creep_kills =          get_data("acc_teamcreepkills", data).to_i
          @creep_kill_damage =    get_data("acc_teamcreepdmg", data).to_i
          @creep_kill_xp =        get_data("acc_teamcreepexp", data).to_i
          @creep_kill_gold =      get_data("acc_teamcreepgold", data).to_i
          @creep_denies =         get_data("acc_denies", data).to_i
          @creep_denies_xp =      get_data("acc_exp_denied", data).to_i
          @neutral_kills =        get_data("acc_neutralcreepkills", data).to_i
          @neutral_kill_damage =  get_data("acc_neutralcreepdmg", data).to_i
          @neutral_kill_xp =      get_data("acc_neutralcreepexp", data).to_i
          @neutral_kill_gold =    get_data("acc_teamcreepgold", data).to_i
          @building_damage =      get_data("acc_bdmg", data).to_i
          @building_xp =          get_data("acc_bdmgexp", data).to_i
          @building_raized =      get_data("acc_razed", data).to_i
          @building_gold =        get_data("acc_bgold", data).to_i
          @gold_earned =          get_data("acc_gold", data).to_i
          @gold_spent =           get_data("acc_gold_spent", data).to_i
          @xp_earned =            get_data("acc_exp", data).to_i
          @actions_made =         get_data("acc_actions", data).to_i
          @time_played =          get_data("acc_secs", data).to_i
          @character_name =       get_data("nickname", data).to_s
          @account_created =      get_data("create_date", data).to_s
          @last_match_id =        get_data("match_id", data).to_i
          @last_match_date =      get_data("mdt", data).to_s

        end

      end


      protected

      # Used to fetch the data from the messy JSON type string sent back from the
      # server, might be a better/faster/cleaner way of doing this
      def get_data(attribute, data)
        data = data.body
        data = data.split(attribute)
        data = data[1].split(";")
        data = data[1].split("\"")
        data[1]
      end

      # Return the base_url of the API if available, otherwise send back the default
			def base
				if @api
					return @api.base_url
				else
					return 'http://masterserver.hon.s2games.com/'
				end
			end

    end

    class	SearchCharacter < Character
		end
  end
end