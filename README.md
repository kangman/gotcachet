

# Requirements

- You will need an AWS account with a IAM user created with the admin policy attached to or a policy that gives you access to the required services within AWS. Credentials of the user will need to be set in your shell

```
export AWS_ACCESS_KEY_ID=YOUR-ACCESS-KEY
export AWS_SECRET_ACCESS_KEY=YOUR-SECRET-KEY
```
or in the `~/.aws/credentials` file

```
[test]
aws_access_key_id = YOUR-ACCESS-KEY
aws_secret_access_key = YOUR-SECRET-KEY
```

where you can invoke it with the `--profile` flag e.g. `eb list --profile test` or `aws s3 ls --profile test`


- Install terraform, if you are using OSX install the package manager [homebrew](http://brew.sh) and install terraform with `brew update && brew install terraform` otherwise you can download a binary that suits your platform [here](https://www.terraform.io/downloads.html)

- You should also have the python package manager `pip` you can install it with `easy_install pip`

- Install the eb cli tool `pip install eb`

- download a copy of this repo to your laptop
`git clone https://github.com/kangman/gotcachet.git`

- Setup your AWS credentials with a terraform.tfvars files within this git repo like so:

```
access_key = "YOUR ACCESS KEY"
secret_key = "YOUR SECRET KEY"
```
Once that is done let's start building our app

# Setup

1. go to the repo`cd gotcachet`
2. run `terraform plan`
3. run `terraform apply`
4. run `terraform show > cachet-aws-info.txt`
   we'll refer to this output for our aws outputs later when deploying the app
1. Create the vpc where everything will live
2. Create the subnets in different availability zones
  1. Create two subnets for the web nodes
  2. Create two subnets for the db nodes
  3. Create a subnet for ELB
3. Create security groups
  1. ELB ingress: 0.0.0.0/0 port 80/443 egress: web-secgroup
  2. RDS ingress: web-secgroup port 3306 egress:
  3. Web ingress: db-secgroup egress: 0.0.0.0/0 port 80/443
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
