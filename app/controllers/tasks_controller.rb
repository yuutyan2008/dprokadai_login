class TasksController < ApplicationController
  # controllerのアクション実行前にログインが必要
  before_action :login_required

  # アクションjっ買う前にset_taskが必要なもの。indexは特定の1つのタスクを取得する必要がないため不要
  # editは編集データを取得する必要がある
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # dログインしているユーザーのタスクのみ表示
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    # current_user に関連付けてタスクを作成
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('.created')
    else
      render :new
    end
  end


  def show
    # before_action :set_taskでshowアクションを指定しているため、記述がなくてもデータを取得できる
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content)
    end
end
