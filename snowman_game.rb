# variables used to track/log the progression of the game

AVAILABLE_LETTERS = ("a".."z").map { |letter| letter }

WORDS = ["apples", "dog", "hangman", "about", "greeting", "season", "winter", "uncommon", "Wednesday", "guessing", "jazz", "jinx", "jiff", "quiz", "faxed", "junk", "huh", "vexed", "easy"]

$incorrect_guesses = 0

# methods used to determine how the game should progress
def check_guess(word, char)
  if word.downcase.include?(char.downcase) && AVAILABLE_LETTERS.include?(char.downcase)
    AVAILABLE_LETTERS.delete(char.downcase)
  else
    AVAILABLE_LETTERS.delete(char.downcase)
    $incorrect_guesses += 1
  end
  puts display_word(word)
end

def has_won?(word)
  display_word(word).split(" ").join("").downcase == word.downcase
end

def has_lost?
  $incorrect_guesses >= 7
end

def display_word(word)
  word.split("").map do |char|
    if AVAILABLE_LETTERS.include?(char.downcase)
      " _ "
    else
      " " + char.downcase + " "
    end
  end
  .join("")
end

def display_snowman
  File.open("snowman_image.txt").each_with_index do |line, index|
    puts line unless index > 20 - ($incorrect_guesses * 3)
  end
  # returning nil prevents the <File> from being returned, which is what File.open will do by default
  return nil
end
