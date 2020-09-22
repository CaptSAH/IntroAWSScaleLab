# Scaling Deployments using AWS CloudFormation and AWS CLI

## Overview
This lab walks you through a simple way to leverage the power of AWS CloudFormation and the AWS CLI to easily and rapidly scale AWS deployments.  You will start with a simple CloudFormation template, use the cli to rapidly implement the template, then explore ways to integrate some simple scripting methodologies with CloudFormation template parameters to scale out the deployment.

### Topics Covered
By the end of this lab, you will be able to:
- Create a stack of S3 buckets using a CloudFormation template
- Use the AWS CLI to rapidly replicate the CloudFormation stack
- Use template parameters to customize each stack for different but similar users
- Use the AWS CLI to create a series of customized CloudFormation stacks

#### Pre-requisites:
Prior to undertaking this lab, you should have a basic grasp of the following topics:
- YAML files (you can also use JSON with AWS CloudFormation, but the examples in this lab use YAML -- you can try [this site](https://www.json2yaml.com/convert-yaml-to-json) to convert YAML to JSON  but I cannot guarantee functionality)
- Powershell or similar scripting environment

You will also need to possess the following:
- An AWS account (freely available here: www.aws.amazon.com )
- The latest version of the AWS Cli installed on your system ( [Link](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) )

# Scenario
You are responsible for managing IT resources for a number of stakeholders.  One of them comes to you with the following request:  They want you to provide IT structure for a league of sports teams.  Each team will need its own private storage space, as well as a public space for hosting web content.  This league is constantly changing, and they need the ability to add or remove any number of teams from the infrastructure without disrupting the whole plan.  

While there are obviously many ways to approach this type of issue, for the sake of this lab exercise we're going to focus on using AWS CloudFormation along with the AWS CLI to show how such deployments can be easily handled.  In a real-life scenario, there would be a need for coordinating several functions, but again for simplicity we're just going to focus on providing storage space for each team using AWS S3 buckets.  **You need to create two S3 buckets for each "team", one private and one public.  Then you need the ability to easily create or delete multiple sets of these buckets.**


# Task 1:  Create a stack of S3 buckets using a CloudFormation template
In this task, you will create a simple stack using a provided Cloudformation template.  
1. Download the file S3TwobucketCloudFormationTemplate.yml associated with this repository to your computer

2. In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **CloudFormation**

3. Select the ![Create stack button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Create-stack.jpg)

4. Perform the following on the screen:
- Select ![Template is ready](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/TemplateReady.jpg)
- Select ![Upload a template file](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Uploadtemplate.jpg)
- Select ![Choose file](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/ChooseTemplateFile.jpg) and select the S3TwobucketCloudFormationTemplate.yml file
- Click ![Next](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Next.jpg)

5. Enter a valid stack name (i.e. "myfirstdoublestack") and click ![Next](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Next.jpg)  You may ignore the "Parameters" section.

6. Click ![Next](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Next.jpg) (you may have to scroll down) Again, ignore the other settings available here for now.

7. Click ![Create stack button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Create-stack.jpg) (again you may have to scroll down to find it)
AWS will then create the stack of resources defined in the template.  You should see an update screen similar to this below.  *Note that you may have to refresh the screen once the operations have completed. Also note that there are separate refresh buttons for the stack and the events*
![First Stack Completed Screen](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/FirstStackCompletedScreen.jpg)

# Task 2: Examine the Objects created and compare to the template
In this task, you will find the S3 buckets created with the stack and analyze the template to understand how they were created.
1. In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **S3**

2. You should see three buckets similar to this.  
![Initial Three Buckets](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/InitialThreeBuckets.jpg)
   To understand how these were created, let's examine the template.  You can either open the template file on your own computer, or you can navigate back to the CloudFormation screen and select your stack that was just created.  Once there, you can find the **Template** tab near the upper right portion of the screen.
   The key part of the template for now is this top section:
```yml
 Resources:
  S3BucketForWeb:
    Type: AWS::S3::Bucket
    Properties:
      AccessControl: PublicRead
      WebsiteConfiguration:
        IndexDocument: index.html
        ErrorDocument: error.html
  S3BucketInternal:
    Type: AWS::S3::Bucket
    Properties:
      AccessControl: Private
```
   Here you can see that the template specifies two S3 buckets, one "ForWeb" and one "Internal". Each bucket also has some attributes defined here, such as PublicRead access control for the Web bucket, and Private access control for the Internal.  These two buckets correspond to two of the three buckets you saw in the S3 console. Note that the "S3BucketForWeb" and "S3BucketInternal" labels here are just resource identifiers for the template.  They are not the actual "names" of the created S3 buckets. The bucket name is an attribute that this template left undefined, so the system automatically generated names for the buckets.  The third bucket created by the stack is not actually specified by the template.  It is a bucket automatically generated by the system, and you will find "templates" in its name.
   
   :muscle: *Challenge yourself* - In real-life, the rest of the template would be useful for the scenario described, where URLs would need to be generated to access the web-facing S3 bucket content. Can you find the resulting output on the stack status screen? Hint:  It's similar to finding the stack's associated template.
   
3. If you're not already there, navigate to your stack in the **AWS Management Console** 
   In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **CloudFormation**, then select your stack
   
4. Select ![Delete button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Deletebutton.jpg) to delete your stack
   Confirm by clicking ![Delete Stack Button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/DeleteStackbutton.jpg) 
   
5. Refresh the screen to confirm deletion.  Note that the event log is still available at the moment. 

6. In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **S3**

7. Examine the existing bucket. You should now only have one bucket, the one used to hold the stack template.
   The stack deleted the two buckets associated with it, but the system did not automatically delete the bucket used for the template.  Note that with CloudFormation stacks, you can easily create and delete multiple objects at one time.
   
8. Select the remaining bucket and click ![Delete button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/Deletebutton.jpg) to delete the remaining bucket. Confirm by entering the name of the bucket and clicking the Confirm button
   
9. Verify that no buckets related to the stack exist

# Task 3: Use the AWS CLI to create a stack
In this task, you will use the AWS CLI instead of the web interface to instigate stack creation.
1. Open a command prompt (or powershell, linux shell, etc.) on your local machine to use the AWS CLI

2. Run the command 
```
aws cloudformation create-stack --stack-name seconddoublestack --template-body <path to the S3TwobucketCloudFormationTemplate.yml file>
```
  A successful execution should return a StackID string to the screen.
3. Examine the contents of your S3 space in the **AWS Management Console**
   (Reminder if necessary: In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **S3**)
   
   You should now see only two buckets, corresponding to the "Internal" and "ForWeb" buckets specified by the template.  When using the AWS CLI, that extra templates bucket is not created.
   
   :muscle: *Challenge yourself* - Are there other differences in outcomes when using the CLI vs the web interface?  See if you can still find the same information about your created stack after having used the CLI
4. From your command prompt, run the command
```
aws cloudformation delete-stack --stack-name seconddoublestack
```
5. Verify that all S3 objects and the stack itself were deleted
   (Reminder if necessary: In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **S3**)
   
   All buckets associated with the stack should be gone.  Similarly, if you navigate to the CloudFormation service, there should be no trace of the "seconddoublestack" you just deleted.  
   
### Scenario Update
Remember that in our hypothetical scenario, you need to provision multiple objects for multiple teams.  We've now seen how with the AWS CloudFormation service using templates, you can create and delete multiple objects at one time.  Using the AWS CLI allowed you to reduce it to a single command rather than clicking though a user interface.  Now we just need a way to scale out what we've already shown can be done for one team.  You could just create a very large template file with all the details for all the teams, but that would be a headache to maintain, and it could be difficult to later remove or add single teams.  Another option would be to re-use the base template, naming the stacks so that each stack was readily identifiable with each team.  However, even then the underlying S3 buckets associated with each "team" would still have very similar random names, and be difficult to identify outside of their stacks. So let's combine the concept of repeatedly creating stacks with different names, but also use the parameters functionality of CloudFormation to repeatedly customize the execution.

# Task 4: Use parameters to customize template execution
In this task, you will add a parameter to the template that will allow customization at runtime.
1. Create a copy of the S3TwobucketCloudFormationTemplate.yml file with a different name.  *Use this new template file for the rest of the lab*.

2. Add the following to the top of the new template file (just under the "---" header at the very top):
```yml
Parameters:
  TeamNameParameter:
    Type: String
    Description: The name to designate for each bucketpair
    Default: team1
    AllowedPattern: '[a-z0-9]+'
 ```
   This indicates a parameter named "TeamNameParameter" that will need to be input at runtime.  We can then reference this parameter elsewhere in the template for object details that we want to change for each execution.  In this example, we will insert the parameter to specify the names of the S3 buckets we create so that they can be easily recognized as belonging to a particular team's stack.
   
3.  Add the following to the S3BucketForWeb "Properties" section:
```yml
      BucketName: 
        Fn::Join:
        - ''
        - - !Ref TeamNameParameter
          - '-labdemowebbucket'
```
   The "!Ref" tells the system that rather than using a set string value, it should reference the value of the specified parameter.  The "Fn::Join:" function concatenates the value of the TeamNameParameter with "-labdemowebbucket".  For example, if at runtime I enter the value of the TeamNameParameter as "wildcats", the resulting bucket name should be "wildcats-labdemowebbucket".
   
4. Add the following to the S3BucketInternal "Properties" section and save the file:
```yml
      BucketName: 
        Fn::Join:
        - ''
        - - !Ref TeamNameParameter
          - '-labdemointernalbucket'
```
   Just as before, for the Internal bucket we're going to specify a name based upon the parameter to be given at runtime.  Now both of the S3 buckets created by this template should have custom names determined at runtime.
   
   :point_right:If you wish to use it, a version of the template already updated as described in the previous steps is available here in this repository as S3TwobucketwithParameters.yml
   
5. From your command prompt, run the command
```
aws cloudformation create-stack --stack-name wildcats --template-body <path to new template yml file> --parameters ParameterKey=TeamNameParameter,ParameterValue=wildcats
```

6. Examine the contents of your S3 space in the **AWS Management Console**
   (Reminder if necessary: In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **S3**)
   
   You should see something very like this:
   ![Custom Wildcat Buckets](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/CustomWildcatBuckets.jpg) 
   Now not only is your stack named wildcats, but by using parameters you have modified the details of the stack resources to match the name entered at runtime.
   
7. From your command prompt, run the command
```
aws cloudformation delete-stack --stack-name wildcats
```

   :muscle: *Challenge yourself* - This task used only the CLI, but you can use the web interface and manually upload the exact same template with parameters.  Find where the TeamNameParameter would be specified in the web interface.

# Task 5: Use shell variables to execute multiple stacks with one call
In this task, you will put it all together by creating multiple custom stacks with a single executable.
1. Create a shell script in the language of your choice to incorporate the aws cloudformation create-stack call into a loop that could be repeated for a series of team names - lions, tigers, bears, and turtles

   Here is a powershell example:
```powershell
$Teamlist = "lions","tigers","bears","turtles"
foreach ($team in $Teamlist)
{
aws cloudformation create-stack --stack-name $team"labdemostack" --template-body file://S3TwobucketwithParameters.yml --parameters ParameterKey=TeamNameParameter,ParameterValue=$team
}
```

2. Execute the shell script you just created

3. In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **CloudFormation**

4. Verify that you have four stacks, one for each "team" in your script.
   You can also select various stacks and confirm that each stack's associated S3 resources have matching team names for easy identification.
   
5. Examine the contents of your S3 space in the **AWS Management Console**
   Reminder if necessary: In the **AWS Management Console**, on the ![Services button](https://github.com/CaptSAH/IntroAWSScaleLab/blob/master/Images/AWS-Services.jpg) menu, select **S3**
   
   Here there are now eight buckets, two for each team, created by a single script

# Conclusion
:thumbsup: Congratulations! You have now successfully:
- Created a stack of S3 buckets using a CloudFormation template
- Used the AWS CLI to rapidly replicate the CloudFormation stack
- Used template parameters to customize each stack for different but similar users
- Used the AWS CLI to create a series of customized CloudFormation stacks

In terms of our scenario, you now possess the capability to rapidly deploy as many sets of resources as there are teams in the hypothetical league, and you can remove or add one or more at a time with a simple command or shell script. You can now respond to the stakeholder with confidence.  

For further exercise, you might consider adding more parameters, perhaps one to host each team's buckets in their specific region.  Eventually you can expand upon this to incorporate additional AWS services into your stacks that would normally be included in such as deployment, such as EC2 instances.

## Additional Resources
- [Sample Cloud Formation Templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-sample-templates.html)
- [AWS Documentation](https://docs.aws.amazon.com/index.html)
  

