#!/usr/bin/env ruby

require "sinatra"
require "json"

get "/" do
	erb :index
end

get /\A\/(\d{1,3})\z/ do #get any get request that"s "/<1 to 3 digit number>", like a url
	erb :postview
end

get "/createpost" do
	erb :createpost
end

post "/createpost" do
	postListing = Dir["posts/*"]
	postListing.sort! {|a, b| File.basename(a).to_i <=> File.basename(b).to_i } #make sure no posts get accidentally overwritten (sort then rename in reverse)
	postListing.reverse_each do |fileName| #move all the posts up one number...
		File.rename(fileName, File.dirname(fileName) + "/" + (File.basename(fileName).to_i + 1).to_s)
	end
	postFile = File.new("posts/0", "w") #create the post file......
	postFile.write(JSON.generate({"0" => { #......and write the post to it!
									"title" => params["title"], 
									"body" => params["body"]
									}}))
	postFile.close
	if File.exist?("posts/101") #...delete the 101"th one!
		File.delete("posts/101")
	end
	redirect to("/0")
end