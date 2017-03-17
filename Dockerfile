FROM alpine:3.5
MAINTAINER tac0x2a<tac@tac42.net>

RUN apk --update add ruby ruby-rdoc ruby-irb ruby-io-console openssl ca-certificates && rm -rf /var/cache/apk/*
RUN update-ca-certificates
RUN gem install bundler

RUN mkdir -p /work/volume && cd /work
VOLUME ["/work/volume"]

COPY Gemfile /work/Gemfile
RUN bundle config --global silence_root_warning 1
RUN cd /work && bundle install

COPY ddns-update.rb /work/ddns-update.rb
COPY run.sh         /work/run.sh

RUN  chmod +x /work/run.sh
CMD ["sh", "-c", "/work/run.sh"]
