# frozen_string_literal: true

class Contact < ApplicationRecord
  self.table_name  = 'contacts'
  self.primary_key = 'id'

  default_scope -> { order(:name) }

  belongs_to :group

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end
