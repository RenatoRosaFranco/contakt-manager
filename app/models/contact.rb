# frozen_string_literal: true

class Contact < ApplicationRecord
  self.table_name  = 'contacts'
  self.primary_key = 'id'

  paginates_per 3

  has_attached_file :avatar, styles: { medium: "150x150>", thumb: "100x100" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  belongs_to :group
  belongs_to :user

  validates :name, :email, :group_id, presence: true
  validates :name, length: { minimum: 2 }

  def get_avatar
    avatar = (avatar.present? ) ? avatar.url.present(:thumb) : gravatar
  end

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end
