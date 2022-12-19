require 'spec_helper'
require_relative '../caesar_cipher'

RSpec.describe 'Caesar Cipher' do

  describe 'return the code' do 

    it 'returns the word code' do
      expect(caesar_cipher('cat', 4)).to eq('gex')
    end


    it 'returns the phrase code' do
      expect(caesar_cipher('i am happy', 7)).to eq('p ht ohwwf')
    end

    it 'returns the sentence code' do
      expect(caesar_cipher('What a string!', 5)).to eq('Bmfy f xywnsl!')
    end

    it 'returns the random character code' do
      expect(caesar_cipher('asd Fsakjf !! asdiEWWEFA', 13)).to eq('nfq Sfnxws !! nfqvRJJRSN')
    end

  end
end
