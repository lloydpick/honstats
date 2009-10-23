module HonStats
  class Team < Match

    attr_accessor :side

    attr_accessor :players, :stats

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if Team.instance_methods.include? k }
      end
    end

  end
end