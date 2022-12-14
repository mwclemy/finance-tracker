class UserStocksController < ApplicationController
    def create 
        stock = Stock.search_db(params[:ticker])
        if stock.blank?
            stock = Stock.new_lookup(params[:ticker])
            stock.save
        end
        @user_stock = UserStock.create(user: current_user, stock: stock)
        if @user_stock
            flash[:notice] = "#{stock.name} stock has been successfully added to your portfolio"
            redirect_to my_portfolio_path
        else
            flash[:alert] = "Something went wrong. Please try again."
            redirect_to my_portfolio_path
        end
    end
    def destroy
        stock = Stock.find(params[:id])
        user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
        user_stock.destroy
        flash[:notice]= "#{stock.ticker} has been successfully removed from your portfolio."
        redirect_to my_portfolio_path
    end
end
