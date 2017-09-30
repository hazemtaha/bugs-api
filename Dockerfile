FROM ruby:2.3.5

RUN apt-get update && apt-get install -y build-essential
RUN apt-get -y install mysql-client

ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV BUNDLE_PATH /gems

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . ./
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
