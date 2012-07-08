Follow the instructions below to get the app running on a fresh install of Mac
OSX 10.7.

Install needed software packages
--------------------------------

### Install Xcode 4.3

Download the installer from the Apple App Store.

### Install Xcode Command Line Tools

Open Xcode 4.3 and navigate to Preferences > Downloads and install 'Command
Line Tools'

### Install Homebrew

We use Homebrew to install all the software dependencies for the app. Follow the
instructions at http://mxcl.github.com/homebrew/ to install the base system to
`/usr/local`.

### Install GCC 4.2

Install GCC 4.2 as Xcode does not ship with it and ruby does not like GCC LLVM.

    $ brew tap homebrew/dupes
    $ brew install apple-gcc42

### Configure Xcode

Manage the path to the Xcode folder for Xcode BSD tools.

    $ sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer

### Re-link gcc to 4.2

    $ sudo ln -sf /usr/local/bin/gcc-4.2 /usr/bin/gcc

### Install git

    $ brew install git

### Install MongoDB

    $ brew install mongodb


Install RVM
-----------

RVM is an easy way to manage multiple Ruby installations and environments.
Follow the instructions at http://rvm.beginrescueend.com/rvm/install/ to install
the system. By default, RVM keeps everything in ~/.rvm.

### Configure ~/.rvmrc

Create an .rvmrc file in your home directory with the following contents:

    export rvm_install_on_use_flag=1
    export rvm_gemset_create_on_use_flag=1
    export rvm_archflags="-arch x86_64"
    export rvm_project_rvmrc_default=1

After you install RVM, close your shell and open a new one to make sure it's
loaded properly.

Install RVM after cd bundler hook
---------------------------------

Run this command to add the ./bin directory of your projects to your path on cd

    chmod +x $rvm_path/hooks/after_cd_bundler

Checkout the app
----------------

This can be done either via the command below or using the GitHub client available at http://mac.github.com/

    $ git clone git@github.com:edmundsalvacion/griio-web.git

Install Ruby
------------

Ruby will automatically be installed when you `cd` into the app directory. This
happens when RVM detects the `.rvmrc` file in the root directory of the app.
This file tells RVM the version of Ruby that our app requires to run.

    $ cd griio-web

Set git merge to ff only
----------------------------

We want to prevent non fast forward merges.

    $ git config merge.ff only

Install needed gems
-------------------

### Install Bundler

    $ gem install bundler

### Install all other gems

Run the following from the root of the app directory.

    $ bundle install --binstubs


Install git pre-commit hook
---------------------------

    $ rake strip_whitespace:install

Database set up
---------------


Now you can use rake to set up the project database

    $ rake db:mongoid:create_indexes


Start the app server
--------------------

From the root app directory, run the following command.

    $ rails s

The app should now be running at: "http://localhost:3000"
