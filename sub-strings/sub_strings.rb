dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def sub_string(string, dictionary)
  
  dictionary.reduce(Hash.new(0)) do |result, word|

    string.downcase.split(" ").each do |item|
      if item.include?(word)
        result[word] += 1
      end
    end

    result

  end

end

sub_string("Howdy partner, sit down! How's it going?", dictionary)