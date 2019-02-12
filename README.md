# Just Add Code

> So why not take this approach (where possible) with infrastructure? […] Need to upgrade? No problem. Build a new, upgraded system and throw the old one away. New app revision? Same thing. Build a server (or image) with a new revision and throw away the old ones.
>
> — Chad Fowler, [Immutable Infrastructure and Disposable Components](http://chadfowler.com/blog/2013/06/23/immutable-deployments/)

This builds a virtual server that accepts deployments via `git push`.
It runs the Docker-powered mini-Heroku [Dokku](https://github.com/dokku/dokku)
on a Hetzner Cloud project.

## Getting started

### Prerequisites

This is the software you need:

1. GNU Make
2. [Terraform](https://www.terraform.io/) 0.11.10 or newer

### Building the project

Once you have all required software, in the root directory of this project,
run this command and follow the instructions:

```bash
$ make HOSTNAME=my.host.example.tld
```

### What does this do?

- asks for your Hetzner Cloud API token and stores it in `terraform.tfvars`
- copies your public SSH key `~/.ssh/id_rsa.pub` to the cloud project
  (so you can log in)
- creates a server
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

## Removing everything

To remove all this, run:

```
$ terraform destroy
```
