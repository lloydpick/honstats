module HonStats
  class CharacterHeroUsage < Base

    attr_reader :hero_id, :hero_cli, :nickname, :used, :wins, :losses,
      :concedes, :concedevotes, :buybacks, :discos, :kicked, :pub_skill,
      :pub_count, :amm_solo_rating, :amm_solo_count, :amm_team_rating,
      :amm_team_count, :avg_score, :herokills, :herodmg, :heroexp,
      :herokillsgold, :heroassists, :deaths, :goldlost2death, :secs_dead,
      :teamcreepkills, :teamcreepdmg, :teamcreepexp, :teamcreepgold,
      :neutralcreepkills, :neutralcreepdmg, :neutralcreepexp, :neutralcreepgold,
      :bdmg, :bdmgexp, :razed, :bgold, :denies, :exp_denied, :gold, :gold_spent,
      :exp, :actions, :secs, :consumables, :wards, :time_earning_exp

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k.gsub('ph_', '')}", v) if CharacterHeroUsage.instance_methods.include? k.gsub('ph_', '') }
      end
    end

    # Lookup character hero usage stats by user id
    def self.find_by_id(*user_id)
      params = { 'opt' => 'aid', 'aid[]' => user_id }
      parse_stats(construct_url("player_hero_stats", params))
    end

    # Lookup character hero usage stats by nickname
    def self.find_by_nickname(*nickname)
      params = { 'opt' => 'nick', "nick[]" => nickname }
      parse_stats(construct_url("player_hero_stats", params))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))
        players = []
        result.find('//stats/player_hero_stats').each do |p|

          player = []
          p.find('hero').each do |h|
            hero = []
            hero << { 'user_id' => p.find_first('@aid').value }
            hero << { 'hero_id' => h.find_first('@hid').value }
            hero << { 'hero_cli' => h.find_first('@cli_name').value }

            h.find('stat').each do |stat|
              hero << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
            end
            player << CharacterHeroUsage.new(hero)
          end
          
          players << player
        end

        returner(players)
      else
        nil
      end
    end
    
  end
end