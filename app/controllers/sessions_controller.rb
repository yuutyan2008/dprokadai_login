class SessionsController < ApplicationController
  #
  #
  skip_before_action :login_required, only: [:new, :create]
  #
  def new 
    #セッションに関してはインスタンスの作成が必要ないので、newアクションには何も処理が入りません
    @user = User.new
  end

  # Sessionsコントローラにセッションを作成する
  def create
    #入力されたメールアドレスを元に、find_byメソッドを使ってデータベースからユーザを取り出す
    @user = User.find_by(email: params[:session][:email].downcase)

    # メールアドレスとパスワードの組み合わせが有効か調べる
    # find_byで取得したユーザのパスワードと引数に指定したパスワードが一致するかを検証
    # params[:session][:password]で入力されたパスワードを取得
    # &.を利用し、nilの場合でもエラーが発生しないようにします
    if @user&.authenticate(params[:session][:password])
      # ログイン成功した場合
      #ログインした際は、Flashを表示させる
      flash[:notice] = 'ログインしました'
      # セッションオブジェクトにユーザIDを登録し、そのユーザの詳細画面に遷移
      log_in(@user)
      # URLヘルパーメソッドuser_pathで /tasks (index アクション) にリダイレクトする
      redirect_to tasks_path
    else
      # ログイン失敗した場合
      # renderを使ってnewアクションを呼び出します。
      # 現在のリクエストの間だけメッセージを保持
      flash.now[:danger] = I18n.t('flash.sessions.create_failure')
      render :new
    end
  end

  # Sessionsコントローラにログアウトを行う
  def destroy
    session.delete(:user_id) # セッションオブジェクトからユーザIDを削除

    #ログアウトした際は、ログインページに遷移させ、Flashを表示させる
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  

end
