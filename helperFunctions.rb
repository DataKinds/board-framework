def htmlEscape(html) #http://stackoverflow.com/questions/2123586/how-do-i-html-escape-text-data-in-a-sinatra-app
	CGI.escapeHTML html
end 

def linkify(text) #turn text that has a link into an actual link
	urlRegex = /https?:\/\/\S+/i
	return text.gsub(urlRegex) { |match| "<a href=\"#{match}\">#{match}</a>" }
end

def idlinking(text)
	idRegex = /id(\d{1,3})/i
	return text.gsub(idRegex) { |match| "<a href=\"#{match[2, match.length-1]}\">#{match}</a>" }
end

def emoticonify(text)
	emoticonTable = %w(420 colonP evil girl love kiss lester poo sad tophat wofl)
	emoticonTable.each do |name|
		text.gsub!(/:#{name}:/) { |match| "<img title=\":#{name}:\" class=\"emote\" src=\"/emotes/#{name}.png\">"}
	end
	text.gsub!(/:b3bomber:/) { |match| "<img class=\"emote\" title=\":triforcewofl:\" src=\"/emotes/NORMIESGETOFFMYBOARD.png\">"} #the special emote
	return text
end

def removecarriagereturns(text)
	text.gsub(?\r, "")
end

def compressnewlines(text)
	text.gsub(/(\n+)/, "\n")
end

def newlineify(text)
	text.gsub(/\n+/, "<br>")
end

def nolineify(text)
	text.gsub(/\n+/, " ")
end

def bodyFormat(bodyText) #parse every function for storage together
	compressnewlines(removecarriagereturns(bodyText))
end

def titleFormat(titleText)
	nolineify(bodyFormat(titleText))
end

def p(text) #parse every function for displaying together
	emoticonify(newlineify(linkify(idlinking(htmlEscape(text)))))
end

def genRandomBrightColor() #http://stackoverflow.com/questions/1698318/ruby-generate-a-random-hex-color
	r = rand(255)
	g = rand(255)
	b = rand(255)
	while r+g+b > 255*1.1 && r+g+b < 255*2.2 #medium brightness (crappy math okay)
		r = rand(255)
		g = rand(255)
		b = rand(255)
	end
	r, g, b = [r, g, b].map { |s| if s.to_s(16).size == 1 then '0' + s.to_s(16) else s.to_s(16) end }
	return "#" + r + g + b
end

def getColorFromIP(ip)
	colorJSON = JSON.parse(File.read("ipcolor"))
	return colorJSON[ip]
end

def getShowableColorFromIP(ip)
	if ip == "98.177.186.172"
		return JSON.parse(File.read("ipcolor"))[ip] +" (admin)"
	else
		return JSON.parse(File.read("ipcolor"))[ip]
	end
end