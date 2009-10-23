module HonStats
  class TeamStat < Team

    attr_accessor :wins, :losses, :concedes, :concedevotes, :buybacks, :kicked,
      :avg_score, :herokills, :herodmg, :heroexp, :herokillsgold, :heroassists,
      :deaths, :goldlost2death, :secs_dead, :teamcreepkills, :teamcreepdmg,
      :teamcreepexp, :teamcreepgold, :neutralcreepkills, :neutralcreepdmg,
      :neutralcreepexp, :neutralcreepgold, :bdmg, :bdmgexp, :razed, :bgold,
      :denies, :exp_denied, :gold, :gold_spent, :exp, :actions, :secs,
      :consumables, :wards, :wins, :losses, :concedes, :concedevotes,
      :buybacks, :kicked, :avg_score, :herokills, :herodmg, :heroexp,
      :herokillsgold, :heroassists, :deaths, :goldlost2death, :secs_dead,
      :teamcreepkills, :teamcreepdmg, :teamcreepexp, :teamcreepgold,
      :neutralcreepkills, :neutralcreepdmg, :neutralcreepexp, :neutralcreepgold,
      :bdmg, :bdmgexp, :razed, :bgold, :denies, :exp_denied, :gold, :gold_spent,
      :exp, :actions, :secs, :consumables, :wards

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if TeamStat.instance_methods.include? k }
      end
    end

  end
end