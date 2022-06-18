class ApplicationController < ActionController::API
    def verify_authenticated
      render json: {message: "Permissao negada, faça login primeiro"}, status: 401 and return unless current_user.present?
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
  
    def already_on_meeting?(user_id)
      MeetingMembership.where(user_id: user_id).each do |meeting_membership|
        meeting = Meeting.find_by(id: meeting_membership.meeting_id)
        unless meeting.is_finish?("Meeting")
          return true
        end
      end
      return false
    end
  
  end
class ApplicationController < ActionController::API

  def verify_authenticated
    render json: {message: "Permissao Negada, faça login primeiro"}, status: 401 and return unless current_user.present?
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

  def already_on_meeting?(user_id)
    MeetingMembership.where(user_id: user_id).each do |meeting_membership|
      meeting = Meeting.find_by(id: meeting_membership.meeting_id)
      unless meeting.is_finish?("Meeting")
        return true
      end
    end
    return false
  end

end
  