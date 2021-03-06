class QuotesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :authors]

  def authenticate_user!
    redirect_to "/", alert: 'You dont have enough permissions to be here' unless user_signed_in?
  end

  def quote_params
    params.require(:quote).permit(:text, :author, :source)
  end

  # GET /quotes
  # GET /quotes.json
  def index
    if q = params[:q]
      @quotes = Quote.basic_search(q)
    else
      @quotes = Quote.order("updated_at DESC")
    end
    @quotes = @quotes.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quotes }
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = Quote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/new
  # GET /quotes/new.json
  def new
    @quote = Quote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    update_author(@quote)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render json: @quote, status: :created, location: @quote }
      else
        format.html { render action: "new" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    @quote = Quote.find(params[:id])
    update_author(@quote)

    respond_to do |format|
      if @quote.update_attributes(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url }
      format.json { head :no_content }
    end
  end

  def authors
    authors = (term = params[:q]) ? Author.basic_search(term) : Author.all
    render json: authors.map(&:name)
  end

  private

  def update_author(quote)
    quote.author = Author.where(name: params[:quote][:author_name]).first_or_create
  end
end
