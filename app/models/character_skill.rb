class CharacterSkill < ActiveRecord::Base
  belongs_to :character
  belongs_to :skill

  def self.production_efficiency
    includes(:skill).where({skills: {name: 'Production Efficiency'}})
  end

  def self.skills_for_charactor(character_id)
    character_skills = CharacterSkill.where(character_id: character_id )
    skills = Skill.where.not(id: character_skills.collect(&:skill_id))
    character_skills + skills.map{ |skill| CharacterSkill.new(skill: skill, level: 0, character_id: character_id)}
  end

  def skill_name
    skill.try(:name)
  end
end
