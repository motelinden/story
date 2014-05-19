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
    @comment = Comment.new(comment_params)
  
    @node=Node.find(@comment.node_id)
    @story = Story.find(@node.story_id)
   
    @comment.story_id=@story.id
    @comment.parent_id=@node.parent_id
    @comment.user_id   = current_user.id
    	
    	
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
       # format.json { render action: 'show', status: :created, location: @comment }
         format.json { render json: @comment, status: :ok}
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
  
  def commentCount
    @count=Comment.where("comments.node_id = ?", params[:nodeId]).count
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { render json: @count, status: :ok}
    end
  end
  
  def list
   	@comments=Comment.where("comments.node_id = ?", params[:nodeId])
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { render json: @comments, status: :ok}
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
