# complete-intro-linux

Frontend Master Course on Linux commands

## Environments

```bash
# print all environment variables
printenv

# print out the name in $USER
echo hello my name is $USER

USER=paul echo hello my name is $USER # hello my name is brian
echo hello my name is $USER # hello my name is ubuntu
```

## Per Session
```bash
echo $GREETING # nothing
GREETING=hello
echo $GREETING # hello
```

## Permanent
`/etc/environment` change for everyone, not recommended

`/etc/profile` `/etc/bashrc` `/etc/zshrc` system-wide

## .bashrc and .bash_profile
`.bash_profile` is only run on login shells
`.bashrc` is run on every nonlogin shell

```bash
# add to .bash_profile to ignore and always run .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

```bash
# reload file
source ~/.bashrc
```

## Processes
```bash
ps # list all running processes

sleep 10 & # & means run in the background
ps
```