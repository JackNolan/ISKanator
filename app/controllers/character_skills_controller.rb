class CharacterSkillsController < ApplicationController
  before_action :set_character_skill, only: [ :update ]
  before_action :set_character


  def index
    @skills = CharacterSkill.skills_for_charactor(params[:character_id]).sort {|skill_one, skill_two| skill_one.skill_name <=> skill_two.skill_name}
  end

  def update
    @character_skill.update(character_params)
    redirect_to action: 'index'
  end

  private

    def set_character
      @character = Character.find(params[:character_id])
    end

    def set_character_skill
      @character_skill = CharacterSkill.where(skill_id: params[:id], character_id: params[:character_id]).first_or_initialize
    end

    def character_params
      params[:character_skill].permit(:level)
    end
end
