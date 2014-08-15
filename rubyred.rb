#!/usr/bin/ruby
 
# post to redmatrix with ruby
# by Tazman Deville tazdvl@red.liberame.org

require 'tempfile'
require 'uri'
require 'net/http'
require 'json'

# you MUST change the values for REDUSER, REDPASS, and REDURL
# to your red username (e-mail associated with your account,
# red password, and the url of your redmatrix hub, respectively.

   
# create temporary file
f = Tempfile.new("rubyred")

begin
	# write update file in vim
	system("vim", f.path)

		# open update file into variable ud (update).
		#File.open(f.path) do|file|
		$update = IO.read(f.path)
			#file.readlines
		puts "Enter a title: "
		$title = gets
		puts "To which channel shall we post? "
		$channel = gets
    
		uri = URI.parse("https://REDURLD.TLD/api/statuses/update.xml/")
     
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Post.new(uri.request_uri)
		request.basic_auth("REDUSER", "REDPASS")
		request.set_form_data({"source" => "red.rb", "channel" => $channel.chomp, "status" => $update, "title" => $title.chomp })
		response = http.request(request)
      
		puts "-------------"
		puts response.inspect
		ensure
		f.close
end

