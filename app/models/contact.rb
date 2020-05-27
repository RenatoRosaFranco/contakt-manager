# frozen_string_literal: true

class Contact < ApplicationRecord
  self.table_name  = 'contacts'
  self.primary_key = 'id'

  default_scope -> { order(:name) }

  belongs_to :group
end
