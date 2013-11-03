class CharacterSkill < ActiveRecord::Base
  belongs_to :character
  belongs_to :skill

  def self.skills_for_charactor(character_id)
    character_skills = CharacterSkill.where(character_id: character_id )
    skills = Skill.where.not(id: character_skills.collect(&:skill_id))
    character_skills + skills.map{ |skill| Character.new(skill: skill.id, level: 0)}
  end
end
