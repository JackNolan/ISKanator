class Skill < ActiveRecord::Base
  has_many :characters, through: :character_skills
  has_many :character_skills
end
