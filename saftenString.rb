dangerousCharacters = %w(\ < > =)

def saften(string) #safety, saften, hahah i'm funny
	dangerousCharacters.each do |char|
		string.gsub!(char, ?\ + char) #escape the dangerous character
	end
	return string
end