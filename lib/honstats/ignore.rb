$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    module Ignorelist
      class Ignorelist
        attr_reader :id, :ignores
        alias_method :to_i, :id

        def initialize(data)
          if data[0]
            ignores = []
            data.each do |ignore|
              ignores << Ignore.new(ignore)
            end
            @ignores = ignores
            @id =      HonStats::API.get_data("account_id", data[0]).to_i
          end
        end

      end

      class Ignore
        attr_reader :account_id, :ignored_id, :nickname

        def initialize(data)
          @account_id =     HonStats::API.get_data("account_id", data).to_i
          @ignored_id =     HonStats::API.get_data("ignored_id", data).to_i
          @nickname =       HonStats::API.get_data("nickname", data).to_s
#  				@reason =         HonStats::API.get_data("reason", data).to_s
#	  			@ignored_at =     Time.parse(HonStats::API.get_data("ignore_date", data).to_s)
        end
      end
    end
  end
end