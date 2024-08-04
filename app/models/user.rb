class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  enum role: { general: 0, admin: 1 }

  has_many :habits, dependent: :destroy
  has_many :habit_rewards, through: :habits
  has_many :rewards, through: :habit_rewards

  validates :password, length: { minimum: 3, message: :too_short }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: { message: :confirmation }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: { message: :blank }, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: { message: :taken }
  validates :username, presence: { message: :blank }
  validates :role, presence: { message: :blank }

  def own?(object)
    id == object.user_id
  end
end
