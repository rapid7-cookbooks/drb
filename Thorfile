# encoding: utf-8

require 'bundler'
require 'bundler/setup'

require 'foodcritic'
require 'thor/rake_compat'

class Default < Thor
  include Thor::RakeCompat

  FoodCritic::Rake::LintTask.new

  desc 'foodcritic', 'Lint Chef cookbooks'
  def foodcritic
    Rake::Task['foodcritic'].execute
  end

  desc 'chefspec', 'Run ChefSpec tests against the current cookbook', aliases: ['rspec', 'spec']
  def chefspec
    exec 'bundle exec rspec'
  end
end

begin
  require 'kitchen/thor_tasks'
  Kitchen::ThorTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
