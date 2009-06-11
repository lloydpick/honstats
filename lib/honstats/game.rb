$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    class Game
      attr_reader :server_id, :session, :name, :class, :private, :modes,
                  :max_players, :tier, :official, :ip, :port, :players, :state,
                  :last_update, :location

      alias_method :to_i, :server_id
      alias_method :to_s, :name

      def initialize(data)
        @server_id =    HonStats::API.get_data("server_id", data).to_i
        @session =      HonStats::API.get_data("session", data).to_s
        @name =         HonStats::API.get_data("mname", data).to_s
        @class =        HonStats::API.get_data("class", data).to_i
        @private =      HonStats::API.get_data("private", data).to_i
        @max_players =  (HonStats::API.get_data("max_players", data).to_i * 2)
        @tier =         HonStats::API.get_data("tier", data).to_i
        @official =     HonStats::API.get_data("officl", data).to_i
        @ip =           HonStats::API.get_data("ip", data).to_s
        @port =         HonStats::API.get_data("port", data).to_i
        @players =      HonStats::API.get_data("num_conn", data).to_i
        @state =        HonStats::API.get_data("c_state", data).to_i
        @last_update =  Time.parse(HonStats::API.get_data("last_upd", data).to_s)
        @location =     HonStats::API.get_data("location", data).to_s
        @modes =        Modes.new(data)
      end

    end

    # Consilidated modes
		class Modes
			attr_reader :normal_mode, :single_draft, :random_draft, :death_match,
                  :league, :no_repick, :no_agility, :item_drop, :no_respawn_timer,
                  :no_swap, :no_intelligence, :alternate_picking, :no_strength,
                  :no_powerups, :duplicate_hero, :all_pick, :all_random,
                  :easy_mode, :rs, :no_leavers, :reverse_hero, :veto,
                  :shuffle_players

			def initialize(data)
        @normal_mode =       HonStats::API.get_data("nm", data).to_i
        @single_draft =      HonStats::API.get_data("sd", data).to_i
        @random_draft =      HonStats::API.get_data("rd", data).to_i
        @death_match =       HonStats::API.get_data("dm", data).to_i
        @league =            HonStats::API.get_data("league", data).to_i
        @no_repick =         HonStats::API.get_data("no_repick", data).to_i
        @no_agility =        HonStats::API.get_data("no_agi", data).to_i
        @item_drop =         HonStats::API.get_data("drp_itm", data).to_i
        @no_respawn_timer =  HonStats::API.get_data("no_timer", data).to_i
        @no_swapping =       HonStats::API.get_data("no_swap", data).to_i
        @no_intelligence =   HonStats::API.get_data("no_int", data).to_i
        @alternate_picking = HonStats::API.get_data("alt_pick", data).to_i
        @no_strength =       HonStats::API.get_data("no_str", data).to_i
        @no_powerups =       HonStats::API.get_data("no_pups", data).to_i
        @duplicate_hero =    HonStats::API.get_data("dup_h", data).to_i
        @all_pick =          HonStats::API.get_data("ap", data).to_i
        @all_random =        HonStats::API.get_data("ar", data).to_i
        @easy_mode =         HonStats::API.get_data("em", data).to_i
        @rs =                HonStats::API.get_data("rs", data).to_i
        @no_leavers =        HonStats::API.get_data("nl", data).to_i
        @reverse_hero =      HonStats::API.get_data("rev_hs", data).to_i
        @veto =              HonStats::API.get_data("veto", data).to_i
        @shuffle_players =   HonStats::API.get_data("shuf", data).to_i
			end
		end

  end
end