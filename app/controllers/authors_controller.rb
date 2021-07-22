class AuthorsController < ActionController::Base
  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.valid?
      RequestJob.perform_later author_params
      flash[:success] = 'User data has been sent!'
      render :new, status: 201
    else
      render :new, status: 422
    end
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :email)
  end
end
