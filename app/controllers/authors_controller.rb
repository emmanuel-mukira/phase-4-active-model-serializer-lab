class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    authors = Author.includes(:profile, posts: [:tags]).all
    render json: authors, except: [:id, :created_at, :updated_at],
           include: {
             profile: { except: [:id, :created_at, :updated_at] },
             posts: {
               only: [:title],
               methods: :short_content,
               include: {
                 tags: { only: [:name] }
               }
             }
           }
  end

  def show
    author = Author.includes(:profile, posts: [:tags]).find(params[:id])
    render json: author,
           include: {
             profile: { except: [:id, :created_at, :updated_at] },
             posts: {
               only: [:title],
               methods: :short_content,
               include: {
                 tags: { only: [:name] }
               }
             }
           }
  end

  private

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end
end
