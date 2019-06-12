# AIForces

AIForces is an online judge for gaming AI competitions. It's written in Ruby.
It has a separated multithreaded judging system - [AIForces Judge](http://github.com/AbsoluteNikola/AIforcesJudge).

### Demo: AIForces visualizes a game, played by 2 bots, written in C++.
![demo](https://i.ibb.co/1qnqY3w/demo.gif)
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

This application requires:
* `Ruby 2.6.1`
* `Rails 5.2.2`
* `Bundler 2 or greater`
* `Postgresql 11.2`
* `Redis`
* `libpq-dev`
* `nodejs`

Also, you need to install all the necessary gems by running
```bash
bundle
```

### Installing

1) Clone this repository to your local computer.
```bash
git clone https://github.com/aalekseevx/AIforces.git
```
2) Satisfy all the prerequisites.
3) Create the database
```bash
rails db:create
rails db:schema:load
```
4) Install and run [AIForces Judge](http://github.com/AbsoluteNikola/AIforcesJudge) on the same computer.
5) Now, run AIForces
```bash
rails start
```

## Running the tests

TODO: describe the tests

## Deployment

These steps will help you to configure Capistrano, so that it could deploy an app to your remote server.
1) Clone this repository to your local computer.
```bash
git clone https://github.com/aalekseevx/AIforces.git
```
2) Satisfy all the prerequisites on the remote server and on the local machine.
3) Change Capistrano settings, like server ip and ssh port, in [config/deploy.rb](config/deploy.rb) file.
4) Add server ssh keys to github
5) Generate ssh keys on your local machine and add them to authorized_keys on your remote server.
6) Create a user and a database and set them in [config/database.yml](config/database.yml) on your remote server.
7) Generate new master key and encrypted credentials.
8) Move your master key to apps/AIForces/shared/config folder on your server. 
9) Create AIforces_production database.
10) Run initial deploy from your local machine.
 ```bash
capistrano deploy:initial
 ```
11) Configure your web server as a reverse proxy.
12) Follow the instructions to deploy [AIForces Judge](http://github.com/AbsoluteNikola/AIforcesJudge).
It is preferred to use another machine in the same network. You can deploy as many judges, as much power you need.
13) Add judges endpoints to AIForces Settings. Use:
```bash
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

* **Aleksandr Alekseev ([aalekseevx](https://github.com/aalekseevx))** - Rails and Web Design 
* **Nikolay Rulev ([AbsoluteNikola](https://github.com/AbsoluteNikola))** - Multithreaded judging system

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to Dmitry Chernyshev and Danil Doroshin ([ddddanil](https://github.com/ddddanil)) for the inspiration and some
useful advice.