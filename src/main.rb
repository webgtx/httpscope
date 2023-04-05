require "net/http"

url = URI.parse(ARGV[0])
res = Net::HTTP.get_response(url)

headers = res.to_hash

headers.each do |header, value|
	case header
	when "server" 
		puts "#{header}: #{value.join(", ")}"
		# puts "#{value}"
	end
end

puts res.length