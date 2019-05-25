module ApplicationHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=retro"
  end

  def flash_error_messages(resource)
    flash['error_messages'] = []

    resource.errors.full_messages.each do |message|
      flash['error_messages'] << message
    end
  end
end
