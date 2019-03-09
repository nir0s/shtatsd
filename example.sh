. ./statsd

function example_function() {
  statsd.increment 'function_call_count,key=value'
  local -r start_time=$(statsd.helper.now)

  sleep 3

  local -r end_time=$(statsd.helper.now)
  statsd.timing 'function_duration_ms,key=value' $(($end_time-$start_time))
}

example_function "$@"
