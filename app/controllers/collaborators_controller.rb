class CollaboratorsController < ApplicationController
  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    collaborator = Collaborator.new(wiki: wiki, user: user)
    if collaborator.save
      flash[:notice] = "Collaborator was saved."
    else
      flash[:error] = "Collaborator was not saved. Try again."
    end
    redirect_to edit_wiki_path wiki
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(user_id: params[:user_id], wiki_id: params[:wiki_id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed from wiki."
      redirect_to @wiki
    else
      flash[:error] = "There was an error deleting this collaborator. Please try again."
    end
  end
end