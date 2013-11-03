require "spec_helper"

describe CharacterBlueprint do
  it { should belong_to :character }
  it { should belong_to :blueprint }
end
