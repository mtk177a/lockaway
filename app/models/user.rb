class User < ApplicationRecord
  authenticates_with_sorcery!

  enum role: { general: 0, admin: 1 }

  has_many :habits, dependent: :destroy
  has_many :habit_rewards, through: :habits
  has_many :rewards, through: :habit_rewards

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :username, presence: true
  validates :role, presence: true

  def own?(object)
    id == object.user_id
  end
end
