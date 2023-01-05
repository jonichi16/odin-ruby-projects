module SelectableWords
  WORDS = File.readlines('google_words.txt').each(&:strip!).filter { |word| word.length.between?(5, 12)}
end