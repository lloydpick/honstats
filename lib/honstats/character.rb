module HonStats
  class Character < Base

    attr_accessor :user_id, :nickname, :games_played, :wins, :losses, :concedes,
      :concedevotes, :buybacks, :discos, :kicked, :pub_skill, :pub_count,
      :amm_solo_rating, :amm_solo_count, :amm_team_rating, :amm_team_count,
      :avg_score, :herokills, :herodmg, :heroexp, :herokillsgold, :heroassists,
      :deaths, :goldlost2death, :secs_dead, :teamcreepkills, :teamcreepdmg,
      :teamcreepexp, :teamcreepgold, :neutralcreepkills, :neutralcreepdmg,
      :neutralcreepexp, :neutralcreepgold, :bdmg, :bdmgexp, :razed, :bgold,
      :denies, :exp_denied, :gold, :gold_spent, :exp, :actions, :secs,
      :consumables, :wards, :AR, :AREM, :AP, :APEM, :level

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if Character.instance_methods.include? k }
      end
    end

    def self.find_by_nickname(nickname, *others)
      nickname = nickname.to_a | others if others
      params = { 'opt' => 'nick', "nick[]" => nickname }
      parse_stats(construct_url("player_stats", params))
    end

    def self.find_by_id(user_id, *others)
      user_id = user_id.to_s.to_a | others if others
      params = { 'opt' => 'aid', 'aid[]' => user_id }
      parse_stats(construct_url("player_stats", params))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))
        stats = []
        chars = []

        result.find('//player_stats').each do |player|
          stats << { 'user_id' => player.find_first('@aid').value }
          player.find('stat').each do |stat|
            stats << stat.attributes.inject({}) { |h, a| h[a.value.gsub('acc_', '')] = stat.content(); h }
          end
          chars << Character.new(stats)
        end

        returner(chars)
      else
        nil
      end
    end
    
  end
end