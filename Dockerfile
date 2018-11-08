FROM ruby:latest
COPY server.rb .
COPY facts.txt .
EXPOSE 2345
ENTRYPOINT ["ruby", "server.rb"]