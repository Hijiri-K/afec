module HomeHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new #@resourceが偽か未定義ならUser.newを代入
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
