class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @count = Order.count
  end

  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @result = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'customer'
      if method == 'forward'
        Customer.where(
          'last_name LIKE ? OR first_name LIKE?',
          "#{content}%", "#{content}%"
        )
      elsif method == 'backward'
        Customer.where(
          'last_name LIKE ? OR first_name LIKE?',
          "%#{content}", "%#{content}"
        )
      elsif method == 'perfect'
        Customer.where(
          'last_name = ? OR first_name = ?',
          content, content
        )
      else # partial
        Customer.where(
          'last_name LIKE ? OR first_name LIKE?',
          "%#{content}%", "%#{content}%"
        )
      end
    elsif model == 'item'
      if method == 'forward'
        Item.where('name LIKE ?', content + '%').includes(:genre)
      elsif method == 'backward'
        Item.where('name LIKE ?', '%' + content).includes(:genre)
      elsif method == 'perfect'
        Item.where(name: content).includes(:genre)
      else # partial
        Item.where('name LIKE ?', '%' + content + '%').includes(:genre)
      end

    elsif model == 'shop'
      if method == 'forward'
        Shop.where('name LIKE ?', content + '%').includes(:shop_genre)
      elsif method == 'backward'
        Shop.where('name LIKE ?', '%' + content).includes(:shop_genre)
      elsif method == 'perfect'
        Shop.where(name: content).includes(:shop_genre)
      else # partial
        Shop.where('name LIKE ?', '%' + content + '%').includes(:shop_genre)
      end

    else
      [] # 空配列を返す
    end
  end
end
