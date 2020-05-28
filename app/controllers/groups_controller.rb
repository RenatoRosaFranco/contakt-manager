# frozen_string_literal: true

class GroupController < ApplicationController
  def index
    @group = current_user.groups.build(group_parmas)
    if @group.save
      render json: @group, status: :created
    else
      render json: @group.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end