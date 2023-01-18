# AWS Vprofile App Deployment  

## Technologies 

* Web Application
  * Spring MVC
  * Spring Security
  * Spring Data JPA
  * JSP
* Maven
* MySQL
* RabbitMQ
* Memcache

## Application Architecture 

```
        ┌─────┐
        │nginx│
        └─────┘
          |↑
          ||   _______┌─────┐
          ||  //-----→│mysql│←-----
          ↓|  ↓|      └─────┘----||
    ┌─────────────┐     |↑       ||
    │tomcat_server│     ||       ||
    └─────────────┘     ↓|       ||
          |↑        ┌────────┐   ||
          ||        │memcache│   ||
          ||        └────────┘   ||
          ↓|         ↑|          ||
      ┌────────┐     //          ||
      │rabbitmq│____//           ||
      └────────┘←----            //
          |↑                    //
          ||___________________//
          ----------------------
```


## What we are going to use 

* __EC2 Instances__ : VM for Tomcat, RabbitMQ, Memcache and MySQL.   
* __ELB (Load Balancer)__ : (Replacing nginx with ELB)    
* __Autoscaling :__ Autoscale Tomcat server.  
* __S3/EFS Storage :__  Shared storage.   
* __Amaon Certifcate Manager :__ Amazon certificate manager for SSL on load balancer.    
* __Route 53 :__ Assign DNS to the load Balancer.      


## AWS Deployment Architecure    


```   
                         Security Group        
  Security Group    |---------------------|     ┌───────────┐
   |---------|      |  Autoscaling Group  |←----│ S3 Bucket │
   | ┌─────┐ |      | ┌─────────────────┐ |     └───────────┘
   | │ ELB │ |----→ | │ Tomcat Instance │ |     ┌───────────┐
   | └─────┘ |      | └─────────────────┘ |←----│Route53 DNS│
   |---------|      |---------------------|     └───────────┘
                             |
                             |
                             ↓
     |-------------------------------------|
     |           ---------→┌──────────────┐|
     |           ↓         │mysql instance│|
     | ┌─────────────────┐ └──────────────┘|
     | │rabbitmq instance│       ↑         |
     | └─────────────────┘       |         |
     |          ↑                ↓         |
     |          |     ┌──────────────────┐ | 
     |          |----→│memcache instrance│ | 
     |                └──────────────────┘ |
     |-------------------------------------|
                 Security Group
```   

## Steps To Perform    

* Create 3 Security Groups   
* Instanciate 4 ec2 vms  
* Generate SSL Certicate and Validate the Domain  
* Create Private Hosted Zone for thress backend servers  
* Create iam role with s3 access   
* Build the artifact and deploy it on the application server   
* Setup Load Balancer and redirect the public load balancer dns to custom domain   
* Setup Autoscaling group for application server  
