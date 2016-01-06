module StatsHelper
  def win_loss_data
    hero_stats_graph_array(query_hero_stats(''))
  end

  def win_loss_over_time_data
    [over_time_data('TRUE'), over_time_data('FALSE')]
  end

  def arena_win_loss_by_class_data
    arena_win_loss_by_class_array(
      query_hero_stats('AND matches.arena_id IS NOT NULL')
    )
  end

  private

  def arena_win_loss_by_class_array(matches)
    wins = []
    losses = []
    Hero::HEROS.each do |hero|
      hero_result = detect_hero(matches, hero)
      wins << (hero_result ? hero_result.wins : 0)
      losses << (hero_result ? hero_result.losses : 0)
    end
    arena_win_loss_by_class_result(wins, losses)
  end

  def arena_win_loss_by_class_result(wins, losses)
    [
      { name: 'Win', data: wins, pointPlacement: 'on' },
      { name: 'Losses', data: losses, pointPlacement: 'on' }
    ]
  end

  def detect_hero(matches, hero)
    matches.detect { |match| match.hero == hero.to_s }
  end

  def hero_stats_graph_array(matches)
    result = []
    Hero::HEROS.each do |hero|
      hero_result = detect_hero(matches, hero)
      next unless hero_result
      result << {
        name: hero.to_s,
        data: [hero_result.wins, hero_result.losses]
      }
    end
    result
  end

  def query_hero_stats(arena_part)
    query = <<-SQL
      SELECT matches.hero,
        COUNT( CASE WHEN matches.won IS TRUE THEN 1 ELSE NULL END) AS wins,
        COUNT( CASE WHEN matches.won IS FALSE THEN 1 ELSE NULL END) AS losses
        FROM matches
        WHERE matches.user_id = ?
        %s
        GROUP BY matches.hero
      SQL

    Match.find_by_sql([query % arena_part, current_user.id])
  end

  def over_time_data(type)
    result = []
    over_time(type).each do |day_result|
      result << [day_result.day_in_millis, day_result.wins]
    end

    {
      name: type == 'TRUE' ? 'Wins' : 'Loses',
      data: result
    }
  end

  def over_time(type)
    Match.find_by_sql([over_time_query % type, current_user.id])
  end

  def over_time_query
    <<-SQL
      SELECT EXTRACT(EPOCH FROM created_at::date AT TIME ZONE 'UTC')*1000
        AS day_in_millis, COUNT(*) AS wins
        FROM matches
        WHERE matches.user_id = ?
        AND matches.won IS %s
        GROUP BY day_in_millis
        ORDER BY day_in_millis ASC
    SQL
  end
end
