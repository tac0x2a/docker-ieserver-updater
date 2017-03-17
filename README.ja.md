# docker-ieserver-updater

このDockerイメージは[ieServer.Net](http://www.ieserver.net/) の DDNS登録を更新します．

# 使い方
環境変数として，`USERNAME`, `DOMAIN`, `PASSWORD` と，cronのフォーマットで更新スケジュールを記載した `CRON_SCHEDULE` を与えます．
cronフォーマットについては，"man 5 crontab" を参照．

## 例
ドメイン `host.domain.jp` を 5分おきに更新する．

### docker-compose を使う場合
`docker-compose.yml` を以下のように編集します

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

その後，以下コマンドで起動します．

```sh
$ docker-compose up -d
```

### docker run を使う場合

```sh
$ docker run -d -v /your/host/dir:/work/volume -e USERNAME=host -e DOMAIN=domain.jp -e PASSWORD=<Password> -e CRON_SCHEDULE="*/5 * * * *" tac0x2a/docker-ieserver-updater
```

## Contributing

1. Fork it ( https://github.com/tac0x2a/docker-ieserver-update/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
