class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  # GET /habits
  def index
    @q = Habit.where(user_id: current_user.id).ransack(params[:q])
    @habits = @q.result.order(created_at: :desc).page(params[:page])
  end

  # GET /habits/1
  def show
  end

  # GET /habits/new
  def new
    @habit = Habit.new
  end

  # POST /habits
  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to habits_path, success: t('habits.create.success')
    else
      flash.now[:danger] = t('habits.create.failure')
      render :new
    end
  end

  # GET /habits/1/edit
  def edit
  end

  # PATCH/PUT /habits/1
  def update
    if @habit.update(habit_params)
      redirect_to habits_path, success: t('habits.update.success')
    else
      flash.now[:danger] = t('habits.update.failure')
      render :edit
    end
  end

  # DELETE /habits/1
  def destroy
    if @habit.destroy
      redirect_to habits_path, success: t('habits.destroy.success'), status: :see_other
    else
      flash[:danger] = t('habits.destroy.failure')
      redirect_to habits_path, status: :see_other
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :habit_type, :description, :public, :start_date)
  end
end
