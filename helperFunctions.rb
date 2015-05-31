def htmlEscape(html) #http://stackoverflow.com/questions/2123586/how-do-i-html-escape-text-data-in-a-sinatra-app
	CGI.escapeHTML html
end 

def linkify(text) #turn text that has a link into an actual link
	urlRegex = /https?:\/\/\S+/i
	outText = text
	text.scan(urlRegex).each do |match|
		outText.gsub!(match, "<a href=\"#{match}\">#{match}</a>")
	end
	return outText
end

def idlinking(text)
	idRegex = /id(\d{1,3})/i
	outText = text
	text.scan(idRegex).each do |idSingleArray|
		idSingleArray.each do |match| #each.each it's weird it's because i matched with ()
			outText.gsub!(match, "<a href=\"#{match}\">#{match}</a>")
		end
	end
	return outText
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
	newlineify(linkify(idlinking(htmlEscape(text))))
end

