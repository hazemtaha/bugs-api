class Bug < ApplicationRecord
  include Searchable

  belongs_to :state

  # validates_uniqueness_of :number, scope: :application_token
  validates :application_token, presence: true
  before_create :generate_bug_number

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

  def last_saved_bug_number
    Bug.select(:number)
       .where(application_token: application_token)
       .order(created_at: :desc)
       .limit(1)
       .pluck(:number)
       .first || 0
  end

  def generate_bug_number
    last_number = last_saved_bug_number
    self[:number] = last_number += 1
  end

  def serializable_hash(options = nil)
    super({ only: %i[number application_token status priority comment],
            include: %i[state] }.merge(options || {}))
  end
end
