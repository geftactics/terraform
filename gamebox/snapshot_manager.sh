#!/bin/bash

NAME_PREFIX=gamebox
AWS_REGION=eu-west-2

OLD_AMI=$(aws ec2 describe-images --region ${AWS_REGION} --owners self --filters Name=name,Values=${NAME_PREFIX}* --query Images[*].[ImageId] --output text)
OLD_SNAP=$(aws ec2 describe-snapshots --region ${AWS_REGION} --owner-ids self --filters Name=description,Values=*${OLD_AMI}* --query Snapshots[*].[SnapshotId] --output text)
INSTANCE=$(aws ec2 describe-instances --region ${AWS_REGION} --filters "Name=tag:Name,Values=${NAME_PREFIX}" --query "Reservations[*].Instances[*].[InstanceId]" "Name=instance-state-name,Values=running" --output text)

[ -z "$OLD_AMI" ] && echo "ERROR: Could not find old AMI to remove!" && exit 1
[ -z "$INSTANCE" ] && echo "ERROR: Could not find instance to create image from!" && exit 1

echo "De-registering ${OLD_AMI}..."
aws ec2 deregister-image --region ${AWS_REGION} --image-id ${OLD_AMI} --output text

echo "Removing ${OLD_SNAP}..."
aws ec2 delete-snapshot --region ${AWS_REGION} --snapshot-id ${OLD_SNAP} --output text

echo "Creating image of ${INSTANCE}..."
NEW_SNAP=$(aws ec2 create-image --region ${AWS_REGION} --description ${NAME_PREFIX} --name ${NAME_PREFIX} --instance-id ${INSTANCE} --output text)

echo "Waiting for ${NEW_SNAP}..."
aws ec2 wait image-available --region ${AWS_REGION} --image-ids ${NEW_SNAP}