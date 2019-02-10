# Just Add Code

> So why not take this approach (where possible) with infrastructure? […] Need to upgrade? No problem. Build a new, upgraded system and throw the old one away. New app revision? Same thing. Build a server (or image) with a new revision and throw away the old ones.
>
> — Chad Fowler, [Immutable Infrastructure and Disposable Components](http://chadfowler.com/blog/2013/06/23/immutable-deployments/)

# Recipe

…for a server that accepts deployments via `git push`

## Ingredients

- Docker powered mini-Heroku [Dokku](https://github.com/dokku/dokku)
- a Hetzner Cloud project

## Method

1. Make sure your public SSH key is in `~/.ssh/id_rsa.pub`
2. Make sure your API token for a Hetzner Cloud project is in `terraform.tfvars`:

  ```hcl
  hcloud_token = "<your_api_token>"
  ```

3. Create a server with dokku preinstalled:

  ```bash
  make HOSTNAME=my.host.example.tld
  ```

### What does this do?

- copies your public SSH key to the cloud project (so you can log in)
- creates a server "v1"
- installs dokku + dependencies on that server
- installs the [dokku-letsencrypt plugin](https://github.com/dokku/dokku-letsencrypt)

## Customizing

With a file named `cloud-init/secrets.sh`,
you can customize the creation of your dokku instance.
That file is being ignored by git, use it to pass sensitive information like
credentials for external services to your dokku instance.

Here's an example:

```bash
# secrets.sh
dokku apps:create node-js-sample
dokku config:set node-js-sample DATABASE_URL=zzz
```

Commands in `secrets.sh` will be executed as the very last step.
