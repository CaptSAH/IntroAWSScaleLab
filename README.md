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

While there are obviously many ways to approach this type of issue, for the sake of this lab exercise we're going to focus on using AWS CloudFormation along with the AWS CLI to show how such deployments can be easily handled.  In the real scenario, there would be a need for coordinating several functions, but again for simplicity we're just going to focus on providing storage space for each team using AWS S3 buckets.  You need to create two S3 buckets for each "team", one private and one public.  Then you need the ability to easily create or delete multiple sets of these buckets.

# Start Lab
Insert start lab instructions here

# Task 1:  Create a stack of S3 buckets using a CloudFormation template
In this task, you will create a simple stack using a provided Cloudformation template
Task 2:  Create the stack using the AWS CLI
Task 3:  Modify the template to incorporate "parameters" for each stack 
Task 4:  Create multiple unique but similar stacks using AWS CLI and a template
Suggested follow-up: Make conditional regions for each "stack" based on parameters
