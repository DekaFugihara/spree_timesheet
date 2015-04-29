module Spree
  module Admin
    class TimeSheetsController < ResourceController
      
      # GET /time_sheets
      # GET /time_sheets.json
      def index
        
        if spree_current_user.admin?
          @time_sheets = TimeSheet.all
        else
          @time_sheets = spree_current_user.time_sheets.where("date > ?", Date.today.beginning_of_month).where("date < ?", Date.today.end_of_month)
        end
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @time_sheets }
        end
      end

      # GET /time_sheets/1
      # GET /time_sheets/1.json
      def show
        open_time_sheet = spree_current_user.time_sheets.where(date: Date.today).first
        @time_sheet = open_time_sheet ? open_time_sheet : TimeSheet.create(user_id: spree_current_user.id, date: Date.today)

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @time_sheet }
        end
      end

      # GET /time_sheets/new
      # GET /time_sheets/new.json
      def new
        time_sheet = TimeSheet.where(date: Date.today, user_id: spree_current_user.id).first_or_create
        redirect_to edit_admin_time_sheet_path(time_sheet)
      end

      # GET /time_sheets/1/edit
      def edit
        @time_sheet = TimeSheet.find(params[:id])
        @user = @time_sheet.user
      end

      # POST /time_sheets
      # POST /time_sheets.json
      def create
        @time_sheet = TimeSheet.new(params[:time_sheet])

        respond_to do |format|
          if @time_sheet.save
            format.html { redirect_to edit_admin_time_sheet_path(@time_sheet), notice: 'Registro de ponto criado com sucesso!' }
            format.json { render json: @time_sheet, status: :created, location: @time_sheet }
          else
            format.html { render action: "new" }
            format.json { render json: @time_sheet.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /time_sheets/1
      # PUT /time_sheets/1.json
      def update
        @time_sheet = TimeSheet.find(params[:id])

        respond_to do |format|
          if @time_sheet.update_attributes(params[:time_sheet])
            format.html { redirect_to admin_time_sheets_path(@time_sheet), notice: 'Registro de ponto atualizado com sucesso!' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @time_sheet.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /time_sheets/1
      # DELETE /time_sheets/1.json
      def destroy
        @time_sheet = TimeSheet.find(params[:id])
        @time_sheet.destroy

        respond_to do |format|
          format.html { redirect_to admin_time_sheets_url }
          format.json { head :no_content }
        end
      end

      def bater
        open_time_sheet = spree_current_user.time_sheets.where(date: Date.today).first
        @time_sheet = open_time_sheet ? open_time_sheet : TimeSheet.new(user_id: spree_current_user.id, date: Date.today)
      end

      private
      
        def model_class
          Spree::TimeSheet
        end
      
    end
  end
end