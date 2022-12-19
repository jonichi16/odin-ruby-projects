def caesar_cipher(string, shift)
  string_converted = string.split("").map do |char|
    if char.ord.between?(65, 90) # To check if capital letter or not
      if (char.ord + shift) > 90
        char.ord + shift - 26 # To loop back to A if character exceeds Z
      else
        char.ord + shift
      end
    elsif char.ord.between?(97, 122) # To check if not a capital letter
      if (char.ord + shift) > 122
        char.ord + shift - 26 # To loop back to a if character exceeds z
      else
        char.ord + shift
      end
    else
      char.ord
    end
  end

  code_string = string_converted.map  do |number|
    number.chr
  end

  p code_string.join("")
  code_string.join("")
end

# caesar_cipher("What a string!", 5)