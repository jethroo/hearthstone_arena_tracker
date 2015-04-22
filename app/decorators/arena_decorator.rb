class ArenaDecorator < Draper::Decorator
  include GlobalConstants
  delegate_all

  def won_count
    object.matches.select { |match| match.won == true }.count
  end

  def lost_count
    object.matches.select { |match| match.won == false }.count
  end

  def finished?
    object.finished?(won_count, lost_count)
  end

  def created_at
    object.created_at.strftime(STRFTIME_FORMAT)
  end
end
