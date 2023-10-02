task default: :test

task :test do 
	# ruby "test/unit_test.rb"
	ruby "bin/httpscope fetch https://webgtx.me"
end

task :multifetch do
	url_list = [
		"init64.ltd",
		"getfedora.org",
		"webgtx.me",
		"github.com",
		"google.com"
	]

	url_list.each do |url|
		ruby "bin/httpscope fetch https://#{url}"
	end
end