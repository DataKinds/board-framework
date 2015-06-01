#!/usr/bin/env ruby

require "sinatra"
require "json"
require "cgi"
require_relative "helperFunctions"

set :bind, "0.0.0.0"
set :port, 12975

if !File.directory?("posts")
	Dir.mkdir("posts")
end

if !File.exist?("ipcolor")
	File.open("ipcolor", "w") { |file| file.write("{}") }
end

get "*" do #make sure the ip is in the ipcolor database
	ipListing = JSON.parse(File.read("ipcolor"))
	if !ipListing.has_key?(request.ip)
		ipListing[request.ip] = genRandomBrightColor()
	end
	File.open("ipcolor", "w") { |file| file.write(JSON.generate(ipListing)) }
	pass
end

get "/" do
	erb :index
end

get /\A\/(\d{1,3})\z/ do #get any get request that"s "/<1 to 3 digit number>", like a url
	erb :postview
end

get "/createpost" do
	erb :createpost
end

postLimit = 500

post "/createpost" do
	postListing = Dir["posts/*"]
	if params["title"].length > 4 && params["body"].length > 5 #if there are enough chars
		newPostIndex = postListing.max_by {|s| File.basename(s).to_i } #find the post file with the highest index
		if newPostIndex.nil? #make sure it's not broken if there are no other posts
			newPostIndex = 0
		else #proceed normally, get post number
			newPostIndex = File.basename(newPostIndex).to_i + 1
		end
		postFile = File.new("posts/#{newPostIndex}", "w") #create the post file with next number......
		postFile.write(JSON.generate({"0" => { #......and write the post to it!
										"title" => titleFormat(params["title"])[0..150], 
										"body" => bodyFormat(params["body"])[0..5000],
										"ip" => request.ip
										}}))
		minPostIndex = postListing.min_by {|s| File.basename(s).to_i }
		if minPostIndex.nil? #same checks and stuff
			minPostIndex = 0
		else
			minPostIndex = File.basename(minPostIndex).to_i
		end
		if (newPostIndex - 1) - minPostIndex > postLimit #make sure we're under the max posts
			File.delete("posts/#{minPostIndex}")
		end
		postFile.close
	end
	redirect to("/")
end

post "/comment" do
	if (params["comment"].length) >= 5 #if the comment is at least 5 chars
		postHash = JSON.parse(File.read("posts/#{params["postNumber"]}"))
		postFile = File.open("posts/#{params["postNumber"]}", "w")
		newCommentIndex = (postHash.max_by {|s| s[0].to_i}[0].to_i+1).to_s #get the max index comment, add one, convert back to string
		postHash[newCommentIndex] = {"body" => bodyFormat(params["comment"][0..1000]), "ip" => request.ip} #post only the first 1000 chars
		postJSON = JSON.generate(postHash)
		postFile.write(postJSON)
		postFile.close
	end
	redirect to("/#{params["postNumber"]}")
end