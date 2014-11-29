class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
    
  def index
      #Movie.uniq.pluck(:rating)
      #http://stackoverflow.com/questions/9658881/rails-select-unique-values-from-a-column
      @all_ratings = Movie.uniq.pluck(:rating)
      #params[:ratings] || @all_ratings.each { |v| params[:ratings] ||= {}; params[:ratings][v] = 1 }
      params[:ratings] ||= Hash[@all_ratings.zip([1]*@all_ratings.size)]
      #params[:ratings] = Hash.new{ |h,key| h[key] = 1 }
      #@movies = Movie.order(params[:sort])
      @movies = Movie.where("rating IN (?)",  params[:ratings].keys).order(params[:sort])
      #@movies.select!{ |movie| params[:ratings][movie.rating] }
      @date_class = @title_class = nil
      if params[:sort] == 'title'
        @title_class = 'hilite'
      elsif params[:sort] == 'release_date'
        @date_class = 'hilite'
      end
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
