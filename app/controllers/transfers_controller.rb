class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]

  # GET /transfers or /transfers.json
  def index
    @transfers = Transfer.where(user_id: current_user)
  end

  # GET /transfers/1 or /transfers/1.json
  def show
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
    @transfer.user = current_user
    @transfer.file.attach(params[:transfer][:file])
    if params[:transfer][:title] == ""
      @transfer.title = @transfer.file.filename
    end
    @transfer.file_type = @transfer.file.content_type

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to user_url(current_user), notice: "File successfully uploaded." }
        format.json { render :show, status: :created }
      else
        @transfer.title = ""
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
    @transfer.file.purge_later
    @transfer.destroy

    respond_to do |format|
      format.html { redirect_to user_url(current_user), notice: "File was successfully deleted." }
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
      params.require(:transfer).permit(:title, :type, :description, :sharable_link, :file)
    end
end
