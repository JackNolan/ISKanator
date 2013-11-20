require "spec_helper"

describe CharacterBlueprint do
  it { should belong_to :character }
  it { should belong_to :blueprint }

  let(:character_blueprint) { CharacterBlueprint.new(character: character, blueprint: blueprint, material_efficiency: 0) }
  let(:character)           { Character.new(name: "jack")                                        }
  let(:blueprint)           { Blueprint.new(name: "Dominix blueprint", materials: materials)}
  let(:material_one)        { Material.new(amount: first_material_amount, item: trit)                             }
  let(:material_two)        { Material.new(amount: 600, item: ploy)                             }
  let(:trit)                { Item.new(name: 'trit')                                             }
  let(:ploy)                { Item.new(name: 'ploy')                                             }
  let(:first_material_amount) { 4300840 }
  let(:materials)           { [ material_one, material_two ] }
  let(:bill_of_materials)   { character_blueprint.bill_of_materials }

  describe ".blueprint_name" do
    it "returns the blueprints name" do
      expect(character_blueprint.blueprint_name).to eq "Dominix blueprint"
    end

  end

  describe ".bill_of_materials" do
    let(:first_material) { bill_of_materials.first }

    it "does not change the original material amounts" do
      character.stub(:production_efficiency_level).and_return(0)
      material_amounts = blueprint.materials.collect(&:amount)
      character_blueprint.bill_of_materials
      expect(blueprint.materials.collect(&:amount)).to eq material_amounts
    end

    context "accounting for player skills" do
      before :each do
        character_blueprint.stub(blueprint_waste_percent: 0.0)
      end

      it "behaves correctly at level 0" do
        character.stub(:production_efficiency_level).and_return(0)
        expect(first_material.amount).to eq 5376050
      end

      it "behaves correctly at level 5" do
        character.stub(:production_efficiency_level).and_return(5)
        expect(first_material.amount).to eq 4300840
      end
    end

    context "accounting for blueprint material efficiency" do
      before :each do
        character_blueprint.stub(skill_waste_percent: 0.0)
      end

      it "behaves correctly at me 0" do
        character_blueprint.material_efficiency = 0
        expect(first_material.amount).to eq 4730924
      end

      it "behaves correctly at me 30" do
        character_blueprint.material_efficiency = 30
        expect(first_material.amount).to eq 4314714
      end

      it "behaves correctly at me -2" do
        character_blueprint.material_efficiency = -2
        expect(first_material.amount).to eq 5591092
      end
    end
  end
end
