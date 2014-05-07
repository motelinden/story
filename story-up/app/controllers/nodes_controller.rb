class NodesController < ApplicationController
 # before_action :authenticate_user!, except: [:index, :show, :rate]
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    @story = Story.find(params[:story_id])
    @nodes = @story.nodes
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show

    @story = Story.find(params[:story_id])
    @node  = Node.find(params[:id])
    
    
     
    
    # TODO
    # 1. add reading action
    @user_action = UserAction.record_action(@story, @node, current_user, 2)

    # 2. add or update reading activity statistics
    Statistic.create_or_update_node_statistic(@story, @node, @user_action)

    # no matter or what, show the story
    respond_to do |format|
        format.html { @node }
       # format.json { render action: 'show', location: @node}
        format.json { render json: @node, status: :ok}
    end

  end
  
  def subordinates
    @node  = Node.find(params[:id])

    # no matter or what, show the story
    respond_to do |format|
        format.html { @node }
       # format.json { render action: 'show', location: @node}
        format.json { render json: @node.subordinates, status: :ok}
    end

  end
  # GET /nodes/new
  def new
    @story = Story.find(params[:story_id])
    @node = Node.new
  end

  # GET /nodes/1/edit
  def edit
  end


  # POST /stories/1/nodes/1/rate
  def rate

    @story = Story.find(params[:story_id])
    @node  = Node.find(params[:id])

    @user_action = UserAction.record_action(@story, nil, current_user, 0)

    Statistic.create_or_update_story_statistic(@story, @user_action)

    respond_to do |format|
        format.html { head :ok }
        format.json { render json: @node.subordinates, status: :ok}
    end

  end

  # POST /nodes
  # POST /nodes.json
  def create
#console.log("-------------");
    @node           = Node.new(node_params)
    @story          = Story.find(params[:story_id])
    @node.story     = @story
    if current_user != nil
    	@node.user_id   = current_user.id
    else
    	@node.user_id =0
		end
    @parent         = Node.where("nodes.story_id = ? AND nodes.level = 1", @story.id).first
    @node.parent    = @parent
     
    respond_to do |format|
      if @node.save
        format.html { redirect_to story_path(@story), notice: 'Your story was successfully created.' }
        format.json { render json: @node, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /nodes/:node_id/new_follow
  def new_follow
    @node = Node.find(params[:id])
    @story = @node.story
  end


  # POST /nodes/:node_id/new_follow
  # POST /nodes/:node_id/new_follow.json
  def follow_up
    @node          = Node.new(node_params)
    @parent        = Node.find(params[:id])
    @story         = @parent.story 
    @node.story    = @story
    @node.parent   = @parent
    @node.level    = @parent.level + 1
    @node.path     = "#{@parent.path}, #{@parent.id}"
    if current_user != nil
    	@node.user_id  = current_user.id
		else
			@node.user_id =0
		end
		
    respond_to do |format|
      if @node.save
        format.html { redirect_to story_path(@story), notice: "You just follow up." }
        format.json { render action: "show", status: :created, location: story_nodes_path(@story)}
      else
        format.html { render action: 'new_follow'}
        format.json { render json: @node.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit(:story_id, :parent_id, :user_id, :level, :path, :content)
    end
end
