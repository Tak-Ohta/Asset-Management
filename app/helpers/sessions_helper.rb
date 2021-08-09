module SessionsHelper

  # 引数に渡されたユーザーオブジェクトでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 永続セッションを記憶する（Userモデルを参照）
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  # 現在ログイン中のユーザーがいる場合、オブジェクトを返す
  # 現在ログインしているユーザーオブジェクトの各値を取れるようにすること。ログインユーザーの情報ページにリダイレクトできるようにすること。
  def current_user
    # findメソッド：session[:user_id]が存在しない場合、例外（エラーが発生）が発生
    # find_byメソッド：session[:user_id]が存在しない場合、nil（「何も無い」）が返される
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # セッションと@current_userを破棄する
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
