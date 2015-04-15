class MatchDecorator < Draper::Decorator
  include GlobalConstants
  delegate_all

  def opponent
    object.opponent.gsub('opponent_', '')
  end

  def created_at
    object.created_at.strftime(STRFTIME_FORMAT)
  end
end
