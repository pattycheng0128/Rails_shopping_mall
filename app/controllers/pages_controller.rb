class PagesController < ApplicationController

  def index
    @ad = {
      title: "廣告",
      description: "描述"
    }
    @products = []

    (1..100).each do |index|
      product = {
        id: index,
        name: "馬卡龍",
        description: "好吃",
        image_url: "https://images.pexels.com/photos/239581/pexels-photo-239581.jpeg"
      }
      @products << product
    end 
  end
  
  def test
  end
end
