FROM ruby:2.7.6-slim

WORKDIR /app

COPY Gemfile* ./

RUN bundle install --jobs $(nproc) --retry 3 && \
    bundle clean --force

COPY . /app

CMD ["/app/bin/run_app"]
