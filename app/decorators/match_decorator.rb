class MatchDecorator < Draper::Decorator
  include GlobalConstants
  delegate_all

  def opponent
    object.opponent.gsub('opponent_', '')
  end

  def created_at
    object.created_at.strftime(STRFTIME_FORMAT)
  end

  def hero_image
    h.image_path("heroes/#{model.hero}_small_circle.png")
  end

  def opponent_image
    h.image_path("heroes/#{opponent}_small_circle.png")
  end

  def won
    model.won? ? 'win' : 'loose'
  end

  def arena_link
    h.arena_path(model.arena) if model.arena
  end

  def arena_id
    model.arena.id if model.arena
  end

  def as_json(options = {})
    super(
      options.merge(
        methods: %i[id created_at hero hero_image opponent
                    opponent_image won arena_link arena_id]
      )
    )
  end
end
