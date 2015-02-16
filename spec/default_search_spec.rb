require 'spec_helper'

describe "Default search" do

  it "Should match call numbers" do
    default_search('b3340555', 'Pubmed', 3)
  end

end