class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
#if params[:title]
      #  @color = params[:title]
     #   @movies = Movie.find(:all, :order => 'title')
    #elsif params[:rating]
      #  @color = params[:rating]
     #   @movies = Movie.find(:all, :order => 'rating')
    #else params[:release_date]
       # @color = params[:release_date]
      #  @movies = Movie.find(:all, :order => 'release_date ASC')
    #else
     #   @movies = Movie.all
    #end
    
  def index
    #@movies = Movie.all
    #if params[:sort]
      #@movies = Movie.find(:all, :order => 'title')
      @movies = Movie.order(params[:sort])
      @date_class = @title_class = nil
      if params[:sort] == 'title'
        @title_class = 'hilite'
      elsif params[:sort] == 'release_date'
        @date_class = 'hilite'
      end
      
    #end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
