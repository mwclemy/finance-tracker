class StocksController < ApplicationController
    def search_stock
        if params[:stock].present?
            @stock = Stock.new_lookup(params[:stock])
            if @stock
                render 'users/my_portfolio'
            else
                flash[:alert] = "Please enter a valid stock"
                render 'users/my_portfolio'
            end
        else
            flash[:alert] = "Please enter a stock to search"
            render 'users/my_portfolio'
        end
    end
end