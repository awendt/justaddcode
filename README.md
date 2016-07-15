# Just Add Code

> So why not take this approach (where possible) with infrastructure? […] Need to upgrade? No problem. Build a new, upgraded system and throw the old one away. New app revision? Same thing. Build a server (or image) with a new revision and throw away the old ones.
>
> — Chad Fowler, [Immutable Infrastructure and Disposable Components](http://chadfowler.com/blog/2013/06/23/immutable-deployments/)

# Recipe

…for a server that accepts deployments via `git push`

## Ingredients

- Docker powered mini-Heroku [Dokku](https://github.com/progrium/dokku)
- DigitalOcean

## Method

1. Make sure your public SSH key is in `~/.ssh/id_rsa.pub`
2. Make sure your API token for DigitalOcean is in `.env` for [dotenv](https://github.com/bkeepers/dotenv#usage):

  ```bash
  TOKEN=<your_api_token>
  ```

3. Create a droplet with dokku preinstalled:

  ```bash
  rake droplet:create HOSTNAME=my.host.example.tld
  ```

**Note:** For now, you have to take care of DNS yourself. (Pull requests welcome!)

## Customizing

With a file named `secrets.sh`, you can customize the creation of your droplet.
That file is being ignored by git, use it to pass sensible information like
credentials for external services to your droplet.

Here's an example:

```bash
# secrets.sh
dokku apps:create node-js-sample
dokku config:set node-js-sample DATABASE_URL=zzz
```

Commands in `secrets.sh` will be executed _after_ commands in `user_data.sh` are executed.
