# docker-ieserver-updater

This Docker image updates [ieServer.Net](http://www.ieserver.net/) DDNS registration.

# Usage
Run with environment variables `USERNAME`, `DOMAIN`, `PASSWORD`, and update schadule as `CRON_SCHEDULE` witten cron format (see "man 5 crontab" in your terminal).

## Example
Update domain `host.domain.jp` each 5 min.

### docker-compose
Edit `docker-compose.yml`

```yml
version: '2'
services:
  ieserver-updater:
    restart: always
    image: tac0x2a/ieserver-updater
    container_name: ieserver-updater
    volumes:
      - ./volume:/work/volume
    environment:
      USERNAME: host
      DOMAIN: domain.jp
      PASSWORD: <password>
      CRON_SCHEDULE: "*/5 * * * *"
```

And up.
```sh
$ docker-compose up -d
```

### docker run

```sh
$ docker run -d -v /your/host/dir:/work/volume -e USERNAME=host -e DOMAIN=domain.jp -e PASSWORD=<Password> -e CRON_SCHEDULE="*/5 * * * *" tac0x2a/docker-ieserver-updater
```

## Contributing

1. Fork it ( https://github.com/tac0x2a/docker-ieserver-update/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
