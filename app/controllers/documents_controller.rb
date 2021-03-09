class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = current_user.try(:documents).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

end
