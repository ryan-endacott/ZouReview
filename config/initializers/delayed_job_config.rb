

# Run jobs instantly if testing
Delayed::Worker.delay_jobs = !Rails.env.test?


Delayed::Job.scaler = :heroku_cedar if Rails.env == 'production'
