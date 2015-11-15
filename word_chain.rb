class WordChain
  def initialize(starting_word, target_word, word_list)
    @starting_word = starting_word
    @target_word = target_word
    @word_list = word_list
  end

  def solve
    [@starting_word, *intermediary_words, @target_word]
  end

  private

  def intermediary_words
    return [] if number_of_different_characters(@starting_word, @target_word) <= 1
    (array_of_1_letter_difference_words(@starting_word) & array_of_1_letter_difference_words(@target_word)).slice(1)  
  end

  def array_of_1_letter_difference_words(word)
    limited_list = @word_list.select { |dictionary_word| word.length == dictionary_word.length }

    limited_list.select do |dictionary_word|
      number_of_different_characters(dictionary_word, word) == 1
    end
  end

  def number_of_different_characters(starting_word, target_word)
    starting_word.chars.zip(target_word.chars).count do |letter, target_letter|
      letter != target_letter
    end
  end
end