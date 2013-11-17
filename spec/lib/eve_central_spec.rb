require "spec_helper"

describe EveCentral, :vcr do
  describe ".jita_price_for" do
    let(:prices) { EveCentral.jita_price_for(35) }
    let(:item_id) { 35 }

    it "returns the jita sell price for a given eve id" do
      expect(prices).to have_key :sell_price_cents
    end

    it "returns the jita buy price for a given eve id" do
      expect(prices).to have_key :buy_price_cents
    end

    it "it requests the prices from eve central" do
      RestClient.should_receive(:post).with('http://api.eve-central.com/api/marketstat', { typeid: item_id, usesystem:30000142 }).and_call_original
      prices
    end
  end
end
