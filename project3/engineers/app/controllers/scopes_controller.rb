class ScopesController < ApplicationController
  # GET /scopes
  # GET /scopes.xml
  def index
    @scopes = Scope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scopes }
    end
  end

  # GET /scopes/1
  # GET /scopes/1.xml
  def show
    @scope = Scope.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scope }
    end
  end

  # GET /scopes/new
  # GET /scopes/new.xml
  def new
    @scope = Scope.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scope }
    end
  end

  # GET /scopes/1/edit
  def edit
    @scope = Scope.find(params[:id])
  end

  # POST /scopes
  # POST /scopes.xml
  def create
    @scope = Scope.new(params[:scope])

    respond_to do |format|
      if @scope.save
        flash[:notice] = 'Scope was successfully created.'
        format.html { redirect_to(@scope) }
        format.xml  { render :xml => @scope, :status => :created, :location => @scope }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scopes/1
  # PUT /scopes/1.xml
  def update
    @scope = Scope.find(params[:id])

    respond_to do |format|
      if @scope.update_attributes(params[:scope])
        flash[:notice] = 'Scope was successfully updated.'
        format.html { redirect_to(@scope) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scopes/1
  # DELETE /scopes/1.xml
  def destroy
    @scope = Scope.find(params[:id])
    @scope.destroy

    respond_to do |format|
      format.html { redirect_to(scopes_url) }
      format.xml  { head :ok }
    end
  end
end
