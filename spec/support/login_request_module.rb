module LoginRequestModule
  def sign_in_as(user)
    post new_user_session_path, params: { session: { email: user.email, password: user.password } }
  end
end
