name "index-server"
description "Server with all the necessary components to do Sphinx indexing the Rails app"
run_list(
  "recipe[cap-deploy-user]",
  "recipe[xmllibs]",
  "recipe[mysql-dev]",
  "recipe[git]",
  "recipe[bundler]",
  "recipe[sphinx]"
)
