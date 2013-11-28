class Item < ActiveRecord::Base
  has_one :blueprint, foreign_key: "produced_item_id"

  has_many :blueprints, through: :materials
  has_many :materials

  after_initialize :set_defaults

  def sell_price
    (sell_price_cents || 0 / 100.0).round(2)
  end

  def set_defaults
    @sell_price_cents ||= 0
    @buy_price_cents ||= 0
  end

  def update_prices
    prices = EveCentral.jita_price_for(eve_id)
    self.sell_price_cents = prices[:sell_price_cents]
    self.buy_price_cents  = prices[:buy_price_cents]
  end
end
