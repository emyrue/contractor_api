class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include ActiveModel::Serializers::JSON
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, :recoverable,
         :rememberable, :validatable,
         :confirmable,
         jwt_revocation_strategy: self
  has_one :contractor, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, uniqueness: true, presence: true

  # def generate_jwt
  #   JWT.encode({ id:, exp: 15.days.from_now.to_i }, Rails.application.credentials.secret_key_base)
  # end
end
