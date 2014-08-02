require "poker_hand"

describe "Hand" do
  before(:each) do
    @hand = Hand.new
  end

  describe "rank" do
    context "when holding Ah As 10c 7d 6s" do
      it "has a pair" do
        @hand.set_hand([[:hearts, :ace], [:spades, :ace],
        [:clubs, :ten], [:diamonds, :seven],
        [:spades, :six]])
        expect(@hand.rank).to eq(:one_pair)
      end
    end

    context "when holding Kh Kc 3s 3h 2d" do
      it "has a two pair" do
        @hand.set_hand([[:hearts, :king], [:clubs, :king],
        [:spades, :three], [:hearts, :three],
        [:diamonds, :two]])
        expect(@hand.rank).to eq(:two_pair)
      end
    end

    context "when holding Kh Qh 6h 2h 9h" do
      it "has a flush" do
        @hand.set_hand([[:hearts, :king], [:hearts, :queen],
        [:hearts, :six], [:hearts, :two],
        [:hearts, :nine]])
        expect(@hand.rank).to eq(:flush)
      end
    end
  end
end