require 'spec_helper'

describe "Default search" do

  describe "Popular items" do
    it "Should match popular items" do
      default_search('b3340555', 'Pubmed', 3)
    end
  end

  describe "Titles" do
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

    it "Should rank a commonly used alternate title high" do
      #From Kerri Hicks 5/8/15
      default_search('b6543998', ' DSM V', 5)
      default_search('b6543998', ' DSM-V', 5)
    end

  end

  describe "Authors" do
    it "Should provide reasonable results for authors with common tokens in names" do
      default_search('b3459028', 'browning christopher', 10)
    end
  end

  describe "Max documents - make sure " do
    it "Brazil query was returning over 4,000 documents on 5/11/15" do
      default_search_max_docs("slave trade in brazil", 200)
    end
  end

  describe "Handling various search patterns" do
    it "known LCSH subject strings" do
      default_search('b2771607', 'Black Panther party History', 5)
    end

    it "left anchored primary titles" do
      default_search('b2022476', 'Ordinary men', 5)
    end

    it "variant title" do
      default_search('b6543998', 'DSM V', 5)
    end

    it "uniform title" do
      default_search('b2017949', 'Huis clos', 10)
    end

    # This is at ~ 15
    # it "partial variant title" do
    #   default_search('b5164667', 'university physics', 10)
    # end

  end

  describe "Call numbers" do
    it "Should match full call numbers" do
      default_search('b6355793', "QL466 .M44 2008", 10)
    end
  end

end