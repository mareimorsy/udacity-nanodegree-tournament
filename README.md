# Udacity nanodegree game tournament
a Python module that uses the PostgreSQL database to keep track of players and matches in a game tournament.
## Requirements
1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Download and install [Vagrant](https://www.vagrantup.com/downloads.html)

## How to run the project?
1. Clone or Download the project and extact its content into your working directory
2. Open the terminal in `vagrant` directory and type the following commands:

```
$ vagrant up
$ vagrant ssh
$ cd /vagrant/tournament
$ psql
   CREATE DATABASE tournament;
   \c tournament
   \i tournament.sql
   \q
$ python tournament_test.py
```
