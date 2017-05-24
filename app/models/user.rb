class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_notes, dependent: :delete_all
  has_many :guest_notes, through: :user_notes, :source => :note
  has_many :notes, dependent: :delete_all
  has_many :tags, dependent: :delete_all	
end
