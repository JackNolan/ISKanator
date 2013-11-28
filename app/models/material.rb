class Material < ActiveRecord::Base
  belongs_to :item
  belongs_to :blueprint

  after_initialize :set_defaults

  private
    def set_defaults
      self.extra ||= false
    end
end
