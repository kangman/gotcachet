

# Action PLan

## - Select a Cloud compute provider:
 - AWS
   - RDS Aurora service - for multi-zone availability
     - will deploy an aurora cluster with multiple availability zones to have high availability
   - Elastic Beanstalk - which provides a platform to deploy the web end portion of the application.  In this case the [cachet](https://cachethq.io) status page application.  It comes with
     - monitoring (cloudwatch)
     - scaling (auto scaling groups for the web nodes) when a load threshold is hit then the ASG(auto scaling group) will add additional web nodes up to the limit defined in the Elastic Beanstalk Environment. Similarly when load is low nodes can be scaled down to reduce costs.
     - elastic load balancing ( to spread the requests )
   - All of these parts will be deployed within an AWS VPC that will give us a logical separation of our infrastructure from other environments/applications
   - security groups will split the access to parts of the web stack.  
     - RDS will be part of the data security group which will only be allowed to communicate with the web security group on port 3306.
     - Web security group will be open to incoming requests from http(80), https(443) and ssh(22 source locked to operator's IP.
     - Elastic Load Balancer security group will open both 80 and 443.  
     - SSL certificates can be managed with AWS Certificate manager and set on the Elastic load balancer.


## - Select a provisioning tool:
   - In this case I am using terraform to setup the environment
     - Reasons:
       - Allows for separation of concerns when creating your code to build up your infrastructure.
         - Each snippet of code can be for a particular bit of your infrastructure
       - Interpolation syntax to allow to call up dynamic data into your scripts so that underlying infrastructure outputs can be used for higher order components to be built on top.

## - Additional Points (Optional)
  - Validating the servers are running correctly
    - Serverspec or some other kind of testing tool

## Requirements

- Install terraform, if you are using OSX install [homebrew](http://brew.sh) and install `brew update && brew install terraform` otherwise you can grab a binary that suits your platform [here](https://www.terraform.io/downloads.html)
