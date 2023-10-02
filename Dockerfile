FROM ruby:3.0
WORKDIR /app
COPY Gemfile .
RUN "bundle"
COPY . .
CMD ["rake"]