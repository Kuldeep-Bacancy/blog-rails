class ArticlesController < BaseController
  before_action :set_article, only: %i[show update destroy]

  # GET /articles
  def index
    @articles = Article.all

    render_with_message('Articles fetched Successfully!', @articles)
  end

  # GET /articles/1
  def show
    render_with_message('Article fetched Successfully!', @article)
  end

  # POST /articles
  def create
    @article = Article.new(article_params.merge({ user_id: current_user.id }))

    if @article.save
      render_with_message('Article Saved Successfully!', @article)
    else
      render_422(@article.errors.full_messages)
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render_with_message('Article Updated Successfully!', @article)
    else
      render_422(@article.errors.full_messages)
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    render_json('Article Deleted Successfully!')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find_by(id: params[:id])
    render_404('Article not found!') unless @article.present?
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :slug, :content, :user_id, :image)
  end

  def render_with_message(msg, object)
    render_json(msg, ArticleSerializer.new(object).serializable_hash[:data])
  end
end
