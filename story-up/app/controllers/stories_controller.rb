class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])
    # TODO
    # 1. get relative node
    @node = Node.where("nodes.story_id = ? AND nodes.level = 1", @story.id).first
    p "#{@node}"
    # 2. add reading action
    @user_action = UserAction.record_action(@story, @node, current_user, 2)

    # 3. add or update reading activity statistics
    Statistic.create_or_update_story_statistic(@story, @user_action)

    # no matter or what, show the story
    respond_to do |format|
        format.html { @story }
        format.json { render action: 'show', location: @story}
    end

  end

  # POST /stories/1/rate
  def rate

    @story = Story.find(params[:id])
    @user_action = UserAction.record_action(@story, nil, current_user, 0)
    Statistic.create_or_update_story_statistic(@story, @user_action)

    respond_to do |format|
        format.html { @story }
        format.json { render action: 'show', location: @story}
    end

  end


  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create

    @story = Story.new(story_params)

    if user_signed_in?
      @story.user = current_user
    end

    respond_to do |format|
      if @story.save
        @node  = Node.create(story: @story, content: @story.story_content, level: 1, user: current_user)
        @node.update_attributes(path: @node.id)
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render action: 'show', status: :created, location: @story }
      else
        format.html { render action: 'new' }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:story_content, :user_id)
    end
end
