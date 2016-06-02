

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
4. once build is complete run `$ terraform output` this will show you all the AWS computed names which we will reference later.
5. Next we will clone the cachet app in another directory
6. move out of the repo `cd ..`
7. `git clone https://github.com/cachethq/Cachet.git`
8. move into the cachet app repo `cd Cachet`
9. initialize with eb cli `eb init cachet-app`
10.
10. create your app `eb create cachet-app --vpc --database --profile PROFILE`
  1. plug in your values for VPC, subnets and security groups.
11. Open browser to computed elb dns name.

# Issues

## environmental variables for elastic beanstalk

Elastic beanstalk has a feature that allows you to dynamically update your server
environmental variables via the eb cli / aws cli or the elastic beanstalk console

I was looking to leverage this feature for the Cachet but the `.env` is not a php
file rather it is a a simple text file.  I was looking to pull in the envvars with
the `getenv` method e.g. `$DBUSER = getenv ( 'APP_DBUSER' );` but was not sure how
to go about that using PHP.

### Work around

I would go with using something like packer or build up an AMI that would contain
the app, .env, composer.json and package.json modules installed with the app.
I would deploy this ami within the auto scaling group behind the elastic load
balancer.  Also if I wanted to terminate SSL at the node rather than the load
balancer I would either setup a let's encrypt client or self signed cert there.  
One issue with this approach would be to give up on all the batteries included with
deploying an app via elastic beanstalk which stands up a services such as cloudwatch
autoscaling group, elb,

## ELB health issue

I tried to deploy the app and db entirely with elastic beanstalk only using the created
VPC, subnets, and security groups.  This could be done with `eb create testapp --vpc --database --profile mine`
Unfortunately the enhanced health features of the latest PHP platform of requires
more access to and from the ec2 nodes so initially the health of my application
was falsely coming up as severe when in fact I can hit the web node directly
and the app was working fine.

### Work around

I was looking into the security group access between the ELB sg and the EC2 but
ran out of time.  Perhaps it would have easier to reason about if I build via
terraform each component as I know most of the moving pieces of elastic beanstalk
but apparently not this part.

## SSL termination at ELB

AWS offers the Certificate manager which gives free ssl certificates for cloudfront
and elastic load balancer services.  This only applies it seems if you own a vanity
domain that you can alias to your elb URL and verify that domain not the AWS generated
ELB domain name.

### Work around

Using the IAM portion of the aws cli tool I can generate a self signed cert via
openssl and import that with the cli call.  Then when I build an elb I can add the
443 listener and use the uploaded cert.  

## Cachet file permissions

Installing the app, I get 500 errors, the `/var/log/httpd/errors.log` shows an
issue file permissions `/var/app/current/bootstrap/../vendor/autoload.php` and
`failed to open stream: No such file or directory in /var/app/current/bootstrap/autoload.php`

### Work around

Cachet's [documentation][https://docs.cachethq.io/docs/installing-cachet] gives
a clue on key folders within the app which are `storage`, `bootstrap/cache` and
`vendor` these should be accessible by the webapp apache process.  I enabled by
hand but next steps would be either use the user data option to run these
commands when building the ami as mentioned previously, use the remote provisioner
from terraform or use the elb ebextensions commands directives.  
Basically something that will kick of a script within the web node itself to
setup the app correclty. I would need test them out on how to implement that exactly.

## apache conf

cachet's documentation shows inline comments on the conf file but apache does
not allow this and gives an error.

### Work around
Errors that httpd was throwing wasn't exact but removing the comments or moving
them to a separate line resolve the error.

# Conclusion
