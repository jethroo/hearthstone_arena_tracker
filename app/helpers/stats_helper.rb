module StatsHelper
  def win_loss_json
    matches = current_user.matches
    result = []
    Hero::HEROS.each do | hero |
      win_loss = [
                    matches.where(hero: Match.heros[hero], won: true).count,
                    matches.where(hero: Match.heros[hero], won: false).count
                  ]
      if win_loss.reduce(:+) > 0
        result << {
                    name: hero.to_s,
                    data: win_loss
                  }
      end
    end
    result
  end
end
