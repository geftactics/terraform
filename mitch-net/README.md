# docker-compose on EC2

### Prerequisites
You will need to ensure that you have installed `terraform` and `make`.

macOS users should use [brew](https://brew.sh): `brew install terraform make`.

You'll need to generate an [AWS access key and secret key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey), then save these in the `~/.aws/credentials` file:

```
[profile-name]
aws_access_key_id = XXXXXXXXXX
aws_secret_access_key = YYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
```

If it's your first time running, you will need to prepare you environment by running `ENV=dev gmake prep`.


### Build infrastructure
```
git pull
ENV=dev gmake apply
```

### Destroy infrastructure
```
git pull
ENV=dev gmake destroy
```
