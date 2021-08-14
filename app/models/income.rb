class Income < ApplicationRecord
  belongs_to :user
  has_many :income_values, dependent: :destroy

  validates :income_name, presence: true, length: { in: 2..20 }
end
