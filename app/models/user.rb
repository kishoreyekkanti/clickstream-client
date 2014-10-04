require 'couchbase/model'

class User < Couchbase::Model
  attr_accessor :id
  attribute :email
  attribute :password
  attribute :website
  attribute :hostname
  attribute :created_at, :default => lambda { Time.now }
  attribute :updated_at
  attribute :current_token_details
  attr_accessor :password_confirmation

  validates_presence_of :id, :email, :password, :website

  def self.encrypt_password(password)
    return if password.blank?
    Digest::SHA1.hexdigest(password)
  end

end

