# Use the official Ruby image from the Docker Hub
FROM ruby:3.2.0

# Set an environment variable to store the app's path
ENV RAILS_ROOT /var/www/rails_todolist
RUN mkdir -p $RAILS_ROOT

# Set the working directory
WORKDIR $RAILS_ROOT

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the rest of the application code into the image
COPY . .

RUN bundle exec rake assets:precompile
RUN chmod +x bin/*
RUN bin/rails db:migrate RAILS_ENV=development

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
