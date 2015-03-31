class ArenaDecorator < Draper::Decorator
  delegate_all

  def won_count
    object.matches.select{ |x| x.won == true }.count
  end

  def lost_count
    object.matches.select{ |x| x.won == true }.count
  end

  def finished?
    object.finished?(won_count, lost_count)
  end

  def created_at
    object.created_at.strftime("%d.%m.%Y %H:%M")
  end
end
