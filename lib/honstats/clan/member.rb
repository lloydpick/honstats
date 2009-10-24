module HonStats
  class ClanMember < Base

    attr_reader :clan_id, :clan_name, :clan_tag, :nickname, :rank, :message,
      :join_date

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if ClanMember.instance_methods.include? k }
      end
    end

    def self.find_by_name(*name)
      params = { 'opt' => 'cname', "cname[]" => name }
      parse_stats(construct_url("clan_roster", params))
    end

    def self.find_by_tag(*tag)
      params = { 'opt' => 'tag', "tag[]" => tag }
      parse_stats(construct_url("clan_roster", params))
    end

    def self.find_by_id(*clan_id)
      params = { 'opt' => 'cid', 'cid[]' => clan_id }
      parse_stats(construct_url("clan_roster", params))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))
        members = []

        result.find('//clans/clan_roster').each do |c|
          c.find('member').each do |m|
            member = []
            member << { 'clan_id' => c.find_first('@cid').value }
            member << { 'clan_tag' => c.find_first('@tag').value }
            member << { 'clan_name' => c.find_first('@cname').value }
            m.find('stat').each do |stat|
              member << stat.attributes.inject({}) { |h, a| h[a.value] = stat.content(); h }
            end
            members << ClanMember.new(member)
          end
        end

        returner(members)
      else
        nil
      end
    end

  end
end