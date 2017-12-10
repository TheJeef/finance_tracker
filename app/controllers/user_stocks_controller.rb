class UserStocksController < ApplicationController
  
  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "Added #{@user_stock.stock.name} to your portfolio"
    redirect_to my_portfolio_path
  end
  
  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.find_by(user_id: current_user.id, stock_id: stock.id)
    @user_stock.destroy
    flash[:notice] = "Untracked #{stock.ticker}."
    redirect_to my_portfolio_path
  end
  
end
