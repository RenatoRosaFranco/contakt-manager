# frozen_string_literal: true

class ContactsController < ApplicationController
  def index 
    @contacts = Contact.all.page(params[:page]).per(3) 
  end

  def new
  end
end