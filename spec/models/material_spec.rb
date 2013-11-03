require "spec_helper"

describe Material do
  it { should belong_to(:item) }
  it { should belong_to(:blueprint) }
end
