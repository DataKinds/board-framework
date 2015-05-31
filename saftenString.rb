def jsonSanitizeString(string)
	string.gsub!(?\\, "\\\\") #replace 1 backslash with 2
	string.gsub!(?\n, "\\n")
	string.gsub!(?\b, "\\b")
	string.gsub!(?\f, "\\f")
	string.gsub!(?\r, "\\r")
	string.gsub!(?\t, "\\t")
	string.gsub!("\"", ?") #replace a " with a \" (who the hell designed the ? notation :(, it autoescapes " )
	return string
end