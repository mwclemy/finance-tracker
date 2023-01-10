class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_track_stock(ticker_symbol)
    !is_tracking_stock(ticker_symbol) && !reached_stocks_limit
  end 

  def is_tracking_stock(ticker_symbol)
    stock = Stock.search_db(ticker_symbol)
    return false unless stock
    stocks.where(id:stock.id).exists?
  end

  def reached_stocks_limit
      stocks.count >= 10
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
