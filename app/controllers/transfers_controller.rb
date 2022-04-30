class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]

  # GET /transfers or /transfers.json
  def index
    if session[:user_id]
      @transfers = Transfer.where(user_id: session[:user_id])
    else
      redirect_to login_url, notice: "You need to be logged in!"
    end
  end

  # GET /transfers/1 or /transfers/1.json
  def show
    if session[:user_id]
      @user = User.find_by_id(params[:id])
      unless session[:user_id] == @user.id
        flash[:notice] = "You don't have access to that information!"
        redirect_to user_url(session[:user_id])
        return
      end
    else
      redirect_to login_url, notice: "You need to be logged in!"
    end
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers or /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)
    @user = User.find_by_id(session[:user_id])

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to user_url(@user), notice: "File successfully uploaded." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transfers/1 or /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to transfer_url(@transfer), notice: "Transfer was successfully updated." }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1 or /transfers/1.json
  def destroy
    @transfer.destroy

    respond_to do |format|
      format.html { redirect_to transfers_url, notice: "Transfer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.require(:transfer).permit(:title, :type, :description, :sharable_link, :user_id, file: [])
    end
end
