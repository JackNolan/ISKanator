require "spec_helper"

describe CharacterSkill do
  it { should belong_to(:character) }
  it { should belong_to(:skill) }

  describe ".skills_for_charactor" do
    let(:skill_names)      { ["A", "B", "C"] }
    let(:character_skills) { CharacterSkill.skills_for_charactor(character.id) }
    let(:character)        { Character.create(name: 'NaZol') }
    let(:skills) { skill_names.map {|name| Skill.create(name: name) } }

    before :each do
      CharacterSkill.create(character: character, skill: skills.first, level: 5)
    end
    it "returns the all skills" do
      expect(character_skills.collect(&:skill_name)).to match_array skill_names
    end

    it "returns the correct level for all character skills" do
      expect(character_skills.first.level).to eq 5
    end

    it "defaults to level 0" do
      expect(character_skills.collect(&:level)).to match_array [0,5,0]
    end

    it "sets the character id" do
      expect(character_skills.collect(&:character_id)).to match_array 3.times.map { character.id }
    end
  end
end
