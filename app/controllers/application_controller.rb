class ApplicationController < ActionController::API

  def verify_authenticated
    render json: {message: "Permissão negada, usuário não está logado"}, status: 401 and return unless current_user.present?
  end

  def verify_student
    render json: {message: "Permissao Negada, usuário não é aluno"}, status: 401 and return unless current_user.student?
  end

  def verify_instructor
    render json: {message: "Permissao Negada, usuário não é professor"}, status: 401 and return unless current_user.instructor?
  end

  def verify_admin
    render json: {message: "Permissao Negada, usuário não é admin"}, status: 401 and return unless current_user.admin?
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
  