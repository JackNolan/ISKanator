require "spec_helper"

describe Blueprint do
  it { should belong_to(:produced_item).class_name("Item") }

  it { should have_many(:items).through(:materials) }
  it { should have_many(:materials)}

  it { should have_many(:characters).through(:character_blueprints) }
  it { should have_many(:character_blueprints) }

  context "material scopes" do
    let!(:blueprint)           { Blueprint.create name: "Arazu blueprint", materials: [material_one, material_two, material_three] }
    let!(:material_one)        { Material.create amount: 100, item: (Item.create name: 'trit') }
    let!(:material_two)        { Material.create amount: 200, item: (Item.create name: 'poly') }
    let!(:material_three)      { Material.create amount: 300, extra: true, item: (Item.create name: 'zyro') }
    let!(:non_extra_materials) { [material_one, material_two] }
    let!(:extra_materials)     { [material_three] }

    describe ".require_materials" do
      it "only returns non-extra-materials" do
        expect(blueprint.require_materials).to match_array non_extra_materials
      end
    end

    describe ".extra_materials" do
      it "only returns extra-materials" do
        expect(blueprint.extra_materials).to match_array extra_materials
      end
    end
  end
end
