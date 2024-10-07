# AWS Connect

`aws_connect` allows to easily connect your terminal to the AWS Tasks remote consoles of your cluster, by simply using their names

## Pre-Requisites

You need the [AWS Client](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and the [session manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) installed.

Get you your `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN` variables from AWS Access Portal and copy/paste them to your terminal.
Or have them configured into your `~/.aws/credentials` file

## Basic Usage:

```
Usage: aws_connect.sh <service_name>
```

### Examples

```shell
bin/aws_connect.sh list

 Cluster: aws-cluster
 
 [Services]
 database
 webapp
 worker

bin/aws_connect.sh webapp
