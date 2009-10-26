module HonStats
  class Account < Base
    attr_reader :user_id, :nickname

    def initialize(params)
      params.each do |key|
        key.each { |k, v| instance_variable_set("@#{k}", v) if Account.instance_methods.include? k }
      end
    end

    # Get this overall character stats
    def character_stats
      Character.find_by_id(self.user_id)
    end

    # Get this accounts hero usage
    def hero_usage
      CharacterHeroUsage.find_by_id(self.user_id)
    end

    # Lookup an account nickname by id
    def self.find_nickname_by_id(*user_id)
      params = { 'opt' => 'aid', 'aid[]' => user_id }
      parse_stats(construct_url("id2nick", params))
    end

    # Lookup an account id by nickname
    def self.find_id_by_nickname(*nickname)
      params = { 'opt' => 'nick', "nick[]" => nickname }
      parse_stats(construct_url("nick2id", params))
    end

    private
    def self.parse_stats(url)
      if (result = get_xml_data(url))

        accounts = []
        result.find('//accounts/account_id').each do |a|
          account = []
          account << { 
            'nickname' => a.find_first('@nick').value,
            'user_id' => a.content
          }
          accounts << Account.new(account)
        end

        result.find('//accounts/nickname').each do |a|
          account = []
          account << {
            'user_id' => a.find_first('@aid').value,
            'nickname' => a.content
          }
          accounts << Account.new(account)
        end

        returner(accounts)
      else
        nil
      end
    end
  end

end