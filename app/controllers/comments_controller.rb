class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    @notifications = @comment.notifications.build(user_id: @topic.user.id )

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
        format.js { render :index }
        unless @comment.topic.user_id == current_user.id
        Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
          message: 'あなたの投稿にコメントが付きました'
        })
      end
      Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.topic.user.id, read: false).count
          })
        else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
       end
     end
   end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to topic_path(@comment.topic)
  end

  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
