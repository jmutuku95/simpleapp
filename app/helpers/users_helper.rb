module UsersHelper
  def gravatar_for(user, size: 80)
    image_tag(make_gravatar_url(user, size), alt: user.name, class: 'gravatar')
  end

  def make_gravatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in first.'
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to current_user unless current_user?(@user)
  end

  def admin_user
    unless current_user.admin?
      redirect_to root_url, flash: { danger: 'You are not authorised!' }
    end
  end

  def not_myself
    if current_user == @user
      redirect_to root_url, flash: { danger: 'Cannot delete yourself!' }
    end
  end
end
