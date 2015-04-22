if Rails.env.development? || Rails.env.test?
  namespace :spec do

    desc 'Run all specs in spec directory (exluding feature specs)'
    RSpec::Core::RakeTask.new(:no_features) do |task|
      file_list = FileList['spec/**/*_spec.rb']
      file_list = file_list.exclude("spec/features/**/*_spec.rb")

      task.pattern = file_list
    end
  end
end
