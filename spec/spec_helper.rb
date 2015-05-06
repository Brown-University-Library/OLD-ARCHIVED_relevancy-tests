require "yaml"
require 'rsolr'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec-solr'

require 'logger'
#For HTTP debugging
require 'http_logger'

HttpLogger.logger = Logger.new(STDOUT)
HttpLogger.colorize = true

# Runs a block of code without warnings.
# e.g. as class vars here are on Object class, we get a lot of
#   "class variable access from toplevel" warnings
def silence_warnings(&block)
  warn_level = $VERBOSE
  $VERBOSE = nil
  result = block.call
  $VERBOSE = warn_level
  result
end

RSpec.configure do |config|
  config.deprecation_stream = 'log/deprecations.log'
  config.color = true
  solr_config = {:url => ENV['SOLR_BASE_URL'] + '/' + ENV['SOLR_CORE']}
  silence_warnings {
    @@solr = RSolr.connect(solr_config)
    puts "Solr URL: #{@@solr.uri}"
  }
end

# send a GET request to the indicated Solr request handler with the indicated Solr parameters
# @param solr_params [Hash] the key/value pairs to be sent to Solr as HTTP parameters
# @param req_handler [String] the pathname of the desired Solr request handler (defaults to 'select')
# @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response
def solr_response(solr_params, req_handler='select')
  RSpecSolr::SolrResponseHash.new(@@solr.send_and_receive(req_handler, {:method => :get, :params => solr_params}))
end

#
# - Borrowed from
# - https://github.com/sul-dlss/sw_index_tests/
# - https://github.com/sul-dlss/rspec-solr
#

#lazily make the doc id hash
def doc_id(sid)
  return {'id' => sid}
end

#send a request to the default andler
def default_search_args(query_str)
  {'q'=> query_str}
end

#helper to run a default search test
def default_search(rec_id, query, position)
  match = doc_id(rec_id)
  resp = solr_resp_doc_ids_only(default_search_args(query))
  resp.should have_document(match, position)
end


#these should match local Solr config
def title_search_args(query_str)
  {'q'=>"{!qf=$title_qf pf=$title_pf}#{query_str}", 'qt'=>'search'}
end

#these should match local Solr config
def author_search_args(query_str)
  {'q'=>"{!qf=$author_qf pf=$author_pf}#{query_str}", 'qt'=>'search'}
end

# send a GET request to the default Solr request handler with the indicated Solr parameters
# @param solr_params [Hash] the key/value pairs to be sent to Solr as HTTP parameters, in addition to
#  those to get only id fields and no facets in the response
# @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response
def solr_resp_doc_ids_only(solr_params)
  solr_response(solr_params.merge(@@doc_ids_only))
end


# use these Solr HTTP params to reduce the size of the Solr responses
# response documents will only have id fields, and there will be no facets in the response
silence_warnings {
  @@doc_ids_only = {'fl'=>'id, title_display', 'facet'=>'false'}
  @@doc_ids_short_titles = {'fl'=>'id,title_245a_display', 'facet'=>'false'}
  @@doc_ids_full_titles = {'fl'=>'id,title_full_display', 'facet'=>'false'}
}

# response documents will only have id fields, and there will be no facets in the response
# @return [Hash] Solr HTTP params to reduce the size of the Solr responses
def doc_ids_only
  silence_warnings { @@doc_ids_only }
end

# response documents will only have id and title_245a_display fields, and there will be no facets in the response
# @return [Hash] Solr HTTP params to reduce the size of the Solr responses
def doc_ids_short_titles
  silence_warnings { @@doc_ids_short_titles }
end

# response documents will only have id and title_full_display fields, and there will be no facets in the response
# @return [Hash] Solr HTTP params to reduce the size of the Solr responses
def doc_ids_full_titles
  silence_warnings { @@doc_ids_full_titles }
end

def solr_conn
  silence_warnings { @@solr }
end

def solr_schema
  silence_warnings { @@schema_xml ||= @@solr.send_and_receive('admin/file/', {:method => :get, :params => {'file'=>'schema.xml', :wt=>'xml'}}) }
end

def solr_config_xml
  silence_warnings { @@solrconfig_xml = @@solr.send_and_receive('admin/file/', {:method => :get, :params => {'file'=>'solrconfig.xml', :wt=>'xml'}}) }
end