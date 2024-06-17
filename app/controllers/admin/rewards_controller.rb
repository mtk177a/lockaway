class Admin::RewardsController < Admin::BaseController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

  def index
    @rewards = Reward.all
  end

  def show
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      redirect_to admin_rewards_path, notice: 'Reward was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reward.update(reward_params)
      redirect_to admin_rewards_path, notice: 'Reward was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reward.destroy
    redirect_to admin_rewards_path, notice: 'Reward was successfully deleted.'
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:name, :habit_type, :description, :condition_type, :threshold)
  end
end
