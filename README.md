# IntroAWSScaleLab
A lab exercise designed to introduce the functions making AWS services scale in size
Objectives (What you will learn) 
Topics covered
By the end of this lab, you will be able to:
Create a stack of S3 buckets using a CloudFormation template
Use the AWS CLI to rapidly replicate the CloudFormation stack
Use template parameters to customize each stack for different users
Use the AWS CLI to create a series of customized CloudFormation stacks

Technical Knowledge Pre-requisites:
Familiarity with JSON or YAML files
Basic understanding of Amazon S3 bucket functionality
Basic Powershell (or other) functionality

Scenario:  Service provider/consultant wants to rapidly allocate provide storage to a group of similar but distinct clients
Task 1:  Create a stack of S3 buckets using a CloudFormation template
	Deletion policy example??
Task 2:  Create the stack using the AWS CLI
Task 3:  Modify the template to incorporate "parameters" for each stack 
Task 4:  Create multiple unique but similar stacks using AWS CLI and a template
Suggested follow-up: Make conditional regions for each "stack" based on parameters
