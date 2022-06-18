class ApplicationController < ActionController::API

  def verify_authenticated
    render json: {message: "Permissão negada, faça login primeiro"}, status: 401 and return unless current_user.present?
  end

  def verify_admin
    render json: {message: "Permissao Negada, faça login primeiro"}, status: 401 and return unless current_user.admin?
  end

  def current_user
    header = request.headers["Authorization"]
    header = header.split(" ").last if header

    return nil unless header.present?
    @decoded = JsonWebToken::Base.decode(header)
    return nil unless @decoded

    user = User.find_by(id: @decoded[0]['user_id'])
    return user
  end
end
  