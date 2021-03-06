module HonStats
  class Clan < Base

    attr_reader :clan_id, :name, :tag, :create_date, :creator, :title,
      :hello_msg, :recruit_txt, :app_accept, :active, :logo, :idleWarn,
      :activeIndex

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if Clan.instance_methods.include? k }
      end
    end

    def roster
      ClanMember.find_by_id(self.clan_id)
    end

    def self.find_by_name(*name)
      params = { 'opt' => 'cname', "cname[]" => name }
      parse_stats(construct_url("clan_info", params))
    end

    def self.find_by_tag(*tag)
      params = { 'opt' => 'tag', "tag[]" => tag }
      parse_stats(construct_url("clan_info", params))
    end

    def self.find_by_id(*clan_id)
      params = { 'opt' => 'cid', 'cid[]' => clan_id }
      parse_stats(construct_url("clan_info", params))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))
        clans = []

        result.find('//clans/clan').each do |c|
          clan = []
          clan << { 'clan_id' => c.find_first('@cid').value }
          c.find('stat').each do |stat|
            clan << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
          end
          clans << Clan.new(clan)
        end

        returner(clans)
      else
        nil
      end
    end

  end
end