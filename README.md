# dokku-nginx-webdav

WebDAV (SabreDAV + nginx with auth) Docker image made to be run on
[Dokku](https://dokku.com/).


## Deploying

Get a shell in yout Dokku server and run:

```shell
# Set these variables
APP=my-app-name
APP_DOMAIN=my-app.example.com
USERNAME=my-user
PASSWORD=my-secret

# Create app, mount storage and set user/pass
dokku apps:create $APP
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP:/var/webdav/public
dokku config:set --no-restart $APP USERNAME=$USERNAME
dokku config:set --no-restart $APP PASSWORD=$PASSWORD
dokku domains:add $APP $APP_DOMAIN
```

Now, deploy your app from your local machine:

```shell
git clone https://github.com/turicas/dokku-nginx-webdav.git
cd dokku-nginx-webdav
git remote add dokku dokku@<my-dokku-host>:<my-app-name>
git push dokku master
```

Finally, back on server:

```shell
dokku letsencrypt:enable $APP
```

> Note: before enabling Let's Encrypt on this app you may need to run
> `dokku config:set DOKKU_LETSENCRYPT_EMAIL=you@example.com`.

Now access `davs://my-app.example.com/` using `my-user` as username and
`my-secret` as password.
