require "spec_helper"

describe Character do
  it { should have_many(:character_skills)}
  it { should have_many(:skills).through(:character_skills) }

  it { should have_many(:blueprints).through(:character_blueprints) }
  it { should have_many(:character_blueprints) }
end
