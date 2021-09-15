class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @recipe = Recipe.find(params[:recipe_id])
        @comment = current_user.comments.new(comment_params)

        if @comment.save
            redirect_to [@recipe]
        else
            render 'recipe/show'
        end
    end

    def destroy
        comment =current_user.comments.find(params[:id])
        comment.destroy

        redirect_to [:recipe, { id: params[:recipe_id] }]
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(recipe_id: params[:recipe_id])
    end
end
