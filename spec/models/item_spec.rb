require "spec_helper"

describe Item do
  it { should have_one(:blueprint) }

  it { should have_many(:blueprints).through(:materials) }
  it { should have_many(:materials)}
end
