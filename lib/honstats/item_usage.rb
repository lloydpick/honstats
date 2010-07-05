module HonStats
  class ItemUsage < Base

    attr_reader :item_id, :cli_name, :used

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if ItemUsage.instance_methods.include? k }
      end
    end

    def self.fetch
      parse_stats(construct_url("item_usage"))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))
        stats = []

        result.find('//usage/item_usage').each do |h|
          hero = []
          hero << { 'item_id' => h.find_first('@id').value }
          h.find('stat').each do |stat|
            hero << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
          end
          stats << ItemUsage.new(hero)
        end

        returner(stats)
      else
        nil
      end
    end

  end
end