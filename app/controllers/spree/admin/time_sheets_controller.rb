# coding: utf-8
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
        @time_sheets = Kaminari.paginate_array(@time_sheets).page(params[:page]).per(30)
        
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
        @time_sheet = TimeSheet.new(timesheet_params)

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
          if @time_sheet.update_attributes(timesheet_params)
            format.html { redirect_to edit_admin_time_sheet_path(@time_sheet), notice: 'Registro de ponto atualizado com sucesso!' }
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

      def report
        params[:q] ||= {}
        params[:q][:date_gt] ||= Date.today.beginning_of_month
        params[:q][:date_lt] ||= Date.today.end_of_month
        params[:q][:user_email_cont] ||= spree_current_user.email unless spree_current_user.admin?

        @search = TimeSheet.order('date DESC').ransack(params[:q])
        scope = @search.result

        @user = nil
        if spree_current_user.admin?
          @user = Spree::User.employees.where("email LIKE ?", "%#{params[:q][:user_email_cont]}%").first if params[:q][:user_email_cont]
        else
          @user = spree_current_user
        end

        @time_sheets = {}
        @month_total = {
          "Anaiara" => 0,
          "Bia" => 0,
          "felipe" => 0,
          "Samantha" => 0,
          "Vinny" => 0
        }

        scope.each do |s|
          if @time_sheets[s.date]
            @time_sheets[s.date].merge!({ s.user.nome => s.display_total })
            # @time_sheets[s.date][:total] += s.total ? s.total : 0
          else
            # @time_sheets.merge!(s.date => { s.user.nome => s.display_total, :total => s.total ? s.total : 0 } )
            @time_sheets.merge!(s.date => { s.user.nome => s.display_total })
          end
          @month_total[s.user.nome] += s.total.to_i if @month_total[s.user.nome]
        end

        @month_total.each do |user,total|
          difference = total
          seconds    = difference % 60
          difference = (difference - seconds) / 60
          minutes    = ( difference % 60)
          hours = (difference - minutes) / 60
          # hours      =  (difference % 24)
          @month_total[user] = "#{hours.to_i}h#{minutes.to_i}m"
        end

        respond_to do |format|
          format.html # index.html.erb
          format.xls do
            response.headers['Content-Disposition'] = 'attachment; filename="timesheets.xls"'
          end
        end
      end

      private
      
        def model_class
          Spree::TimeSheet
        end

        def timesheet_params
            params.require(:time_sheet).permit(:entrance_time,:user_id,:lunch_exit_time,:lunch_return_time,:exit_time,:obs)
        end
      
    end
  end
end
