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
      default_search_within('b6543998', ' DSM V', 10)
      default_search_within('b6543998', ' DSM-V', 10)
    end

  end

  describe "Authors" do
    it "Should provide reasonable results for authors with common tokens in names" do
      default_search('b3459028', 'browning christopher', 10)
    end
  end

  describe "Max documents - make sure " do
    it "Brazil query was returning over 4,000 documents on 5/11/15" do
      default_search_max_docs("slave trade in brazil", 250)
    end
  end

  describe "Handling various search patterns" do
    it "known LCSH subject strings" do
      default_search('b2771607', 'Black Panther party History', 5)
    end

    it "left anchored primary titles" do
      default_search_within('b2022476', 'Ordinary men', 10)
    end

    it "variant title" do
      default_search_within('b6543998', 'DSM V', 10)
    end

    it "uniform title" do
      default_search('b2017949', 'Huis clos', 10)
    end
  end

  describe "Call numbers" do
    it "Should match full call numbers" do
      default_search('b6355793', "QL466 .M44 2008", 10)
    end
  end

  describe "Identifiers in default search should work" do
    it "Should match isbns" do
      default_search('b6355793', '9780892369294', 5)
    end

    it "Should match oclc numbers" do
      default_search('b6355793', '225874122', 5)
    end

    it "Should match issns" do
      # ISSN searches need to be in quotes in default box
      # for now.  Because of hypens?
      default_search('b4105405', '"0191-1813"', 5)
    end
  end

  describe "Searches with operators" do

    describe "France examples" do
      it "Should include de gaulle and politics and not include france" do
        default_search('b3296339', "De gaulle +politics -france", nil)
      end

      it "Should exclude france" do
        default_search_excludes('b13507813', "De gaulle +politics -france")
      end

      it "Should include politics and france" do
        default_search('b1350781', "De gaulle +politics +france", 5)
      end

      it "Should include all of the + and - france searches" do
        default_search('b1350781', "De gaulle politics", 5)
      end
    end

    describe "Disease history europe war women examples" do
      it "Base query" do
        default_search('b5738569', "disease history europe war economics women religion", 8)
      end

      it "requiring women (negative)" do
        default_search_excludes('b5738569', "disease history europe war economics +women religion")
      end

      it "requiring women (positive)" do
        default_search('b3900073', "disease history europe war economics +women religion", 5)
      end

      it "exclude women" do
        default_search('b5738569', "disease history europe war economics -women religion", 5)
      end
    end


  end

end
