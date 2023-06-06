ARG BASE_IMAGE="registry.gitlab.com/gitlab-org/build/cng/gitlab-ruby:master"

# build & test stage
FROM ruby as build
WORKDIR /app
# dependencies layers
COPY Makefile ./
COPY Gemfile* ./
RUN make init
# source code layers
COPY http_monitor.rb ./
COPY lib ./lib
COPY spec ./spec
COPY .rubocop.yml ./
RUN make test

# common stage
FROM ${BASE_IMAGE} as common
USER nobody
ENTRYPOINT [ "/entrypoint.sh" ]
WORKDIR /app
COPY entrypoint.sh /
COPY --from=build /app/http_monitor.rb ./
COPY --from=build /app/lib ./lib/

# final prd stage
FROM common as prd
ENV EXECUTOR=ruby

# final dev stage
FROM prd as dev
ENV EXECUTOR=rubymon
RUN gem install rubymon
