class Item < ActiveRecord::Base
  has_one :blueprint, foreign_key: "produced_item_id"

  has_many :blueprints, through: :materials
  has_many :materials
end
