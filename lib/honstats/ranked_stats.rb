module HonStats
  class RankedStats < Base

    attr_reader :games_played, :wins, :losses, :concedes,
      :concedevotes, :buybacks, :discos, :kicked, :amm_solo_rating, :amm_solo_count,
      :amm_solo_conf, :amm_solo_pset, :amm_team_rating, :amm_team_count, :amm_team_conf,
      :amm_team_prov, :amm_team_pset, :herokills, :herodmg, :heroexp, :herokillsgold,
      :heroassists, :deaths, :goldlost2death, :secs_dead, :teamcreepkills, :teamcreepdmg,
      :teamcreepexp, :teamcreepgold, :neutralcreepkills, :neutralcreepdmg,
      :neutralcreepexp, :neutralcreepgold, :bdmg, :bdmgexp, :razed, :bgold,
      :denies, :exp_denied, :gold, :gold_spent, :exp, :actions, :secs,
      :consumables, :wards, :em_played, :time_earning_exp, :level

    def initialize(params)
      params.each do |key|
        key.each { |k, v| k = k.gsub('rnk_', ''); instance_variable_set("@#{k}", v) if RankedStats.instance_methods.include? k }
      end
    end

  end
end