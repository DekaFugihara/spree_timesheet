# coding: utf-8
module Spree
  module Admin
    class EffortsController < ResourceController
      
      # GET /efforts
      # GET /efforts.json
      def index
      
        if spree_current_user.admin?
          @efforts = Effort.all
        else
          @efforts = spree_current_user.efforts.where("started_at > ?", Date.today.beginning_of_week).where("completed_at < ? OR completed_at IS NULL", Date.today.end_of_week)
        end

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @efforts }
        end
      end

      # GET /efforts/1
      # GET /efforts/1.json
      def show
        @effort = Effort.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @effort }
        end
      end

      # GET /efforts/new
      # GET /efforts/new.json
      def new
        @effort = Effort.new(user_id: spree_current_user.id)

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @effort }
        end
      end

      # GET /efforts/1/edit
      def edit
        @effort = Effort.find(params[:id])
      end

      # POST /efforts
      # POST /efforts.json
      def create
        @effort = Effort.new(params[:effort])
        @effort.started_at = Time.now if params[:commit] == "Iniciar atividade"

        respond_to do |format|
          if @effort.save
            format.html { redirect_to admin_efforts_path, notice: 'Alocação criada com sucesso.' }
            format.json { render json: @effort, status: :created, location: @effort }
          else
            format.html { render action: "new" }
            format.json { render json: @effort.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /efforts/1
      # PUT /efforts/1.json
      def update
        @effort = Effort.find(params[:id])
        @effort.completed_at = Time.now if params[:commit] == "Concluir atividade"

        respond_to do |format|
          if @effort.update_attributes(params[:effort])
            format.html { redirect_to admin_efforts_path, notice: 'Alocação atualizada com sucesso.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @effort.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /efforts/1
      # DELETE /efforts/1.json
      def destroy
        @effort = Effort.find(params[:id])
        @effort.destroy

        respond_to do |format|
          format.html { redirect_to efforts_url }
          format.json { head :no_content }
        end
      end

      private
      
        def model_class
          Spree::Effort
        end
      
    end
  end
end
