module StatsHelper
  def win_loss_data
    hero_stats_graph_array(query_hero_stats)
  end

  def win_loss_over_time_data
    [ over_time_data(true), over_time_data(false) ]
  end

  private

  def hero_stats_graph_array(matches)
    result = []
    Hero::HEROS.each do | hero |
      hero_result = matches.detect{ |m| m.hero == hero.to_s }
      if hero_result
        result << {
                    name: hero.to_s,
                    data: [
                            hero_result.wins,
                            hero_result.loses
                          ]
                  }
      end
    end
    result
  end

  def query_hero_stats
    query = <<-SQL
      SELECT `matches`.`hero`,
        COUNT( IF(`matches`.`won` = 1, 1, NULL) ) AS wins,
        COUNT( IF(`matches`.`won` = 0, 1, NULL) ) AS loses
        FROM `matches`
        WHERE `matches`.`user_id` = ?
        GROUP BY `matches`.`hero`
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
        FROM `matches`
        WHERE `matches`.`user_id` = ?
        AND `matches`.`won` IS #{ wins ? TRUE : FALSE}
        GROUP BY day
      SQL

    Match.find_by_sql([query, current_user.id])
  end
end
