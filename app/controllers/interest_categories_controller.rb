class InterestCategoriesController < ApplicationController
  before_action :authenticate_token
  skip_before_action :verify_authenticity_token

  def edit
  end
  def update
    interest_categories = params[:interest_categories]
    categories = Category.where(id:interest_categories)
    puts categories
    @current_user.categories=categories
    render json:{ }
  end

  def show
    interest_categories = @current_user.categories
    categories = Category.all.collect{|r| Hash({'id'=>r.id,'name'=>r.name,'selected'=>if interest_categories.include?r then true else false end })}
    puts categories
    render json:{categories:categories}
  end
end
