# frozen_string_literal: true

class User < ApplicationRecord
  self.table_name  = 'users'
  self.primary_key = 'id'

  has_many :groups, dependent: :destroy
  has_many :contacts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
