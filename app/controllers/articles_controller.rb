class ArticlesController < ApplicationController

	before_action :authenticate_user!, except: [:show,:index]
	before_action :find_article_id , only: [:show,:edit,:update,:destroy,:publish]
	before_action :authenticate_editor!, only: [:new,:create,:update]
	before_action :authenticate_admin!, only: [:destroy,:publish]

	#GET /articles
	def index
		@articles = Article.paginate({page: params[:page],per_page:4}).publicados.ultimos
	end

	#GET /articles/:id
	def show
		@article.update_visits_count
		@comment = Comment.new
	end

	#GET /articles/new
	def new
		 @article = Article.new
		 @tags = Tag.all
	end

	def edit
	end

	#PUT /articles/:id
	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		@article.tags = params[:tags]
		@tag = 
		 if @article.save
		 	redirect_to @article
		 else
		 	render :new
		 end
		
	end

	#DELETE /articles/:id
	def destroy
		@article.destroy
		#falta eliminar la referencia de la tabla hasTag
		redirect_to articles_path
	end

	#PUT /articles/:id/publish
	def publish
		@article.publish!
		redirect_to @article
	end

	#callback de busqueda del articulo
	def find_article_id
		@article = Article.find(params[:id])
	end

	#strong params : q campos de la BBDD puedo modificar/guardar desde el formulario
	private
	def article_params
		params.require(:article).permit(:title,:body,:cover,:tags,:markup_content)
	end
end