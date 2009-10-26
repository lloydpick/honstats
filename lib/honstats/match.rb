module HonStats
  class Match < Base

    attr_reader :match_id, :name, :server_id, :map, :map_version, :time_played,
      :file_host, :file_size, :file_name, :c_state, :version, :mdt, :mname,
      :class, :private, :nm, :sd, :rd, :dm, :league, :max_players, :tier,
      :no_repick, :no_agi, :drp_itm, :no_timer, :rev_hs, :no_swap, :no_int,
      :alt_pick, :veto, :shuf, :no_str, :no_pups, :dup_h, :ap, :ar, :em,
      :rs, :nl, :officl

    attr_accessor :teams

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if Match.instance_methods.include? k }
      end
    end

    def self.find_by_id(*match_id)
      params = { 'opt' => 'mid', 'mid[]' => match_id }
      parse_stats(construct_url("match_stats", params))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))
        stats = []
        matches = []

        result.find('//stats/match').each do |match|

          stats << { 'match_id' => match.find_first('@mid').value }
          match.find('summ/stat').each do |stat|
            stats << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
          end

          m = Match.new(stats)

          heroes = []
          match.find('match_stats/ms').each do |hero|

            herostats = []
            herostats << { 'user_id' => hero.find_first('@aid').value }
            herostats << { 'hero_cli' => hero.find_first('@cli_name').value }
            hero.find('stat').each do |stat|
              herostats << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
            end
            heroes << TeamPlayer.new(herostats)

          end

          teams = []
          match.find('team').each do |team|

            teaminfo = []
            teaminfo << { 'side' => team.find_first('@side').value }
            t = Team.new(teaminfo)

            teamstats = []
            team.find('stat').each do |teamstat|
              teamstats << teamstat.attributes.inject({}) { |h, a| h[a.value.gsub!('tm_', '')] = teamstat.content(); h }
            end
            t.stats = TeamStat.new(teamstats)
            teams << t

          end

          teams.each do |team|
            players = []
            heroes.each do |hero|
              if hero.team == team.side
                players << hero
              end
            end
            team.players = players
          end

          m.teams = teams
          matches << m
        end

        returner(matches)
      else
        nil
      end
    end

  end
end