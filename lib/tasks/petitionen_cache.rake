namespace :petitionen_cache do
  desc "updates xyz_cached columns"
  task :update => :environment do
    Petition.update_cached_columns!
  end
end

