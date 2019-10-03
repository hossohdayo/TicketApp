class Ticket < ApplicationRecord
  validates :game_date, presence: {message: 'は必須項目です'}
  validates :opponent, presence: {message: 'は必須項目です'}
  validates :price, presence: {message: 'は必須項目です'}, numericality: {only_integer: true, message: 'は数値を入力してください'}
  validates :place, presence: {message: 'は必須項目です'}

  belongs_to :user
  has_many :likes, dependent: :destroy
end
