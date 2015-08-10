class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 has_many :wikis, dependent: :destroy


  def standard?
    role == 'standard'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end
  
def upgrade_account(user)
    user.role = 'premium'
    user.save
  end

  def downgrade_account(user)
    user.role = 'standard'
    user.save
    user.wikis.where(private: true).update_all(private: false)
  end
  
end
