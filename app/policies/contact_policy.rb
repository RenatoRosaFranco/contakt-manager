# frozen_string_literal: true

class ContactPolicy < ApplicationPolicy
  
  def can_edit?
    user.id.eql?(record.user_id)
  end
  
  def update?
    can_edit?
  end

  def destroy?
    can_edit?
  end
end
