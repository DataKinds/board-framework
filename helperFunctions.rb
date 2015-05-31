def htmlEscape(html) #http://stackoverflow.com/questions/2123586/how-do-i-html-escape-text-data-in-a-sinatra-app
	CGI.escapeHTML html
end 

def linkify(text) #turn text that has a link into an actual link
	urlRegex = /(https?:\/\/.+)\s?$?/i
	text.match(urlRegex)
	return text.gsub(urlRegex, "<a href=\"#{$&}\">#{$&}</a>")  #$&, you have to match it beforehand because it means last match, not this match ;-;
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
	newlineify(linkify(htmlEscape(text)))
end

