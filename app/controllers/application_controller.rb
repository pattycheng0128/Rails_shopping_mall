class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 

  def record_not_found
    render file: 'public/404.png', layout: false, status: 404
  end

end
