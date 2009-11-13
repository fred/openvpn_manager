class InstalledClientsController < ApplicationController
  
  before_filter :login_required
  
  # GET /installed_clients
  # GET /installed_clients.xml
  def index
    @title = "List of Installed clients on server"
    @installed_clients = InstalledClient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @installed_clients }
    end
  end

  # GET /installed_clients/1
  # GET /installed_clients/1.xml
  def show
    @title = "Show clients"
  begin
    @installed_client = InstalledClient.find(params[:id])
  rescue
    redirect_to :action => "index"
  end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @installed_client }
    end
  end

  # GET /installed_clients/new
  # GET /installed_clients/new.xml
  def new
    @installed_client = InstalledClient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @installed_client }
    end
  end

  # GET /installed_clients/1/edit
  def edit
    @installed_client = InstalledClient.find(params[:id])
  end

  # POST /installed_clients
  # POST /installed_clients.xml
  def create
    @installed_client = InstalledClient.new(params[:installed_client])

    respond_to do |format|
      if @installed_client.save
        flash[:notice] = 'InstalledClient was successfully created.'
        format.html { redirect_to( :action => "show", :id => @installed_client.name) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /installed_clients/1
  # PUT /installed_clients/1.xml
  def update
    @installed_client = InstalledClient.find(params[:id])

    respond_to do |format|
      if @installed_client.update_attributes(params[:installed_client])
        flash[:notice] = 'InstalledClient was successfully updated.'
        format.html { redirect_to(@installed_client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @installed_client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /installed_clients/1
  # DELETE /installed_clients/1.xml
  def destroy
    @installed_client = InstalledClient.find(params[:id])
    if @installed_client.destroy
      flash[:success] = "#{@installed_client.name} CRT, CSR and KEY files successfully deleted."
    else
      flash[:error] = "There was an error, files were not deleted."
    end
    @installed_client = nil
    
    respond_to do |format|
      format.html { redirect_to(installed_clients_url) }
      format.xml  { head :ok }
    end
  end
  
  # Downlaod a file
  def download
    file = params[:file].to_s
    if file.match(InstalledClient::FOLDER) && File.exists?(file) && !File.extname(file).match("csr")
      send_file(file, :disposition => "attachment")
    else
      flash[:error] = "File not allowed to download"
      redirect_to :action => "index"
    end
  end
  
  
  
end
