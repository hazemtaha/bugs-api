class State < ApplicationRecord
  has_one :bug

  def serializable_hash(options = nil)
    super({ only: %i[device os memory storage] }.merge(options || {}))
  end
end
