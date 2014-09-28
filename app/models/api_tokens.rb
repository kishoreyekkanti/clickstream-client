require 'couchbase/model'

class ApiTokens < Couchbase::Model
  attr_accessor :id
  attribute :valid_from
  attribute :valid_to
  attribute :userid
  attribute :hostname

end

