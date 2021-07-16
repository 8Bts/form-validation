class AuthorsController < ActionController::Base
  def new
    @author = Author.new
  end

  def create
    l_params = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email]
    }

    @author = Author.new(l_params)

    if @author.valid?
      RequestJob.perform_later l_params if @author.valid?
      render :new, status: :ok
    else
      render :new, status: 422
    end
  end
end
