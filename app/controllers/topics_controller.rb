class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create(topics_params)
    if @topic.save
     redirect_to topics_path, notice: "投稿完了しました"
    else
     render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topics_params)
    if @topic.save
      redirect_to topics_path, notice: "更新しました"
    else
      render 'new'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path, notice: "削除しました"
  end

  private
  def topics_params
    params.require(:topic).permit(:content, :image)
  end
end
