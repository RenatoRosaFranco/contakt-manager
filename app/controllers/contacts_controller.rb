# frozen_string_literal: true

class ContactsController < ApplicationController
  def index 
    @contacts = Contact.all.page(params[:page])
  end

  def new
    @contact = Contact.new
  end
end 