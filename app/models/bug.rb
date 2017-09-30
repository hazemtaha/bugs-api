class Bug < ApplicationRecord
  include Searchable

  belongs_to :state

  validates :application_token, presence: true

  enum status: {
    _new: 0,
    in_progress: 1,
    closed: 2
  }

  enum priority: {
    minor: 0,
    major: 1,
    critical: 2
  }

  def serializable_hash(options = nil)
    super({ only: %i[number application_token status priority comment],
            include: %i[state] }.merge(options || {}))
  end
end
