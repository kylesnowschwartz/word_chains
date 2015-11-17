require 'byebug'

class WordChain
  def initialize(starting_word, target_word, word_list)
    @starting_word = starting_word
    @target_word = target_word
    @word_list = word_list
    @words_visited = []
  end

  def solve
    [@starting_word, *bridge_words, @target_word]
  end

  private

  def bridge_words
    return [] if difference_in_chars(@starting_word, @target_word) <= 1
    
    one_step_away_words = (minimal_pairs(@starting_word) & minimal_pairs(@target_word)).slice(1)   
    return one_step_away_words if one_step_away_words
    
    # "raw row tow"
    find_bridge_words(@starting_word, @target_word)
  end

  def minimal_pairs(word)
    @limited_list ||= @word_list.select { |dictionary_word| word.length == dictionary_word.length }

    @limited_list.select do |dictionary_word|
      difference_in_chars(dictionary_word, word) == 1
    end
  end

  def difference_in_chars(starting_word, target_word)
    starting_word.chars.zip(target_word.chars).count do |letter, target_letter|
      letter != target_letter
    end
  end

  def find_bridge_words(current_word, target_word)
    next_paths = []
    current_path = [current_word]

    until current_word == target_word
      @words_visited << current_word

      next_paths += (minimal_pairs(current_word) - @words_visited).map { |minimal_pair| current_path + [minimal_pair] }

      current_path = next_paths.shift
      current_word = current_path.last
    end

    p current_path
  end
  
  def mark_visited(word)
    @words_visited.push(word)
  end
end

# list = File.readlines(ARGV[2]).map(&:chomp)

# WordChain.new(ARGV[0].upcase, ARGV[1].upcase, list).solve


  
  # 1 1 2 3 5 8 13
  # def fib(curr, prev, max)
  #   my_next = curr + prev
  #   if my_next == max
  #     return max
  #   else
  #     return "#{curr} #{fib(my_next, curr, max)}"
  #   end
  # end

  # fib(1, 1, 13)


  # def print_path
  # end

  # class Word
  #   def initialize(underlying_word, previous_word)
  #     @previous_word = previous_word
  #     @underlying_word = underlying_word
  #   end
  # end

  # first_word = Word.new("RAW", nil)
  # second_word = Word.new("ROW", first_word)

  # second_word.previous_word

#def bridge_words
  # return target_word if current_word == target_word

  # next_words = minimal_pairs(current_word) - @words_visited

  # if next_words.none?
  #   return nil
  # else
  #   next_words.each do |next_word, target_word|
  #     mark_visited(next_word)

  #     result = recursive_bridge_words(next_word, target_word)

  #     p "#{current_word} #{result}" if result
  #     return "#{current_word} #{result}" if result
  #   end
  # end
#end