#!/usr/bin/env ruby
# encoding: utf-8
require "sinatra"
require "json"
require "cgi"
require "FileUtils"
require_relative "helperFunctions"

set :bind, "0.0.0.0"
set :port, 7778

if !File.directory?("posts")
	Dir.mkdir("posts")
end

if !File.directory?("public/uploads")
	Dir.mkdir("public/uploads")
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

postLimit = 60

def uploadImage(tempfile, filename)
	if (tempfile.size < 2*1000000) && (filename.downcase.end_with? *%w(.jpg .png .gif .jpeg .bmp .tiff))
		randomFileName = (0..9).map { (65 + rand(26)).chr }.join #http://stackoverflow.com/questions/88311/how-best-to-generate-a-random-string-in-ruby
		fullFileName = randomFileName + File.extname(filename)
		FileUtils.copy(tempfile.path, "public/uploads/#{fullFileName}")
		return fullFileName
	else
		return false
	end
end

post "/createpost" do
	image = uploadImage(params["image"][:tempfile], params["image"][:filename])
	if image != false #if the image is smaller than 2 mb and is image
		postListing = Dir["posts/*"]
		if params["title"].gsub(/\s/, "").length >= 2 && params["body"].gsub(/\s/, "").length >= 3 #if there are enough chars
			newPostIndex = postListing.max_by {|s| File.basename(s).to_i } #find the post file with the highest index
			if newPostIndex.nil? #make sure it's not broken if there are no other posts
				newPostIndex = 0
			else #proceed normally, get post number
				newPostIndex = File.basename(newPostIndex).to_i + 1
			end 
			postFile = File.new("posts/#{newPostIndex}", "w:utf-8") #create the post file with next number......
			postFile.write(JSON.generate({"0" => { #......and write the post to it!
											"title" => titleFormat(params["title"])[0..100], 
											"body" => bodyFormat(params["body"])[0..5000],
											"image" => image,
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
	end
	redirect to("/")
end

post "/comment" do
	if params["comment"].gsub(/\s/, "").length >= 2 #if the comment is at least 5 chars
		if params["submitImageCheck"] #post with image
			image = uploadImage(params["image"][:tempfile], params["image"][:filename])
			if image != false
				postHash = JSON.parse(File.read("posts/#{params["postNumber"]}", :encoding => "utf-8"))
				postFile = File.open("posts/#{params["postNumber"]}", "w:utf-8")
				newCommentIndex = (postHash.max_by {|s| s[0].to_i}[0].to_i+1).to_s #get the max index comment, add one, convert back to string
				postHash[newCommentIndex] = {"body" => bodyFormat(params["comment"][0..1000]), 
											 "image" => image,
											 "ip" => request.ip} #post only the first 1000 chars
				postJSON = JSON.generate(postHash)
				postFile.write(postJSON)
				postFile.close
			end
		else #post without image
			postHash = JSON.parse(File.read("posts/#{params["postNumber"]}", :encoding => "utf-8"))
			postFile = File.open("posts/#{params["postNumber"]}", "w:utf-8")
			newCommentIndex = (postHash.max_by {|s| s[0].to_i}[0].to_i+1).to_s #get the max index comment, add one, convert back to string
			postHash[newCommentIndex] = {"body" => bodyFormat(params["comment"][0..1000]), 
										 "ip" => request.ip} #post only the first 1000 chars
			postJSON = JSON.generate(postHash)
			postFile.write(postJSON)
			postFile.close
		end
	end
	redirect to("/#{params["postNumber"]}")
end