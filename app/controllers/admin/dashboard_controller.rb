class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], 
                               password: ENV['ADMIN_PASSWORD']

  before_filter :authorize

  def show
    @product_count = Product.count
    @category_count = Product.group(:category_id).count.count
  end
end
