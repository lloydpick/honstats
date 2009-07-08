$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    class Clan
      attr_reader :id, :members
      alias_method :to_i, :id

      def initialize(data)
        members = []
        data.each do |roster|
          members << Member.new(roster)
        end
        @members =   members
        @id =        HonStats::API.get_data("clan_id", data[0]).to_i
      end

    end

    class Member
			attr_reader :account_id, :rank, :joined_at, :nickname

			def initialize(data)
        @account_id =     HonStats::API.get_data("account_id", data).to_i
        @rank =           HonStats::API.get_data("rank", data).to_s
        @nickname =       HonStats::API.get_data("nickname", data).to_s
				@joined_at =      Time.parse(HonStats::API.get_data("join_date", data).to_s)
			end
		end
  end
end