if Rails.env.development? || Rails.env.test?
  task :rubycritic do
    `rubycritic`
  end
end
