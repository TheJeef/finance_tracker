class StocksController < ApplicationController
  
  def search
    if params[:stock].blank?
      flash.now[:danger] = "Search cannot be empty"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "This is an invalid stock symbol" unless @stock
    end
    render partial: "users/result"
  end
  
end