require "spec_helper"

describe CharacterBlueprint do
  it { should belong_to :character }
  it { should belong_to :blueprint }

  let(:character_blueprint) { CharacterBlueprint.new(character: character, blueprint: blueprint) }
  let(:character)           { Character.new(name: "jack")                                        }
  let(:blueprint)           { Blueprint.new(name: "Arazu blueprint", materials: materials)}
  let(:material_one)        { Material.new(ammount: 200, item: trit)                             }
  let(:material_two)        { Material.new(ammount: 600, item: ploy)                             }
  let(:trit)                { Item.new(name: 'trit')                                             }
  let(:ploy)                { Item.new(name: 'ploy')                                             }
  let(:materials)           { [ material_one, material_two ] }
  let(:bill_of_materials)   { character_blueprint.bill_of_materials }

  describe ".blueprint_name" do
    it "returns the blueprints name" do
      expect(character_blueprint.blueprint_name).to eq "Arazu blueprint"
    end

  end

  describe ".bill_of_materials" do
    it "contains all the materials" do
      character.stub(:production_efficiency_level).and_return(0)
      expect(bill_of_materials).to match_array [material_one, material_two]
    end

    context "accounting for player skills" do
      it "behaves correctly at level 0" do
        character.stub(:production_efficiency_level).and_return(0)
        expect(bill_of_materials.first.ammount).to eq 200
      end

      it "behaves correctly at level 5" do
        character.stub(:production_efficiency_level).and_return(5)
        expect(bill_of_materials.first.ammount).to eq 200 * (1 - 0.25)
      end

    end
  end
end
