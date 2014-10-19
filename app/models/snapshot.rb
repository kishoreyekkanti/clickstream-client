require 'couchbase/model'

class Snapshot < Couchbase::Model
  attr_accessor :id
  attribute :relativePath
  attribute :absolutePath
  attribute :type
  attribute :originalFileName

end