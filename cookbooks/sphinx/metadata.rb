maintainer       "Ross Cooperman"
maintainer_email "cooperman@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures the Sphinx full-text search engine"
version          "0.0.1"

recipe "sphinx::source", "Installs Sphinx from source and adds init script"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "build-essential"
depends "mysql-dev"

attribute "sphinx/version",
  :display_name => "Sphinx version",
  :description => "Which Sphinx version will be installed",
  :default => "0.9.9"

attribute "sphinx/source",
  :display_name => "Sphinx source file",
  :description => "Downloaded location for Sphinx"

attribute "sphinx/checksum",
  :display_name => "Sphinx source file checksum",
  :description => "Will make sure the source file is the real deal",
  :default => "8c739b96d756a50972c27c7004488b55d7458015"

attribute "sphinx/dir",
  :display_name => "Sphinx installation path",
  :description => "Sphinx will be installed here",
  :default => "/opt/sphinx"
