FROM ruby:3.2.6-slim

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libmysqlclient-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' \
    && bundle install --jobs 4 --retry 3

COPY . .

# Precompile assets for production
RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
