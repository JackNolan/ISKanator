require "spec_helper"

describe Skill do
  it { should have_many(:characters).through(:character_skills) }
  it { should have_many(:character_skills) }
end
