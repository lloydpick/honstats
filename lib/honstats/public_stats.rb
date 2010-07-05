module HonStats
  class PublicStats < Base

    attr_reader :games_played, :wins, :losses, :concedes,
      :concedevotes, :buybacks, :discos, :kicked, :pub_skill, :pub_count, :pub_pset,
      :avg_score, :herokills, :herodmg, :heroexp, :herokillsgold, :heroassists,
      :deaths, :goldlost2death, :secs_dead, :teamcreepkills, :teamcreepdmg,
      :teamcreepexp, :teamcreepgold, :neutralcreepkills, :neutralcreepdmg,
      :neutralcreepexp, :neutralcreepgold, :bdmg, :bdmgexp, :razed, :bgold,
      :denies, :exp_denied, :gold, :gold_spent, :exp, :actions, :secs,
      :consumables, :wards, :em_played, :time_earning_exp, :level

    def initialize(params)
      params.each do |key|
        key.each { |k, v| k = k.gsub('acc_', ''); instance_variable_set("@#{k}", v) if PublicStats.instance_methods.include? k }
      end
    end

  end
end