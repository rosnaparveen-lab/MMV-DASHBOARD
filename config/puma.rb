port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "production" }
workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))
threads Integer(ENV.fetch("RAILS_MAX_THREADS", 5)), Integer(ENV.fetch("RAILS_MAX_THREADS", 5))

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
