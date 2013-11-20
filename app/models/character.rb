class Character < ActiveRecord::Base
  has_many :skills, through: :character_skills
  has_many :character_skills

  has_many :blueprints, through: :character_blueprints
  has_many :character_blueprints

  def production_efficiency_level
    self.character_skills.production_efficiency.first.level
  end
end
