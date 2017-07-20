# encoding: utf-8
require 'spec_helper'

describe "Electronic Theses and Dissertations" do

  it "finds a thesis imported from the BDR" do
    doc = solr_get_by_id('bdr\:733467')
    expect(doc["id"]).to eq("bdr:733467")
    expect(doc["pub_date"].first).to eq("2016")
  end

  it "find a thesis from the catalog (i.e. not in the BDR)" do
    doc = solr_get_by_id('b5766021')
    expect(doc["id"]).to eq("b5766021")
    expect(doc["pub_date"].first).to eq("2010")
  end
end
