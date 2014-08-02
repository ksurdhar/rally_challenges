class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit, @value = suit, value
  end

  SUIT_STRINGS = {
    :clubs    => "c",
    :diamonds => "d",
    :hearts   => "h",
    :spades   => "s"
  }

  VALUE_STRINGS = {
    :two   => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.royal_values
    VALUE_STRINGS.keys[-5..-1]
  end

  def self.values
    VALUE_STRINGS.keys
  end

  def to_s
    VALUE_STRINGS[value] + SUIT_STRINGS[suit]
  end
end

class Hand
  attr_accessor :cards

  def initialize
    deck = Hand.all_cards
    @cards = deck.shuffle!.shift(5)
  end

  def self.all_cards
    Card.suits.product(Card.values).map do |suit, value|
      Card.new(suit, value)
    end
  end

  RANKS = [
    :royal_flush,
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card
  ]

  def rank
    RANKS.each do |rank|
      method = (rank.to_s << '?').to_sym
      return rank if self.send(method)
    end
  end

  def set_hand(card_array)
    new_hand = []
    card_array.each do |values|
      new_hand << Card.new(values[0],values[1])
    end
    @cards = new_hand
  end

  def card_value_count(value)
    @cards.map(&:value).count(value)
  end

  def has_a?(value_or_suit)
    @cards.any? do |card|
      card.value == value_or_suit || card.suit == value_or_suit
    end
  end

  def royal?
    Card.royal_values.all? { |value| @cards.map(&:value).include?(value) }
  end

  def royal_flush?
    royal? && straight_flush?
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    @cards.any? { |card| card_value_count(card.value) == 4 }
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    @cards.map(&:suit).uniq.length == 1
  end

  def straight?
    if has_a?(:ace) && has_a?(:two)
      straight = Card.values[0..3] + [:ace]
    else
      low_index = Card.values.index(@cards.first.value)
      straight = Card.values[low_index..(low_index + 4)]
    end

    @cards.map(&:value) == straight
  end

  def three_of_a_kind?
    @cards.any? { |card| card_value_count(card.value) == 3 }
  end

  def two_pair?
    pairs.count == 2
  end

  def one_pair?
    pairs.count == 1
  end

  def high_card?
    true
  end

  def pairs
    pairs = []
    @cards.map(&:value).uniq.each do |value|
      if card_value_count(value) == 2
        pairs << @cards.select { |card| card.value == value }
      end
    end
    pairs
  end
end