class MatchDecorator < Draper::Decorator
  delegate_all

  def opponent
    object.opponent.gsub("opponent_","")
  end

  def created_at
    object.created_at.strftime("%d.%m.%Y, %H:%M")
  end
end
