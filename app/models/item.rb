class Item < ActiveRecord::Base
  has_one :blueprint, foreign_key: "produced_item_id"

  has_many :blueprints, through: :materials
  has_many :materials

  after_initialize :set_defaults

  def sell_price
    (sell_price_cents / 100.0).round(2)
  end

  def set_defaults
    @sell_price_cents ||= 0
    @buy_price_cents ||= 0
  end

  def build_cost
    0.0
  end

  def profit
    sell_price - build_cost
  end

  def update_prices
    self.sell_price_cents = EveCentral.jita_sell_price_for(eve_id)
    self.buy_price_cents  = EveCentral.jita_buy_price_for(eve_id)
  end
end
