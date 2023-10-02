require "net/http"
require "artii"
require "colorize"
require "terminal-table"
require "nokogiri"
$artii = Artii::Base.new font: "slant" 


module CORE
	class WebFetcher
		def self.fetch(uri)
			timestamp = Time.now
			url	= URI.parse(uri)
			rows = Array.new 

			begin
				res = Net::HTTP.get_response(url)
			rescue => exception
				puts exception
				exit 1
			end

			res_time = Time.now - timestamp
			server_logo = String.new
			headers = res.to_hash


			headers.each do |header, value|
				case header
				when "server"
					server_logo = value[0]
					server_logo[0] = server_logo[0].upcase
					server_logo = $artii.asciify(value[0]).blue.blink
					rows << ["host", uri]
					rows << [header, value.join(", ")]
				when "content-length"
					rows << [header.split("-").join(" "), "#{(value[0].to_i / 1024.0).round(2)} KB"]
				else
					if res.code == "302" 
						server_logo = $artii.asciify("Redirect").red.blink
					end
				end
			end

			doc = Nokogiri.HTML5(res.body) 
			rows << ["status", res.code]
			rows << ["response time", "#{res_time.round(3)} sec(s)"]
			rows << ["scripts", doc.xpath("//script").count]

			table = Terminal::Table.new(
				title: server_logo,
				rows: rows,
				style: {
					border_x: " ",
					border_y: " ",
					border_i: "x"
				} 
			) 

			puts table
		end
	end
end

