# http-monitor

Simple http response time monitoring ruby script packaged into single purpose container image.

## Using with make

```bash
# complete cycle: build image, run container, remove image
% make build run clean

# run container passing all possible cli arguments to override
% make run URL=https://google.com TIME=10 SLEEP_INTERVAL=1

# run tests
% make test
```

## Using with docker compose

```bash
# build image from Dockerfile and run container from it
% docker compose --profile prd up

# build image from Dockerfile-dev and run dev container from it
% docker compose --profile dev up
```
