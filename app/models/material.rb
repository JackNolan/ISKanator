class Material < ActiveRecord::Base
  belongs_to :item
  belongs_to :blueprint

  after_initialize :set_defaults

  def item_name
    item.try(:name)
  end

  private
    def set_defaults
      self.extra ||= false
    end
end
