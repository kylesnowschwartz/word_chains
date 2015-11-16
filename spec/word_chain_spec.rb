require_relative '../word_chain.rb'

RSpec.describe WordChain do
  def number_of_different_characters(starting_word, target_word)
    p "starting_word: #{starting_word}"
    p "target_word: #{target_word}"
    starting_word.chars.zip(target_word.chars).count do |letter, target_letter|
      letter != target_letter
    end
  end

  def words
    @words ||= File.readlines('words.txt').map(&:chomp)
  end

  CASES = [
    ["RAW", "ROW"],
    ["RAW", "TOW"],
    # ["TURKEY", "CARROT"]
    ["RAW", "TOE"]
  ]

  CASES.each do |starting_word, target_word|
    describe "#solve from #{starting_word} to #{target_word}" do
      subject { WordChain.new(starting_word, target_word, words).solve }

      it "returns an array of words" do
        expect(subject).to be_an Array 
      end

      it "starts with the starting_word" do
        expect(subject.first).to eq starting_word
      end

      it "ends with the target_word" do
        expect(subject.last).to eq target_word
      end

      # TODO - make this it block more sensical
      it "differs from the previous word by a single letter" do
        subject.reduce do |previous_word, next_word|
          expect(number_of_different_characters(previous_word, next_word)).to eq 1

          next_word
        end
      end

      it "only returns valid words" do
        subject.each do |word|
          expect(words).to include word
        end
      end
    end
  end
end

