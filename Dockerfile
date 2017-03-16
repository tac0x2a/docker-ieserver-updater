FROM alpine:3.5
MAINTAINER tac0x2a<tac@tac42.net>


RUN apk --update add ruby ruby-rdoc ruby-irb ruby-io-console openssl ca-certificates && rm -rf /var/cache/apk/*
RUN update-ca-certificates

RUN gem install rufus-scheduler tzinfo-data

# RUN  gem install bundler
# RUN bundle install

RUN mkdir /work && cd /work

COPY ddns-update.rb /work/ddns-update.rb
COPY run.sh /work/run.sh

RUN mkdir volume
VOLUME ["/work/volume"]

RUN  chmod +x /work/run.sh
CMD ["sh", "-c", "/work/run.sh"]
#CMD ["sh", "-c", "ruby", "/work/ddns-update.rb", "-u", "$USERNAME", "-d", "$DOMAIN", "-p", "$PASSWORD", "-c", "/work/volume/current_ip", "-l", "/work/volume/logfile.log"]

# CMD ["ruby", "/work/ddns-update.rb", "-u", "$USERNAME", "-d", "$DOMAIN", "-p", "$PASSWORD", "-c", "/work/vol/current_ip", "-s", "$CRON_SCHEDULE"]
#CMD ["echo", "$$USERNAME"]
#CMD sh -l -c "ruby -v"

# ruby /work/ddns-update.rb -s $CRON_SCHEDULE -u $USERNAME -d $DOMAIN -p $PASSWORD -c /work/volume/current_ip -l /work/volume/logfile.log
