class Income < ApplicationRecord
  belongs_to :user
  has_many :income_values, dependent: :destroy

  validates :income_name, presence: true, length: { in: 2..20 }
  validate :income_name_is_invalid_for_nil


  # 収入科目が空白の登録は無効
  def income_name_is_invalid_for_nil
    errors.add(:income_name, "は２文字以上20文字以内が必要です。") if income_name.blank?
  end
end
