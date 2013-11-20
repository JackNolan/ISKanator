require "spec_helper"

describe CharacterBlueprint do
  it { should belong_to :character }
  it { should belong_to :blueprint }

  let(:character_blueprint) { CharacterBlueprint.new(character: character, blueprint: blueprint) }
  let(:character) { Character.new(name: "jack") }
  let(:blueprint) { Blueprint.new(name: "Arazu blueprint") }

  describe ".blueprint_name" do
    it "returns the blueprints name" do
      expect(character_blueprint.blueprint_name).to eq "Arazu blueprint"
    end
  end
end
