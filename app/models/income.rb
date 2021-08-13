class Income < ApplicationRecord
  belongs_to :user

  validates :income_name, presence: true, length: { in: 2..20 }
end
