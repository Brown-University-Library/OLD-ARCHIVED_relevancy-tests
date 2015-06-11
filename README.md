##relevancy-tests

Relevancy test cases for the Solr index driving [Brown's Blacklight implementation](https://search.library.brown.edu/).

Built with [rspec-solr](https://github.com/sul-dlss/rspec-solr) and based on [sw_index_tests](https://github.com/sul-dlss/sw_index_tests/)

###running the tests

####Install/configuration
 - `git clone
 - `cd relevancy-tests`
 - `bundle install`
 - `cp .sample-env .env`
 - # adjust .env settings to point to your solr instance

####Running the tests
 - `bundle exec rspec` #run the tests