class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = Topic.all
  end

  def new
    if params[:back]
     @topic = Topic.new(topics_params)
    else
     @topic = Topic.new
    end
  end

  def create
    @topic = Topic.create(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
     redirect_to topics_path, notice: "投稿完了しました"
     NoticeMailer.sendmail_topic(@topic).deliver
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

  def confirm
    @topic = Topic.new(topics_params)
    render :new if @topic.invalid?
  end

  private
  def topics_params
    params.require(:topic).permit(:content, :image)
  end
end
