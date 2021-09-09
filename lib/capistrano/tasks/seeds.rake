namespace :deploy do
    desc "reload the database with seed data"
    task :seeds do
      on roles(:all) do
        within current_path do
          execute :bundle, :exec, "rails", "db:seeds", "RAILS_ENV=production"
        end
      end
    end
  end
  after "deploy:migrate", "seeds"