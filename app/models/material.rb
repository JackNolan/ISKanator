class Material < ActiveRecord::Base
  belongs_to :item
  belongs_to :blueprint
end
