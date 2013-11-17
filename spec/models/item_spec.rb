require "spec_helper"

describe Item do
  it { should have_one(:blueprint) }

  it { should have_many(:blueprints).through(:materials) }
  it { should have_many(:materials)}

  let(:item) { Item.new(name: "Arazu", eve_id: 11969, m3: 3000) }

  describe "#update_prices", :vcr do
    before :each do
      item.update_prices
    end

    it "sets sell_price_cents correctly" do
      expect(item.sell_price_cents).to eq 172000000
    end
    it "sets buy_price_cents correctly" do
      expect(item.buy_price_cents).to eq 161360005
    end
  end
end
