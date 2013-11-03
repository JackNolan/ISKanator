require "spec_helper"

describe CharacterSkill do
  it { should belong_to(:character) }
  it { should belong_to(:skill) }
end
