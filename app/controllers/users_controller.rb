class UsersController < ApplicationController
  
  before_filter :login_required

  def index
    @title = "Users list"
    @users = User.all
  end
  
  def show
    if params[:id]
      @user = User.find(params[:id]) 
    else
      @user = current_user
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # PUT /admin/users/1
  # PUT /admin/users/1.xml
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to(users_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.xml
  def destroy
    @user = current_user
    @user.destroy
    flash[:success] = 'Your account has been deleted from our system.'
    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.xml  { head :ok }
    end
  end

  # render new.rhtml
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end
 
  def create
    #logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_user = @user # !! now logged in
      redirect_to(users_path)
      flash[:notice] = "User created."
    else
      flash[:error]  = "We couldn't create that user, sorry."
      render :action => 'new'
    end
  end
end
