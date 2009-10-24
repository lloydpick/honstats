module HonStats
  class TeamPlayer < Match

    attr_reader :user_id, :hero_cli, :nickname, :cli_name, :clan_id, :hero_id,
      :position, :team, :level, :wins, :losses, :concedes, :concedevotes,
      :buybacks, :discos, :kicked, :pub_skill, :pub_count, :amm_solo_rating,
      :amm_solo_count, :amm_team_rating, :amm_team_count, :avg_score,
      :herokills, :herodmg, :heroexp, :herokillsgold, :heroassists, :deaths,
      :goldlost2death, :secs_dead, :teamcreepkills, :teamcreepdmg,
      :teamcreepexp, :teamcreepgold, :neutralcreepkills, :neutralcreepdmg,
      :neutralcreepexp, :neutralcreepgold, :bdmg, :bdmgexp, :razed, :bgold,
      :denies, :exp_denied, :gold, :gold_spent, :exp, :actions, :secs,
      :consumables, :wards

    attr_reader :team

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if TeamPlayer.instance_methods.include? k }
      end
    end

  end
end