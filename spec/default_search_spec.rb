require 'spec_helper'

describe "Default search" do

  it "Should match popular items" do
    default_search('b3340555', 'Pubmed', 3)
  end

  it "Should match partial titles" do
    default_search('b2041590', 'remains of the day', 10)
  end

end