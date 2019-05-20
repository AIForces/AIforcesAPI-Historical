# AIForces

AIForces is an online judge for gaming AI competitions, written in Ruby.
It has a separated multithreaded judging system - [AIForces Judge](http://github.com/AbsoluteNikola/AIforcesJudge).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

This application requires:
* Ruby 2.6.1
* Rails 5.2.2
* Bundler 2 or greater
* Postgresql

Also, you need to install all the necessary gems by running
```
bundle
```

### Installing

1) Clone this repository to your local computer.
```
    git clone https://github.com/aalekseevx/AIforces.git
```
2) Satisfy all the prerequisites.
3) Create the database
```
rails db:create
rails db:schema:load
```
4) Install and run [AIForces Judge](http://github.com/AbsoluteNikola/AIforcesJudge) on the same computer.
5) Now, run AIForces
```
rails start
```

## Running the tests

TODO: describe the tests

## Deployment

These steps will help you to configure Capistrano, so that it could deploy an app to your remote server.
1) Clone this repository to your local computer.
```
    git clone https://github.com/aalekseevx/AIforces.git
```
2) Satisfy all the prerequisites on the remote server and on the local machine.
3) Change Capistrano settings, like server ip and ssh port, in [config/deploy.rb](config/deploy.rb) file.
4) Generate ssh keys on your local machine and add them to authorized_keys on your remote server.
5) Create a user and a database and set them in [config/database.yml](config/database.yml).
6) Generate SECRET_KEY_BASE and add it to the environmental variables at your remote server.
7) Run initial deploy from your local machine. Try to fix all the errors.
 ```
 capistrano deploy:initial
 ```
8) Configure nginx or apache as a reverse proxy.
9) Follow the instructions to deploy [AIForces Judge](http://github.com/AbsoluteNikola/AIforcesJudge).
It is preferred to use another machine in the same network. You can deploy as many judges, as much power you need.
10) Add judges endpoints to AIForces Settings. Use:
```
rails console production
Setting.judges_endpoints = %w[http://127.0.0.1:3001/judge]
Setting.trusted_ips = %w[127.0.0.1]
```
However, these values are set by default.

Now everything is set.

## Built With

* [Ruby On Rails](https://rubyonrails.org/) - Web Framework
* [Postgresql](https://www.postgresql.org/) - Database management system
* [Bulma](https://bulma.io/) - CSS Framework
* [Capistrano](https://capistranorb.com/) - Automated deployment

## Authors

* **Aleksandr Alekseev** - Rails and Web Design - [aalekseevx](https://github.com/aalekseevx)
* **Nikolay Rulev** - Multithreaded judging system - [AbsoluteNikola](https://github.com/AbsoluteNikola)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to Dmitry Chernyshev for the inspiration and some useful tips.

