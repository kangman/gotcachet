

# Requirements

### AWS Account
- You will need an AWS account with a IAM user created with the AWS provided admin policy attached to it or a policy that gives you access to the required services within AWS. Credentials of the user will need to be set in your shell

```
$ export AWS_ACCESS_KEY_ID=YOUR-ACCESS-KEY
$ export AWS_SECRET_ACCESS_KEY=YOUR-SECRET-KEY
```
or in the `~/.aws/credentials` file

```
[test]
aws_access_key_id = YOUR-ACCESS-KEY
aws_secret_access_key = YOUR-SECRET-KEY
```

where you can invoke it with the `--profile` flag e.g. `$ eb list --profile test` or `$ aws s3 ls --profile test`

### Terraform
- Install terraform, if you are using OSX install the package manager [homebrew](http://brew.sh) and install terraform with `$ brew update && brew install terraform && brew cleanup` otherwise you can download a binary that suits your platform [here](https://www.terraform.io/downloads.html)

### PIP
- install pip and setuptools `$ pip install -U pip setuptools`
- Install the eb cli tool `$ pip install eb`

### PHP
- We will need to have PHP installed to generate the app key. We will install PHP v5.5 to aim for compatibility

`$ brew install php55 && brew cleanup`

### The code
- download a copy of this repo to your laptop
`$ git clone https://github.com/kangman/gotcachet.git`

- Setup your AWS credentials with a terraform.tfvars files within this git repo like so:

```
access_key = "YOUR ACCESS KEY"
secret_key = "YOUR SECRET KEY"
```
Once that is done let's start deploying our app

# Setup

1. go to the repo
`$ cd gotcachet`
2. run `$ terraform plan`
3. run `$ terraform apply` terraform will start the build
4. once build is complete run `$ terraform show > cachet-aws-info.txt` this will write out the computed AWS parts into a text file for later reference when deploying our app.
5. Next we will clone the cachet app in another directory
6. move out of the repo `cd ..`
7. `git clone https://github.com/cachethq/Cachet.git`
8. move into the cachet app repo `cd Cachet`
9. initialize with eb cli `eb init cachet-app`
10.
10. create your app `eb create cachet-app`

4. Create RDS cluster
5. Create RDS instances
5. Create Elastic Beanstalk
  1. setup .ebextensions
    1. envvars
    2. httpd.conf
    3. .env for cachet
    4. install apache, rewrite, php5_mod
    5.
6.
