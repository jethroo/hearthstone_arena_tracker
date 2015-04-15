module StatsHelper
  def win_loss_data
    hero_stats_graph_array(query_hero_stats)
  end

  def win_loss_over_time_data
    [ over_time_data(true), over_time_data(false) ]
  end

  def arena_win_loss_by_class_data
    arena_win_loss_by_class_array(query_hero_stats(true))
  end

  private

  def arena_win_loss_by_class_array(matches)
    wins = []
    losses = []
    Hero::HEROS.each do | hero |
      hero_result = matches.detect{ |m| m.hero == hero.to_s }
      if hero_result
        wins << hero_result.wins
        losses << hero_result.losses
      else
        wins << 0
        losses << 0
      end
    end
    result = [
      {
        name: 'Win',
        data: wins,
        pointPlacement: 'on'
      },
      {
        name: 'Losses',
        data: losses,
        pointPlacement: 'on'
      }
    ]
  end

  def hero_stats_graph_array(matches)
    result = []
    Hero::HEROS.each do | hero |
      hero_result = matches.detect{ |m| m.hero == hero.to_s }
      if hero_result
        result << {
                    name: hero.to_s,
                    data: [
                            hero_result.wins,
                            hero_result.losses
                          ]
                  }
      end
    end
    result
  end

  def query_hero_stats(arena_only=false)
    query = <<-SQL
      SELECT matches.hero,
        COUNT( CASE WHEN matches.won IS TRUE THEN 1 ELSE NULL END) AS wins,
        COUNT( CASE WHEN matches.won IS FALSE THEN 1 ELSE NULL END) AS losses
        FROM matches
        WHERE matches.user_id = ?
        #{"AND matches.arena_id IS NOT NULL" if arena_only}
        GROUP BY matches.hero
      SQL

    Match.find_by_sql([query, current_user.id])
  end

  def over_time_data(wins = true)
    result = []
    over_time(wins).each do |day|
      result << [day.day.to_time.to_i*1000, day.wins ]
    end

    {
      name: wins ? "Wins" : "Loses",
      data: result
    }
  end

  def over_time(wins = true)
    query = <<-SQL
      SELECT DATE(created_at) AS day, COUNT(*) AS wins
        FROM matches
        WHERE matches.user_id = ?
        AND matches.won IS #{ wins ? TRUE : FALSE}
        GROUP BY day
      SQL
    Match.find_by_sql([query, current_user.id])
  end
end
