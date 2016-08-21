# Vagrant Chef for CakePHP [![Build Status](https://img.shields.io/travis/FriendsOfCake/vagrant-chef/master.svg?style=flat-square)](https://travis-ci.org/FriendsOfCake/vagrant-chef)


Vagrant Chef creates a Vagrant installation for CakePHP using Chef with the following features:

- Ubuntu 14.04 LTS Trusty Tahr
- Nginx 1.10 (via [ppa](https://launchpad.net/~nginx/+archive/ubuntu/stable))
- PHP 7.0 (via [ppa](https://launchpad.net/~ondrej/+archive/ubuntu/php))
- Ruby 2.3 (via [ppa](https://launchpad.net/~brightbox/+archive/ubuntu/ruby-ng))
- Percona MySQL 5.6 (via [percona's apt repo](https://www.percona.com/doc/percona-server/5.6/installation/apt_repo.html))
- Postgres 9.6 (via [postgres's apt repo](https://wiki.postgresql.org/wiki/Apt))
- Redis 3.0 (via [ppa](https://launchpad.net/~chris-lea/+archive/ubuntu/redis-server))
- Memcached 1.4
- Git 2.9 (via [ppa](https://launchpad.net/~git-core/+archive/ubuntu/ppa))
- Composer
- The ruby gems `heroku`, `hub`, and `travis`

## Table Of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Developing your application](#developing-your-application)
  - [Custom Domain Name](#custom-domain-name)
  - [Database Access](#custom-domain-name)
  - [Multiple Repositories](#multiple-repositories)
  - [Interacting with the Virtual Machine](#interacting-with-the-virtual-machine)
    - [Starting/Stopping the VM](#startingstopping-the-virtual-machine)
    - [Updating the VM](#updating-the-virtual-machine)
    - [Destroying the VM](#destroying-the-virtual-machine)
- [Bugs](#bugs)
- [License](#license)

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 5.0.x.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.8+
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

## Usage

### Developing your application

When you want to use vagrant instance for a development environment, you can create an `app` directory with the contents of your application. Within the vm, this would be an example of your directory structure:

    |-/vagrant/app
    | |-/vagrant/app/bin
    | |-/vagrant/app/config
    | |-/vagrant/app/logs
    | |-/vagrant/app/plugins
    | |-/vagrant/app/src
    |   |-/vagrant/app/src/Console
    |   |-/vagrant/app/src/Controller
    |   |-/vagrant/app/src/Model
    |   |-/vagrant/app/src/Shell
    |   |-/vagrant/app/src/Template
    |   |-/vagrant/app/src/View
    |-/vagrant/app/tests
    |-/vagrant/app/tmp
    |-/vagrant/app/vendor
    |-/vagrant/app/webroot

Anything in `app/webroot/index.php` will be served up, and all other `index.php` files ignored.

Note, we recommend using the [FriendsOfCake/app-template](https://github.com/FriendsOfCake/app-template) for new applications.

### Custom Domain Name

If you want to access the site using a custom domain name, edit your `/etc/hosts` file to have the following line:

    192.168.13.37 www.app.dev app.dev

If you are the root user on your box, you can do something like:

```bash
echo "192.168.13.37 www.app.dev app.dev" >> "/etc/hosts"
```

### Database Access

MySQL is available at `192.168.13.37:3306` with either of the following credentials:

- `root:bananas`
- `user:password`

Postgres is available at `192.168.13.37:5432` with either of the following credentials:

- `postgres:password`
- `username:password`

### Multiple Repositories

If you want to use multiple repositories with this Vagrant setup, simply create an `apps` directory in the root of this repo:

```shell
cd path/to/vagrant-chef
mkdir -p apps
```

Next, copy your CakePHP repository to the `apps` directory. For instance, if you want to have a `blog` project, your directory structure would be similar to the following:

    |-/vagrant/apps
    | |-/vagrant/apps/blog
    |   |-/vagrant/apps/blog/webroot

This application will be automatically available as `blog.dev`. Updating your hosts `/etc/hosts` entry to include this will allow you to access it in a browser:

```
echo "192.168.13.37 www.app.dev app.dev blog.dev" >> "/etc/hosts"
```

Using this method, you can host as many applications within a single VM instance as desired.

### Interacting with the Virtual Machine

#### Starting/Stopping the Virtual Machine

You normally wont want to have the instance running full time. To pause it, simply perform the following in the command line:

```bash
vagrant suspend
```

You will no longer be able to access the instance after doing this. To continue working, issue the following command:

```bash
vagrant resume
```

You can also use `vagrant halt` and `vagrant up` for shutting down and booting the virtual machine.

#### Updating the Virtual Machine

Running `vagrant provision` will reprovision the instance. You won't normally need to do the things in the **Installation** section, but this will ensure your setup is as up-to-date as possible.

If there are any updates to the vagrant setup, such as a new feature, new site hosted within, or new service, simply do the following in a terminal:

```bash
git pull origin master
vagrant reload --provision
```

#### Destroying the Virtual Machine

We're sad to see you leave your work behind, but removing the virtual machine form your system isn't hard. Simply execute this command within the folder where `Vagrantfile` is located:

```bash
vagrant destroy
```

This will destroy your vagrant installation, and you can proceed to remove the project folder from your computer.

## Bugs?

File a github issue.

## License

MIT

Copyright (c) 2012 Jose Diaz-Gonzalez

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
