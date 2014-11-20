# encoding: utf-8
require 'spec_helper'

describe "Title Search" do

  it "700t included in title search: Gothic classics b4156972" do
    #Quick sanity check
    resp = solr_resp_doc_ids_only(title_search_args('gothic classics'))
    resp.should have_document(did("b4156972"), 5)
    #This value is in 700t for this document.
    resp = solr_resp_doc_ids_only(title_search_args('Northanger abbey'))
    resp.should have_document(did("b4156972"), 5)
  end

end