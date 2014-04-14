class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable,  :trackable, :validatable
  has_many :scores

  def Wins
    scores.sum("win")
  end

  def Losses
    scores.sum("lost")
  end
end
