.PHONY: frontend webapp payment bench

all: frontend webapp payment bench

frontend:
	cd webapp/frontend && make
	cd webapp/frontend/dist && tar zcvf ../../../ansible/files/frontend.tar.gz .

webapp:
	tar zcvf ansible/files/webapp.tar.gz \
	--exclude webapp/frontend \
	webapp

payment:
	cd blackbox/payment && make && cp bin/payment_linux ../../ansible/roles/benchmark/files/payment

bench:
	cd bench && make && cp -av bin/bench_linux ../ansible/roles/benchmark/files/bench && cp -av bin/benchworker_linux ../ansible/roles/benchmark/files/benchworker

build:
	docker-compose -f webapp/docker-compose.yml -f webapp/docker-compose.php.yml build \
	--build-arg NEWRELIC_KEY \
	--build-arg NEWRELIC_APP_NAME

up:
	docker-compose -f webapp/docker-compose.yml -f webapp/docker-compose.php.yml up

down:
	docker-compose -f webapp/docker-compose.yml -f webapp/docker-compose.php.yml down

reset-db:
	docker rm webapp_mysql_1
	docker volume rm webapp_mysql
	
