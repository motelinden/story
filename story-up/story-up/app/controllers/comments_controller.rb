class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @node = Node.find(params[:node_id])
    @story = @node.story
    @comment = @node.comments.new(comment_params)

    username = nil

    if user_signed_in?
      @comment.user = current_user
      username = current_user.username
    else
      @comment.user_id = -1
      username = "Anonymous"
    end

    @comment.story_id = @story.id

    respond_to do |format|
      if @comment.save

        # TODO
        # 1. add comment action
        @user_action = UserAction.record_action(@story, @node, current_user, 4)

        # 2. add or update reading activity statistics
        Statistic.create_or_update_node_statistic(@story, @node, @user_action)


        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: {username: username, content: @comment.content } }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :story_id, :node_id, :parent_id, :content)
    end
end
