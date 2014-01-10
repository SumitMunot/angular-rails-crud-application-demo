class PostsController < ApplicationController
  respond_to :json
  def index
    # Gather all post data
    posts = Post.all
    # Respond to request with post data in json format
    respond_with(posts) do |format|
      format.json { render :json => posts.as_json }
    end
  end

  def create
    # Create and save new post from data received from the client
    if !params[:new_post].blank?
    new_post = Post.new
    new_post.title = params[:new_post][:title][0...250] # Get only first 250 characters
    new_post.contents = params[:new_post][:contents]

      # Confirm post is valid and save or return HTTP error
      if new_post.valid?
        new_post.save!
      else
        render "public/422", :status => 422
        return
      end

      # Respond with newly created post in json format
      respond_with(new_post) do |format|
        format.json { render :json => new_post.as_json }
      end
    elsif !params[:edit_post].blank?
      # Edit and save new post from data received from the client
      edit_post = Post.find_by_id(params[:edit_post][:id])
      edit_post.title = params[:edit_post][:title][0...250] # Get only first 250 characters
      edit_post.contents = params[:edit_post][:contents]

      # Confirm post is valid and save or return HTTP error
      if edit_post.valid?
        edit_post.save!
      else
        render "public/422", :status => 422
        return
      end

      # Respond with edited post in json format
      respond_with(edit_post) do |format|
        format.json { render :json => edit_post.as_json }
      end
    else  
      # if delete request
      delete_post = Post.find_by_id(params[:delete_post][:id])
      # Confirm post is valid and save or return HTTP error
      if !delete_post.blank?
        delete_post.destroy!
      else
        render "public/422", :status => 422
        return
      end
      # Respond with edited post in json format
      respond_with(delete_post) do |format|
        format.json { render :json => delete_post.as_json }
      end
    end
  end

  def edit
    # Edit and save new post from data received from the client
    edit_post = Post.find_by_id(params[:id])
    edit_post.title = params[:edit_post][:title][0...250] # Get only first 250 characters
    edit_post.contents = params[:edit_post][:contents]

    # Confirm post is valid and save or return HTTP error
    if edit_post.valid?
      edit_post.save!
    else
      render "public/422", :status => 422
      return
    end

    # Respond with edited post in json format
    respond_with(edit_post) do |format|
      format.json { render :json => edit_post.as_json }
    end
  end
end
