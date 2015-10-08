class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all.paginate(page: params[:page], per_page: 10)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @comment = current_user.comments.build if logged_in?
    @comments = @entry.comments.paginate(page: params[:page], per_page: 10)
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to @entry
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    if @entry.update(entry_params)
      flash[:success] = "Successfully updated entry!"
      redirect_to @entry
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    user = @entry.user
    @entry.destroy
    flash[:success] = "Successfully deleted!"
    redirect_to user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :content)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
