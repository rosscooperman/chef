name "cache-server"
description "Server running Redis for storing cached data"
run_list(
  "recipe[redis]"
)
