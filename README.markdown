# Vagrant Chef for CakePHP [![Build Status](https://travis-ci.org/FriendsOfCake/vagrant-chef.svg)](https://travis-ci.org/FriendsOfCake/vagrant-chef)


Vagrant Chef creates a Vagrant installation for CakePHP using Chef with the following features:

- Ubuntu 12.04 Precise Pangolin
- Ningx 1.6
- PHP 5.5
- Ruby 1.9.3
- Percona MySQL 5.5
- Postgres 9.1
- Redis 2.8
- Memcached 1.4
- Git 2.0
- Composer
- The ruby gems `heroku`, `hub`, `travis` and `travis-lint`

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 4.3.x, but 4.2.x should also work.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.4.1
- Patience, and about an hour or so of your time
- A fairly fast internet connection. Dial-up will take 3 days to get everything going ;)

## Installation

Before you start, download and install both VirtualBox and Vagrant for your particular operating system. Should only take a few minutes on a DSL connection. Note: use a binary package for Vagrant, don't try installing it from RubyGems.

There are two different ways how you can organize your project structure.

### Option 1: letting FriendsOfCake version control `vagrant-chef`

If you're satisfied with recipes already bundled with `vagrant-chef` and you're not going to customize or extend them, then it is recommended that you keep `vagrant-chef` under FriendsOfCake's source control.

This setup option allows you to recieve `vagrant-chef` updates from FriendsOfCake effortlessly.

The recommended project structure is as follows:

    your-project/
    ├ .git/           <- FriendsOfCake/vagrant-chef
    ├ app/
    │ ├ .git/         <- your-github-username/your-project
    │ ├ app/
    │ │ ├ Config/
    │ │ ├ Console/
    │ │ ├ Controller/
    │ │ ├ Lib/
    │ │ ├ Model/
    │ │ ├ Plugin/
    │ │ ├ tmp/
    │ │ ├ vendor/
    │ │ ├ View/
    │ │ └ webroot/
    │ ├ lib/
    │ ├ Plugin/
    │ ├ vendor/
    │ └ .gitignore
    ├ cookbooks/
    ├ .gitignore
    ├ Vagrantfile
    └ ...
        
Note the nested `app/app/` folders and two `.git` folders. The outermost `.git` folder is for versioning `vagrant-chef` under FriendsOfCake Github account, it has the `app/` folder ignored. The innermost one is for versioning your project under your Github account.

To start, create a blank folder (replace `<your-project>` with a reasonable name). You don't want a name collision with the existing project folder. Then clone the `vagrant-chef` repo into it:

```bash
mkdir <your-project>
cd <your-project>
git clone git@github.com:FriendsOfCake/vagrant-chef.git .
```

Note the dot in the end of the last command.

Then create an `app` folder inside `<your-project>` and set up your CakePHP environment inside it, so that the resulting structure resembles the one outlined above. If you're working on an existing CakePHP project, move the content of your former project folder (with its `.git/`, `.gitignore` and all the stuff) into `<your-project>/app/`.


### Option 2: including `vagrant-chef` recipes into your project's version control

The other approach allows customizing and/or extending `vagrant-chef`'s recipes by keeping them under your project's version control and simplifies your project's structure. The downside is that you'll be unable to receive `vagrant-chef` updates with a simple `git pull`, you'll have to apply updates manually.

To proceed, download a [zip](https://github.com/FriendsOfCake/vagrant-chef/archive/master.zip)/[tar.gz](https://github.com/FriendsOfCake/vagrant-chef/archive/master.tar.gz) snapshot of `vagrant-chef` and extract it into your project's root **without overwriting existing files**.

You can do that manually or with this command ("file exists" errors are intentional):

```bash
wget https://github.com/FriendsOfCake/vagrant-chef/archive/master.tar.gz -O - | tar -kxz --strip-components 1
```

Note: if your project has a `Gemfile`, you'll need to merge its contents with `vagrant-chef`'s.

This will result in a structure similar to this:

    your-project/
    ├ .git/         <- your-github-username/your-project
    ├ app/
    │ ├ Config/
    │ ├ Console/
    │ ├ Controller/
    │ ├ Lib/
    │ ├ Model/
    │ ├ Plugin/
    │ ├ tmp/
    │ ├ vendor/
    │ ├ View/
    │ └ webroot/
    ├ cookbooks/
    ├ lib/
    ├ Plugin/
    ├ vendor/
    ├ .gitignore
    ├ Vagrantfile
    └ ...
    
Afterwards, add the new files to your version control:

```bash
git add -A
git commit -m "Included `vagrant-chef` into the project"
```

## Setting up your virtual environment

To set up and run a virtual machine, simply run this command from the folder where `Vagrantfile` is located:

```bash
vagrant up
```

Alternatively, if you would like to make use of [Vagrant Cloud](https://vagrantcloud.com/), you can simply run the following.

```bash
vagrant init friendsofcake/cakephp-baking
```

It may take a bit to download the Vagrant box, but once that is done, you will be prompted for your laptop password. This is so we can properly expose the IP of the vagrant instance to your machine. Type in your password and let it continue running.

You can grab a coffee or go out for a beer at this point. Takes about half an hour to an hour, depending upon your internet connection and laptop resources.

The folder that contains the `Vagrantfile` will be mounted into the virtual machine as `/vagrant`. You can edit your project's sources on the host machine and the changes will immediately propagate to the virtual machine.

The folder will also be exposed to the web server as `http://192.168.13.37/`. Once the `vagrant up` routine is complete, navigate this URL in your browser, and you should have some sort of `It works!` page! At this point you can set your virtualhosts to point at the instance for maximum win.

Typing `vagrant ssh` while your vagrant instance is up will ssh onto the instance so you can perform commands directly on it. For example, it might be useful to manually install some service, or run a script within the repository.

You can also run single commands in the virtual machine without logging into it with `vagrant ssh -c "some command"`.


#### Custom Domain Name

If you want to access the site using a custom domain name, edit your `/etc/hosts` file to have the following line:

    192.168.13.37 www.app.dev app.dev

If you are the root user on your box, you can do something like:

```bash
echo "192.168.13.37 www.app.dev app.dev" >> "/etc/hosts"
```

#### Database Access

MySQL is available at `0.0.0.0:3306` with either of the following credentials:

- `root:bananas`
- `user:password`


## Starting/Stopping Work

You normally wont want to have the instance running full time. To pause it, simply perform the following command in the folder where `Vagrantfile` is located:

```bash
vagrant suspend
```

You will no longer be able to access the instance after doing this. To continue working, issue the following command:

```bash
vagrant resume
```

You can also use `vagrant halt` and `vagrant up` for shutting down and booting the virtual machine.

## Updating Vagrant

Running `vagrant provision` or `vagrant reload --provision` will reprovision the instance. Apply after modifying the recipes.

If you used option 1 to organize your project, then you can update your `vagrant-chef` recipes from FriendsOfCake. If there are any updates to the vagrant setup, such as a new feature, new site hosted within, or new service, simply do the following in a terminal within the folder where `Vagrantfile` is located:

```bash
git pull origin master
vagrant reload --provision
```

## Destroying the virtual machine

We're sad to see you leave your work behind, but removing the virtual machine form your system isn't hard. Simply iexecute this command within the folder where `Vagrantfile` is located:

```bash
vagrant destroy
```

This will destroy your vagrant installation, and you can proceed to remove the project folder from your computer.

## Bugs?

File a github issue.

## Todo

- Add phpmyadmin to setup

## MIT

Copyright (c) 2012 Jose Diaz-Gonzalez

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
