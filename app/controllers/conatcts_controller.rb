class ConatctsController < ApplicationController
  def index
    @conatacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    Contact.create(contacts_params)
  end

  private
  def contacts_params
    params.require(:contact).permit(:title, :content)
  end

end
