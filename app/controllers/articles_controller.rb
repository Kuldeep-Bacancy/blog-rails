class ArticlesController < BaseController
  before_action :set_article, only: %i[show update destroy]

  # GET /articles
  def index
    @articles = Article.all

    render_json('Articles fetched Successfully!', ArticleSerializer.new(@articles).serializable_hash[:data])
  end

  # GET /articles/1
  def show
    render_json('Article fetched Successfully!', ArticleSerializer.new(@article).serializable_hash[:data])
  end

  # POST /articles
  def create
    @article = Article.new(article_params.merge({ user_id: current_user.id }))

    if @article.save
      render_json('Article Saved Successfully!', ArticleSerializer.new(@article).serializable_hash[:data])
    else
      render_422(@article.errors.full_messages)
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render_json('Article Updated Successfully!', ArticleSerializer.new(@article).serializable_hash[:data])
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
    params.require(:article).permit(:title, :slug, :content, :user_id, images: [])
  end
end
