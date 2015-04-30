require 'spec_helper'

describe "Default search" do

  it "Should match popular items" do
    default_search('b3340555', 'Pubmed', 3)
  end

  it "Should match partial titles" do
    default_search('b2041590', 'remains of the day', 10)
    default_search('b7113006', 'time is a toy', 3)
  end

  it "Should match full title strings without quotes" do
    default_search('b2151715', 'A Pale View of Hills', 2)
  end

  it "Should match full title strings with quotes" do
    default_search('b2151715', '"A Pale View of Hills"', 2)
  end

  it "Should match partial title and TOC text" do
    default_search('b3176352', 'Effects of globalization in india', 10)
  end

  it "Should prefer primary titles over additional titles" do
    default_search('b1864577', 'scientific american', 5)
  end

end