FROM ruby:2.5.1

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/
RUN bundle install

ADD . /app
