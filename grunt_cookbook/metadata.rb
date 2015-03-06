maintainer       "Matt Surabian"
maintainer_email "matt@mattsurabian.com"
license          "MIT"
description      "Provides lightweight resources and recipes for installing and working with GRUNT."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"


# Setup recipes.
recipe "grunt_cookbook::install_grunt_prereq", "Installs Nodejs and NPM so grunt can do its thing"
recipe "grunt_cookbook::install_grunt_cli", "Installs the grunt-cli globally using NPM."
recipe "grunt_cookbook::install_grunt_cli_and_bower", "Installs the grunt-cli and bower globally using NPM."
recipe "grunt_cookbook::install_grunt_cli_and_bower_and_webpack", "Installs the grunt-cli and bower globally using NPM."
