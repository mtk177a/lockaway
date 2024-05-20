class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  # GET /habits
  def index
    @habits = current_user.habits
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
      redirect_to habits_path, notice: 'Habit was successfully created.'
    else
      render :new
    end
  end

  # GET /habits/1/edit
  def edit
  end

  # PATCH/PUT /habits/1
  def update
    if @habit.update(habit_params)
      redirect_to habits_path, notice: 'Habit was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /habits/1
  def destroy
    @habit.destroy
    redirect_to habits_path, notice: 'Habit was successfully deleted.'
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :habit_type, :description, :start_date)
  end
end
