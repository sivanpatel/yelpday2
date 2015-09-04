class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy

  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true

  def created_by_current_user?(user)
    if user
      self.user_id == user.id ? true : false
    else
      false
    end
  end

end
