

# Run jobs instantly if testing
Delayed::Worker.delay_jobs = !Rails.env.test?

