class Character < ActiveRecord::Base
  has_many :skills, through: :character_skills
  has_many :character_skills

  has_many :blueprints, through: :character_blueprints
  has_many :character_blueprints
end
