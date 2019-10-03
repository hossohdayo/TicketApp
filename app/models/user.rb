class User < ApplicationRecord
  has_secure_password

  validates :name, presence: {message: 'は必須項目です'}
  validates :email, presence: {message: 'は必須項目です'}
  validates :password_digest, presence: {message: 'は必須項目です'}

  has_many :tickets
  has_many :likes, dependent: :destroy

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
