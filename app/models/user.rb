class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  enum :role, { owner: 0, vet: 1, admin: 2 }

  has_one :owner_record, class_name: 'Owner', foreign_key: 'user_id'
  has_one :vet_record, class_name: 'Vet', foreign_key: 'user_id'
end
