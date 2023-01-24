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

  def self.search(param)
    param.strip!
    results = where('email  LIKE :search OR 
          first_name LIKE :search OR 
          last_name LIKE :search', 
          search: "%#{param}%")
    return nil unless results
    results
  end

  def except_current_user(users)
    users.reject {|user| user.id == self.id }
  end
  def not_friend_with?(friend)
    !self.friendships.where(friend_id: friend.id).exists?
  end
end
