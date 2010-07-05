module HonStats
  class Character < Base

    attr_reader :user_id, :nickname, :total_discos, :total_possible_discos

    attr_accessor :public_stats, :ranked_stats

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if Character.instance_methods.include? k }
      end

      @public_stats = PublicStats.new(params)
      @ranked_stats = RankedStats.new(params)
    end

    # Lookup character stats by nickname
    def self.find_by_nickname(*nickname)
      params = { 'opt' => 'nick', "nick[]" => nickname }
      parse_stats(construct_url("player_stats", params))
    end

    # Lookup character stats by user id
    def self.find_by_id(*user_id)
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
            stats << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
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