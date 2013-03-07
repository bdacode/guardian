$: << 'lib'

require 'clockwork'
require 'guardian/bucket'

include Clockwork

every(5.minutes, 'queue_new_logs') do
  Guardian::Bucket.enqueue_processing_new_logs
end

# TODO: Purge old requests
# every(1.hour, 'purge_old_requests') { Request.purge_old_requests }

at_exit do
  # TODO: Better error message
  $stderr.puts "Unhandled Error: #{$!.inspect} - #{$@}" if $!
end
