$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HonStats
  module Classes
    class Server
      attr_reader :id, :session, :ip, :port

      alias_method :to_i, :id

      def initialize(data)
        @id =        HonStats::API.get_data("server_id", data).to_i
        @session =   HonStats::API.get_data("session", data).to_s
        @ip =        HonStats::API.get_data("ip", data).to_s
        @port =      HonStats::API.get_data("port", data).to_s
      end

    end
  end
end