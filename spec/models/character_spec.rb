require "spec_helper"

describe Character do
  it { should have_many(:character_skills)}
  it { should have_many(:skills).through(:character_skills) }

  it { should have_many(:blueprints).through(:character_blueprints) }
  it { should have_many(:character_blueprints) }

  let(:character) { Character.create(name: "jack")                                        }


  describe "#production_efficiency_level" do
    let(:skill) { Skill.create(name: 'Production Efficiency') }

    it "returns the correct production efficiency level when level 0" do
      character.character_skills << CharacterSkill.create(skill: skill, level: 0)
      expect(character.production_efficiency_level).to eq 0
    end

    it "returns the correct production efficiency level when level 5" do
      character.character_skills << CharacterSkill.new(skill: skill, level: 5)
      expect(character.production_efficiency_level).to eq 5
    end
  end
end
