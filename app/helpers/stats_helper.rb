module StatsHelper
  def win_loss_json
    hero_stats_graph_array(query_hero_stats)
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
        COUNT( if(`matches`.`won` = 1, 1, NULL) ) as wins,
        COUNT( if(`matches`.`won` = 0, 1, NULL) ) as loses
        FROM `matches`
        WHERE `matches`.`user_id` = ?
        GROUP BY `matches`.`hero`
    SQL

    Match.find_by_sql([query, current_user.id])
  end
end
