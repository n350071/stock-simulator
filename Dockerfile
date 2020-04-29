FROM ruby:2.7.1

# railsコンソール中で日本語入力するための設定
ENV LANG C.UTF-8

# prepare installing yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

## install nodejs yarn
## install vim to modify config/credentials.yml.enc
RUN apt-get update -qq \
  && apt-get install -y nodejs \
  && apt-get install yarn -y \
  && apt-get install apt-file -y && apt-file update && apt-get install vim -y \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /stock
WORKDIR /stock
COPY Gemfile /stock/Gemfile
COPY Gemfile.lock /stock/Gemfile.lock
RUN bundle install
COPY . /stock

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
