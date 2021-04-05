class Admin::SalesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], 
                               password: ENV['ADMIN_PASSWORD']

  before_filter :authorize

  def index
    @sales = Sale.all
  end
end
