module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1,
                      analysis: {
                        normalizer: {
                          keyword_icase: {
                            type: 'custom',
                            filter: %w[lowercase asciifolding]
                          }
                        }
                      } } do
      mappings dynamic: 'false' do
        indexes :number, type: 'keyword'
        indexes :application_token, type: 'keyword'
        indexes :status, type: 'keyword'
        indexes :priority, type: 'keyword'
        indexes :comment, analyzer: 'english'
        indexes :state do
          indexes :device, type: 'keyword', normalizer: 'keyword_icase'
          indexes :os, type: 'keyword', normalizer: 'keyword_icase'
          indexes :memory, type: 'keyword'
          indexes :storage, type: 'keyword'
        end
      end
    end

    def self.search(_query)
      __elasticsearch__.search({
        query: {
          bool: {
            should: [
              {
                multi_match: {
                  query: _query,
                  fields: %i[number application_token status priority state.device state.os state.memory state.storage]
                }
              }, {
                match_phrase_prefix: {
                  comment: _query
                }
              }
            ]
          }
        }
        }).records
    end
  end
end
