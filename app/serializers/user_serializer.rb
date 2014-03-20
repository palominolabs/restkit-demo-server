class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  def filter(keys)
    puts scope
    keys.delete :email unless scope
    keys
  end
end