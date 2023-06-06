.PHONY: *

IMAGE_NAME=http-monitor:latest

build:
	$(info ## Building container image $(IMAGE_NAME))
	@docker build -t $(IMAGE_NAME) --target prd .

run: URL?=https://google.com
run: TIME?=10
run: SLEEP_INTERVAL?=5
run:
	$(info ## Running container from $(IMAGE_NAME))
	@docker run --rm -it $(IMAGE_NAME) "$(URL)" "$(TIME)" "$(SLEEP_INTERVAL)"

clean:
	$(info ## Removing container image)
	@docker rmi $(IMAGE_NAME)

init:
	$(info installing dependencies)
	bundle install

lint:
	$(info ## Linting source code)
	bundle exec rubocop
	bundle exec reek

test:
	$(MAKE) lint
	$(info ## Running tests)
	bundle exec rspec
