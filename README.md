# Scaling Deployments using AWS CloudFormation and AWS CLI

## Overview
This lab walks you through a simple way to leverage the power of AWS CloudFormation and the AWS CLI to easily and rapidly scale AWS deployments.  You will start with a simple CloudFormation template, use the cli to rapidly implement the template, then explore ways to integrate some simple scripting methodologies with CloudFormation template parameters to scale out the deployment.

### Topics Covered
By the end of this lab, you will be able to:
- Create a stack of S3 buckets using a CloudFormation template
- Use the AWS CLI to rapidly replicate the CloudFormation stack
- Use template parameters to customize each stack for different but similar users
- Use the AWS CLI to create a series of customized CloudFormation stacks

#### Technical Knowledge Pre-requisites:
Prior to undertaking this lab, you should have a basic grasp of the following topics:
- JSON/YAML files
- AWS S3 buckets
- Powershell or similar scripting environment

# Scenario
You are responsible for managing IT resources for a number of stakeholders.  One of them comes to you with the following request:  They want you to provide IT structure for a league of sports teams.  Each team will need its own private storage space, as well as a public space for hosting web content.  This league is constantly changing, and they need the ability to add or remove any number of teams from the infrastructure without disrupting the whole plan.  

While there are obviously many ways to approach this type of issue, for the sake of this lab exercise we're going to focus on using AWS CloudFormation along with the AWS CLI to show how such deployments can be easily handled.  In the real scenario, there would be a need for coordinating several functions, but again for simplicity we're just going to focus on providing storage space for each team using AWS S3 buckets.  **You need to create two S3 buckets for each "team", one private and one public.  Then you need the ability to easily create or delete multiple sets of these buckets.**

# Start Lab
Insert start lab instructions here

# Task 1:  Create a stack of S3 buckets using a CloudFormation template
In this task, you will create a simple stack using a provided Cloudformation template.  
1. Download the file S3TwobucketCloudFormationTemplate.yml associated with this repository to your computer
2. In the **AWS Management Console**, on the ![Services button]() menu, select **CloudFormation**
3. Select the ![Create stack button]()
4. Perform the following on the screen:
- Select ![Template is ready]()
- Select ![Upload a template file]()
- Select ![Choose file]() and select the S3TwobucketCloudFormationTemplate.yml file
- Click ![Next]()
5. Enter a valid stack name (i.e. "myfirstdoublestack") and click ![Next]()  You may ignore the "Parameters" section.
6. Click ![Next]() (you may have to scroll down) Again, ignore the other settings available here for now.
7. Click ![Create stack button]()
AWS will then create the stack of resources defined in the template.  You should see an update screen similar to this below.  Note that you may have to refresh the screen once the operations have completed.
![First Stack Completed Screen]()

# Task 2: Examine the Objects created and compare to the template
In this task, you will find the S3 buckets created with the stack and analyze the template to understand how they were created.
1. In the **AWS Management Console**, on the ![Services button]() menu, select **S3**
2. You should see three buckets similar to this.  
![Initial Three Buckets]()
   To understand how these were created, let's examine the template.  You can either open the template file on your own computer, or you can navigate back to the CloudFormation screen and select your stack that was just created.  Once there, you can find the **Template** tab near the upper right portion of the screen.
   


   Note:  AWS CloudFormation also accepts JSON templates.  If you prefer JSON, you can use this site to convert YAML to JSON https://www.json2yaml.com/convert-yaml-to-json 
  There are hundreds of sample templates to examine here: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-sample-templates.html
  
Task 2:  Create the stack using the AWS CLI
Task 3:  Modify the template to incorporate "parameters" for each stack 
Task 4:  Create multiple unique but similar stacks using AWS CLI and a template
Suggested follow-up: Make conditional regions for each "stack" based on parameters
