shtatsd
=======

[![Circle CI](https://circleci.com/gh/strigo/shtatsd.svg?style=shield)](https://circleci.com/gh/strigo/shtatsd)


shtatsd is a statsd client for bash. It is the reasonable alternative to: `echo -n "my_metric:60|g" >/dev/udp/localhost/8125`

Note that the following documentation relates to the code currently in the master branch. If you want to view docs for previous versions, please choose the relevant release in the "releases" tab.

All basic metric types are supported. You can also emit labels (for Prometheus, dogstatsd, etc..) by adding them to the metric.

## Installation

```bash
Install locally:

[[ ! -f "statsd" ]] && \
	curl -LO https://github.com/strigo/shtatsd/raw/master/statsd && \
	chmod +x statsd

or directly to your path (Yes, we sudo):

[[ ! -f "/usr/bin/statsd" ]] && \
	sudo curl -L https://github.com/strigo/shtatsd/raw/master/statsd -o /usr/bin/statsd && \
	sudo chmod +x /usr/bin/statsd
```

## Usage

```shell
. statsd

statsd.increment "my_counter"
statsd.increment "my_counter" 2
statsd.increment "my_counter" 5 0.1

statsd.decrement "my_counter"
statsd.decrement "my_counter" 2
statsd.decrement "my_counter" 5 0.1

statsd.gauge "my_gauge" 113
statsd.gauge "my_gauge" 113 0.3

statsd.timing "my_timer" 314
statsd.timing "my_timer" 314 0.5

statsd.histogram "my_histogram" 5
statsd.set "my_set" 1092
```

Don't, forget, bash, expansion, everywhere. Spaces are evil.

### Calculating time in milliseconds

The `statsd.timing` function expects time in milliseconds. `shtatsd` provides a helper for this, and you can use it like so:

```
. ./statsd

function example_function() {
  statsd.increment 'function_call_count,key=value'
  local -r start_time=$(statsd.helper.now)

  sleep 3

  local -r end_time=$(statsd.helper.now)
  statsd.timing 'function_duration_ms,key=value' $(($end_time-$start_time))
}

example_function "$@"
```


## Env var based config

You can use environment variables to set the STATSD_HOST and STATSD_PORT to emit to (defaulting to 127.0.0.1 and 8125 respectively).


## Tests

To run tests locally:

```shell
$ npm install bats
...
$ git submodule init
$ git submodule update --remote
$ node_modules/bats/bin/bats test/*.bats
```

