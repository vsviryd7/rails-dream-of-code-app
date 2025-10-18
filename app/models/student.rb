class Student < ApplicationRecord
  has_many :enrollments
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/ },
                    uniqueness: { case_sensitive: false }
  def full_name
    "#{first_name} #{last_name}"
  end
end
