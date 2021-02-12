class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = Document.includes(:user).where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

end
