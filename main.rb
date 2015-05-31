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
	newPostIndex = postListing.max_by {|s| File.basename(s)} #find the post file with the highest index
	if newPostIndex.nil? #make sure it's not broken if there are no other posts
		newPostIndex = 0
	else #proceed normally, get post number
		newPostIndex = File.basename(newPostIndex).to_i + 1
	end
	postFile = File.new("posts/#{newPostIndex}", "w") #create the post file with next number......
	postFile.write(JSON.generate({"0" => { #......and write the post to it!
									"title" => titleFormat(params["title"]), 
									"body" => bodyFormat(params["body"])
									}}))
	minPostIndex = postListing.min_by {|s| File.basename(s)}
	if minPostIndex.nil? #same checks and stuff
		minPostIndex = 0
	else
		minPostIndex = File.basename(minPostIndex).to_i
	end
	if (newPostIndex - 1) - minPostIndex > postLimit #make sure we're under the max posts
		File.delete("posts/#{minPostIndex}")
	end
	postFile.close
	redirect to("/")
end

post "/comment" do
	postHash = JSON.parse(File.read("posts/#{params["postNumber"]}"))
	postFile = File.open("posts/#{params["postNumber"]}", "w")
	newCommentIndex = (postHash.max_by {|s| s[0].to_i}[0].to_i+1).to_s #get the max index comment, add one, convert back to string
	postHash[newCommentIndex] = {"body" => bodyFormat(params["comment"])}
	postJSON = JSON.generate(postHash)
	postFile.write(postJSON)
	postFile.close
	redirect to("/#{params["postNumber"]}")
end