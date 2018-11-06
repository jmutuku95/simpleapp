module UsersHelper
    # Returns the Gravatar for the given user.
  def gravatar_for(user)  
    image_tag(make_gravatar_url(user), alt: user.name, class: "gravatar")
  end

  def make_gravatar_url(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
