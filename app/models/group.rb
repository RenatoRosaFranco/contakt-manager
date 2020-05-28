# frozen_string_literal: true

class Group < ApplicationRecord
  self.table_name  =  'groups'
  self.primary_key =  'id'

  default_scope -> { order(:name) }

  has_many :contacts, dependent: :destroy
  belongs_to :user
end
