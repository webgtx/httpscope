require "net/http"
require "artii"
require "colorize"
require "terminal-table"
$artii = Artii::Base.new font: "slant" 


module CORE
	class WebFetcher
		def self.fetch(uri)
			url 			= URI.parse(uri)
			timepoint = Time.now
			res 			= Net::HTTP.get_response(url)
			res_time	= Time.now - timepoint
			rows 			= Array.new 

			server_logo = String.new
			headers = res.to_hash

			headers.each do |header, value|
				case header
				when "server"
					server_logo = value[0]
					server_logo[0] = server_logo[0].upcase
					server_logo = $artii.asciify value[0]
					rows << ["host", uri]
					rows << [header, value.join(", ")]
				when "content-length"
					rows << [header.split("-").join(" "), "#{(value[0].to_i / 1024.0).round(2)} KB"]
				end
			end
			rows << ["response time", "#{res_time.round(2)} sec"]

			table = Terminal::Table.new(
				title: server_logo.blue.blink,
				# headings: ["header", "content"],
				rows: rows,
				style: {
					border_x: " ",
					border_y: " ",
					border_i: "x"
				} 
			) 

			puts table
			# puts headers, res.length
		end
	end
end

