module SessionsHelper

  # 引数に渡されたユーザーオブジェクトでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーがいる場合、オブジェクトを返す
  # 現在ログインしているユーザーオブジェクトの各値を取れるようにすること。ログインユーザーの情報ページにリダイレクトできるようにすること。
  def current_user
    # findメソッド：session[:user_id]が存在しない場合、例外（エラーが発生）が発生
    # find_byメソッド：session[:user_id]が存在しない場合、nil（「何も無い」）が返される
    if session[:user_id]
      if @current_user.nil?
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返す
  def logged_in?
    !@current_user.nil?
  end
end
