class Api::V1::UserSerializer < Api::V1::BaseSerializer

  attributes :id, :email, :username, :created_at, :updated_at

  has_many :stories

end