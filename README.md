# Tidy Transfer
### Transfer files gracefully.

## Install

### Clone the repository

```shell
git clone git@github.com:ParthThakur/Tidy-Transfer.git
cd Tidy-Transfer
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.1.2`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.1.2
```

Or follow the instructions [here](https://www.ruby-lang.org/en/documentation/installation/) to get Ruby version 3.
```
https://www.ruby-lang.org/en/documentation/installation/
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Initialize the database

```shell
rails db:create db:migrate
```

## Serve

```shell
rails s
```