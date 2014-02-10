require 'resque/scheduler/lock/base'

module Resque
  class Scheduler
    module Lock
      class Basic < Base
        def acquire!
          if Resque.redis.setnx(key, value)
            extend_lock!
            true
          end
        end

        def locked?
          if Resque.redis.get(key) == value
            extend_lock!

            return true if Resque.redis.get(key) == value
          end

          false
        end
      end
    end
  end
end
