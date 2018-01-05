class ArenaDecorator < Draper::Decorator
  include GlobalConstants
  delegate_all

  def won_count
    object.matches.select { |match| match.won == true }.size
  end

  def lost_count
    object.matches.select { |match| match.won == false }.size
  end

  def finished?
    won_count >= Arena::MAX_WINS ||
      lost_count >= Arena::MAX_LOSES
  end

  def created_at
    object.created_at.strftime(STRFTIME_FORMAT)
  end
end
