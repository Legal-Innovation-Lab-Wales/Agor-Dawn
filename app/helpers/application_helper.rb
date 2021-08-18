module ApplicationHelper
  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def user_avatar(user, size = 100)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}")
    else
      Faker::Avatar.image(user.email, size: "#{size}x#{size}")
    end
  end
end
