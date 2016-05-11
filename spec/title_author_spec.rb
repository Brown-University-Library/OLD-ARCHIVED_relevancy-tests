# encoding: utf-8
require 'spec_helper'

describe "Title & Author Search" do

  it "checks b7699058" do
    match = doc_id('b7699058')
    resp = solr_resp_doc_ids_only(title_and_author_search_args('Concertos, piano, orchestra, no. 3, op. 33, E major.', 'Steibelt, Daniel, 1765-1823'))
    resp.should have_document(match, 1)
    resp = solr_resp_doc_ids_only(title_and_author_search_args('Concertos,', 'Steibelt, Daniel, 1765-1823'))
    resp.should have_document(match, 1)
    resp = solr_resp_doc_ids_only(title_and_author_search_args('Concertos, piano, orchestra,', 'Steibelt, Daniel, 1765-1823'))
    resp.should have_document(match, 1)
    resp = solr_resp_doc_ids_only(title_and_author_search_args('Concertos, piano, orchestra, no. 3, op. 33,', 'Steibelt, Daniel, 1765-1823'))
    resp.should have_document(match, 1)
  end

end
