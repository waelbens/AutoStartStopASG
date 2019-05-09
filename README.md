# AutoStartStopASG
Start and Stop of ASG instances using Lambda and CloudWatch Events

Invoke Lambda to start/stop site instances:
aws lambda invoke --function-name asg-lambda-stop-start --payload '{"site": "site_name", "action": "action_name"}' output
