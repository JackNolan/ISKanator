require "spec_helper"

describe Blueprint do
  it { should belong_to(:produced_item).class_name("Item") }

  it { should have_many(:items).through(:materials) }
  it { should have_many(:materials)}

  it { should have_many(:characters).through(:character_blueprints) }
  it { should have_many(:character_blueprints) }
end
