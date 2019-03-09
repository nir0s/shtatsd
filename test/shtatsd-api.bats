load 'libs/bats-support/load'
load 'libs/bats-assert-1/load'

@test "Emit counter metric" {
  source ./statsd
  run statsd.increment "my_counter"
}
