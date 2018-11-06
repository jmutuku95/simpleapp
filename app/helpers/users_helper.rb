module UsersHelper
    # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}",
              alt: user.name,
              class: "gravatar")
  end
end
