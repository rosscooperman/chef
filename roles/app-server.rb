name "app-server"
description "Server with all the necessary components to run the Rails app"
run_list(
  "recipe[cap-deploy-user]",
  "recipe[xmllibs]",
  "recipe[mysql-dev]",
  "recipe[imagemagick]",
  "recipe[unzip]",
  "recipe[git]",
  "recipe[bundler]"
)
