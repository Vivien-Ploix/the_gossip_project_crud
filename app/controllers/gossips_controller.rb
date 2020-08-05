class GossipsController < ApplicationController

  def show
    @gossips = Gossip.find(params[:id])
  end

  # GET /users/new
  def new
  	@post = Gossip.new
  end

  # POST /users
  def create
    id = User.all.sample.id
    @post = Gossip.new(title: params[:title], content:params[:content], user_id: id)

    if @post.save
      @message = "The gossip was succesfully saved !"
      flash[:success] = "The gossip was succesfully saved !"
      redirect_to root_path
    else
      @alert = true
      @message = "Error: " + @post.errors.messages.to_a.flatten[1]
      render new_gossip_path
    end
  end

  def edit 
    @gossip = Gossip.find(params[:id])
  end 

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)

    if @gossip.update(gossip_params)
      flash[:success] = "The gossip was succesfully updated !"
      redirect_to gossip_path(@gossip.id)
    else
      @alert = true
      @message = "Error: " + @gossip.errors.messages.to_a.flatten[1]
      render "edit"
    end
  end

end
