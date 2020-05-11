help:
	cat Makefile

up:
	docker-compose run --service-ports web

up-d:
	docker-compose up -d

 stop:
	docker-compose stop

## Remove stopped containers
rm:
	make stop
	docker-compose rm -f

## danger: Stop and remove containers, networks, images, and volumes
down:
	docker-compose down

# commands for development
docker-build:
	docker-compose build

docker-build-no-cache:
	docker-compose build --no-cache

install:
	docker-compose run web bundle install
	docker-compose run web yarn install

webpacker-install:
	docker-compose run web bundle exec rails webpacker:install

rails-console:
	docker-compose run web bundle exec rails console

db-migrate:
	docker-compose run web bundle exec rails db:migrate

rollback:
	docker-compose run web bundle exec rails db:rollback


# commands for init project
init-project:
	make rails-new
	sh gitignore.sh
	make docker-build-no-cache
	make webpacker-install
	make install
	mv database.yml config/database.yml
	make db-create
	make up-d
	git add .
	git commit -m ":tada: first commit"
	echo '🎉 http://localhost:3000'
	echo '⛔️ if you want to stop docker-compose, type "make stop"'

# options
## docker-compose --no-deps: Don't start linked services. (only starts web service.)
## rails new --force: to overwrite Gemfile
## rails new --skip-bundle: we will bundle later, so skip
rails-new:
	docker-compose run --no-deps web rails new . --force --database=mysql

db-create:
	docker-compose run web bundle exec rails db:create