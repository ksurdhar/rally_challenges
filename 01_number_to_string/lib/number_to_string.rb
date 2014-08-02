ONES = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine"
}

TENS = {
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}

TEENS = {
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen"
}

MAGNITUDES = {
  100 => "hundred",
  1000 => "thousand",
  1_000_000 => "million",
  1_000_000_000 => "billion",
  1_000_000_000_000 => "trillion"
}

class NumberStringifier
  def create_string(int)
    if int.class == Float
      rounded = int.to_s.split(".")[0].to_i
      decimal = int - rounded

      decimal_magnitude = decimal.to_s.split(".")[1].length
      zeroes = ""
      decimal_magnitude.times {|zero| zeroes.concat("0") }
      words = in_words(rounded)
      words.concat(" and #{decimal.to_s.split(".")[1]}/1#{zeroes}")
    else
      in_words(int)
    end
  end

  def in_words(num)
    if (num < 10)
      ONES[num]
    elsif (num < 20)
      TEENS[num]
    elsif (num < 100)
      tens_word = TENS[(num / 10) * 10]
      if (num % 10) != 0
        p num.class
        tens_word + " " + in_words(num % 10)
      else
        tens_word
      end
    else
      magnitude = find_magnitude(num)
      magnitude_words = in_words(num / magnitude) + " " + MAGNITUDES[magnitude]
      if (num % magnitude) != 0
        magnitude_words + " " + in_words(num % magnitude)
      else
        magnitude_words
      end
    end
  end

  def find_magnitude(num)
    MAGNITUDES.keys.take_while { |magnitude| magnitude <= num }.last
  end
end