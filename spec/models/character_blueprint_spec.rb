require "spec_helper"

describe CharacterBlueprint do
  it { should belong_to :character }
  it { should belong_to :blueprint }

  let(:character_blueprint) { CharacterBlueprint.new(character: character, blueprint: blueprint, material_efficiency: 0) }
  let(:character)           { Character.new(name: "jack")                                        }
  let(:blueprint)           { Blueprint.new(name: "Arazu blueprint", materials: materials)}
  let(:material_one)        { Material.new(ammount: first_material_ammount, item: trit)                             }
  let(:material_two)        { Material.new(ammount: 600, item: ploy)                             }
  let(:trit)                { Item.new(name: 'trit')                                             }
  let(:ploy)                { Item.new(name: 'ploy')                                             }
  let(:first_material_ammount) { 100 }
  let(:materials)           { [ material_one, material_two ] }
  let(:bill_of_materials)   { character_blueprint.bill_of_materials }

  describe ".blueprint_name" do
    it "returns the blueprints name" do
      expect(character_blueprint.blueprint_name).to eq "Arazu blueprint"
    end

  end

  describe ".bill_of_materials" do
    let(:first_material) { bill_of_materials.first }
    it "contains all the materials" do
      character.stub(:production_efficiency_level).and_return(0)
      expect(bill_of_materials).to match_array [material_one, material_two]
    end

    context "accounting for player skills" do
      before :each do
        character_blueprint.stub(blueprint_me_waste: 1.0)
      end

      it "behaves correctly at level 0" do
        character.stub(:production_efficiency_level).and_return(0)
        expect(first_material.ammount).to eq first_material_ammount * (1 - 0.0)
      end

      it "behaves correctly at level 5" do
        character.stub(:production_efficiency_level).and_return(5)
        expect(first_material.ammount).to eq first_material_ammount * (1 - 0.25)
      end
    end

    context "accounting for blueprint material efficiency" do
      before :each do
        character_blueprint.stub(charater_pe_discount: 1.0)
      end
      it "behaves correctly at me 0" do
        character_blueprint.material_efficiency = 0
        expect(first_material.ammount).to eq 110
      end

      it "behaves correctly at me 9" do
        character_blueprint.material_efficiency = 10
        expect(first_material.ammount).to eq 100
      end

      it "behaves correctly at me -2" do
        character_blueprint.material_efficiency = -2
        expect(first_material.ammount).to eq 130
      end
    end
  end
end
