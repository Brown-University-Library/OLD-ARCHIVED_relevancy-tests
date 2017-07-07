# encoding: utf-8
require 'spec_helper'

describe "Synonyms" do
  it "100 is a synonym to hundred" do
    resp_100 = solr_resp_doc_ids_only({'q'=>'100'})
    found_100 = resp_100["response"]["numFound"]
    resp_hundred = solr_resp_doc_ids_only({'q'=>'hundred'})
    found_hundred = resp_hundred["response"]["numFound"]
    expect(found_100).to eq(found_hundred)
  end
end
