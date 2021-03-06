module Resque
  module Plugins
    module JobStats

      # Extend your job with this module to track how many 
      # jobs fail
      module Failed

        # Sets the number of jobs failed
        def jobs_failed=(int)
          Resque.redis.set(jobs_failed_key,int)
        end

        # Returns the number of jobs failed
        def jobs_failed
          Resque.redis.get(jobs_failed_key).to_i
        end

        # Returns the key used for tracking jobs failed
        def jobs_failed_key
          @jobs_failed_key ||= "stats:jobs:#{self.name}:failed"
        end

        # Increments the failed count when job is complete
        def on_failure_job_stats_failed(e,*payload)
          Resque.redis.incr(jobs_failed_key)
        end

      end
    end
  end
end
