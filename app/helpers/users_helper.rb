module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    image_tag(make_gravatar_url(user, size), alt: user.name, class: 'gravatar')
  end

  def make_gravatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
