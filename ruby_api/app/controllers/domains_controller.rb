class DomainsController < ApplicationController

  def show
    @user = User.find(params[:id])
    @domains = @user.domains
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = current_user.domains.build(domain_params)

    if @domain.save
      flash[:success] = "Domain added"
      redirect_to domain_path(current_user)
    else
      render 'new'
    end
  end

  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy
    flash[:success] = "Domain successfully removed"
    redirect_to domain_path(current_user)
  end

  private
  def domain_params
    params.require(:domain).permit(:domain_name, :description, :authentication_token)
  end
end
