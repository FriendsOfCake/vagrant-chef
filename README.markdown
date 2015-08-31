# Vagrant Chef for CakePHP [![Build Status](https://travis-ci.org/FriendsOfCake/vagrant-chef.svg)](https://travis-ci.org/FriendsOfCake/vagrant-chef)


Vagrant Chef creates a Vagrant installation for CakePHP using Chef with the following features:

- Ubuntu 14.04 LTS Trusty Tahr
- Nginx 1.6
- PHP 5.5
- Ruby 2.1
- Percona MySQL 5.6
- Postgres 9.3
- Redis 2.8
- Memcached 1.4
- Git 2.2
- Composer
- The ruby gems `heroku`, `hub`, `travis` and `travis-lint`

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 4.3.x.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.6+
- Patience, and about an hour or so of your time
- A fairly fast internet connection. Dial-up will take 3 days to get everything going ;)

## Installation

Download and install both VirtualBox and Vagrant for your particular operating system. Should only take a few minutes on a DSL connection.

Once those are downloaded, open up a terminal. We'll need to clone this repository and setup vagrant:

```bash
git clone https://github.com/FriendsOfCake/vagrant-chef.git
cd vagrant-chef
```

Now we need to setup the vagrant installation. This is pretty easy:

```bash
vagrant up
```

Alternativly if you would like to make use of [Vagrant Cloud](https://vagrantcloud.com/friendsofcake/cakephp-baking/version/1) you can simply run the following.

```bash
vagrant init friendsofcake/cakephp-baking
```

It may take a bit to download the Vagrant box, but once that is done, you will be prompted for your laptop password. This is so we can properly expose the IP of the vagrant instance to your machine. Type in your password and let it continue running.

You can grab a coffee or go out for a beer at this point. Takes about half an hour to an hour, depending upon your internet connection and laptop resources.

Of note is that typing `vagrant ssh` while your vagrant instance is up will ssh onto the instance so you can perform commands directly on it. For example, it might be useful to manually install some service, or run a script within the repository.

Once it is done, browse to `http://192.168.13.37/` in your browser, and you should have some sort of `It works!` page! At this point you can set your virtualhosts to point at the instance for maximum win.

#### Custom Domain Name

If you want to access the site using a custom domain name, edit your `/etc/hosts` file to have the following line:

    192.168.13.37 www.app.dev app.dev

If you are the root user on your box, you can do something like:

```bash
echo "192.168.13.37 www.app.dev app.dev" >> "/etc/hosts"
```

#### Database Access

MySQL is available at `192.168.13.37:3306` with either of the following credentials:

- `root:bananas`
- `user:password`

Postgres is available at `192.168.13.37:5432` with either of the following credentials:

- `postgres:password`
- `username:password`

#### Developing your application

When you want to use vagrant instance for a development environment, you can create an `app` directory with the contents of your application. Within the vm, this would be an example of your directory structure:

    |-/vagrant/app
    |-/vagrant/app/app
    | |-/vagrant/app/app/Config
    | |-/vagrant/app/app/Console
    | |-/vagrant/app/app/Controller
    | |-/vagrant/app/app/Lib
    | |-/vagrant/app/app/Model
    | |-/vagrant/app/app/Plugin
    | |-/vagrant/app/app/Vendor
    | |-/vagrant/app/app/View
    |-/vagrant/app/tmp
    |-/vagrant/app/webroot
    |-/vagrant/app/lib
    |-/vagrant/app/plugin
    |-/vagrant/app/vendor

Anything in `app/webroot/index.php` will be served up, and all other `index.php` files ignored.

Note, we recommend using the [FriendsOfCake/app-template](https://github.com/FriendsOfCake/app-template) for new applications.

## Starting/Stopping Work

You normally wont want to have the instance running full time. To pause it, simply perform the following in the command line:

```bash
vagrant suspend
```

You will no longer be able to access the instance after doing this. To continue working, issue the following command:

```bash
vagrant resume
```

You can also use `vagrant halt` and `vagrant up` for shutting down and booting the virtual machine.

## Updating Vagrant

Running `vagrant provision` will reprovision the instance. You won't normally need to do the things in the **Installation** section, but this will ensure your setup is as up-to-date as possible.

If there are any updates to the vagrant setup, such as a new feature, new site hosted within, or new service, simply do the following in a terminal:

```bash
git pull origin master
vagrant reload --provision
```

## Destroying the virtual machine

We're sad to see you leave your work behind, but removing the virtual machine form your system isn't hard. Simply execute this command within the folder where `Vagrantfile` is located:

```bash
vagrant destroy
```

This will destroy your vagrant installation, and you can proceed to remove the project folder from your computer.

## Bugs?

File a github issue.

## MIT

Copyright (c) 2012 Jose Diaz-Gonzalez

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
