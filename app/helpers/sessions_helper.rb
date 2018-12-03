module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_in_user_from_cookies(user)
    if user && user.authenticated?(cookies[:remember_token])
      log_in(user)
      @current_user = user
    end
  end

  def get_user_id_from_cookies
    cookies.signed[:user_id]
  end

  # get current user from session or cookies if remember_me is chosen
  def current_user
    # separate logic for getting users from session/cookies
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find(user_id)
      log_in_user_from_cookies(user)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    current_user == user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
