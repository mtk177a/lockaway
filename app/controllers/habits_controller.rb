class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  # GET /habits
  def index
    @q = Habit.where(user_id: current_user.id).ransack(params[:q])
    @habits = @q.result.order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.html # デフォルトのHTMLレンダリング
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'habit_list', # `index.html.erb` で定義するDOM ID
          partial: 'shared/habit_list', locals: { habits: @habits }
        )
      end
    end
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
      @q = Habit.where(user_id: current_user.id).ransack(params[:q])
      @habits = @q.result.order(created_at: :desc).page(params[:page])

      respond_to do |format|
        format.html { redirect_to habits_path, success: t('habits.create.success') }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('habit_form', partial: 'habits/form', locals: { habit: @habit }) }
      end
    end
  end

  # GET /habits/1/edit
  def edit
  end

  # PATCH/PUT /habits/1
  def update
    if @habit.update(habit_params)
      respond_to do |format|
        format.html { redirect_to habits_path, success: t('habits.update.success') }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('habit_form', partial: 'habits/form', locals: { habit: @habit }) }
      end
    end
  end

  # DELETE /habits/1
  def destroy
    if @habit.destroy
      flash.now[:success] = t('habits.destroy.success')
      @q = Habit.where(user_id: current_user.id).ransack(params[:q])
      @habits = @q.result.order(created_at: :desc).page(params[:page])

      respond_to do |format|
        format.turbo_stream # Turboリクエストの場合は部分更新
        format.html { redirect_to habits_path, success: t('habits.destroy.success') } # 通常リクエストの場合はリダイレクト
      end
    else
      flash.now[:error] = t('habits.destroy.failure')

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to habits_path, alert: t('habits.destroy.failure') }
      end
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
