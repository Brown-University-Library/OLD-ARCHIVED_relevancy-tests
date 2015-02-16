# encoding: utf-8
require 'spec_helper'

describe "Format facet queries" do

  it "Should return a video for a record with multiple 007s" do
    resp = solr_resp_doc_ids_only(
        {'q'=>'gathering moss', 'fq'=>'format:Video'}
    )
    resp.should have_document(doc_id("b7302566"), 5)
  end

end