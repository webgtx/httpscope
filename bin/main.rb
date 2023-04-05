require "net/http"


module CORE
	class WebFetcher
		def self.fetch(uri)
			url = URI.parse(uri)
			res = Net::HTTP.get_response(url)

			headers = res.to_hash

			headers.each do |header, value|
				case header
				when "server"
					case value[0].downcase
					when "caddy" 
						puts File.read("assets/computer.dat")
					when "nginx"
						puts File.read("assets/pinguin.dat")
					end
					puts "
						#{'host'.ljust(10)}: #{uri}
						#{header.ljust(10)}: #{value.join(", ")} 
					"
				end
			end

			puts res.length
		end
	end
end

