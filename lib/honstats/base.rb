module HonStats
  class Base

    # Stats API Hostname
    API_URL = "xml.heroesofnewerth.com"
    # Stats API Filename
    API_FILE = "/xml_requester.php"

    private
    # Constructs a API-friendly URL
    def self.construct_url(api_method, params = nil)
      "#{API_FILE}?f=#{api_method}#{hash2get(params)}"
    end

    # Converts a hash to a GET string
    def self.hash2get(h)
      get_string = ""
      if h
        h.each_pair do |key, value|
          if value.is_a?(String)
            get_string += "&#{key.to_s}=#{CGI::escape(value.to_s)}"
          elsif value.is_a?(Array)
            value.each do |vals|
              get_string += "&#{key.to_s}=#{CGI::escape(vals.to_s)}"
            end
          end
        end
      end
      get_string
    end

    # GET's and parses the XML reply from the API server
    def self.get_xml_data(url)
      xml = nil
      EM.run do
        client = EM::Protocols::HttpClient2.connect(:host => API_URL, :port => 80).get(url)
        client.callback {
          # until the XML's fixed this will have to do
          if client.content.split(/\S+/).size > 5
            xml = XML::Parser.string(client.content).parse
          end
          EM.stop
        }
        client.errback { self.fail }
      end
      xml
    end

    # Allows us to return data from the methods easier
    def self.returner(data)
      if data.size > 1
        data
      elsif data.size == 1
        data[0]
      else
        nil
      end
    end

  end
end