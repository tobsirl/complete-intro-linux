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

sleep 100 &
ps # find the sleep pid
kill -s SIGKILL <the pid from above>
ps # notice the process has been killed

ps aux # shows every process running

ps aux | grep ps
```

## Foreground and Background

```bash
sleep 100
# hit CTRL + Z
jobs # notice process is stopped
bg 1 # it's the first and only item in the list, the number refers to that
jobs # notice process is running
fg 1 # reattch to the process
```

## Exit Codes

A program that successfully runs and exits by itself will have an exit code of 0.

```bash
date # show current date, runs successfully
echo $? # $? corresponds to the last exit code, in this case 0
yes # hit CTRL+C to stop it
echo $? # you stopped it so it exited with a non-zero code, 130
```

### Common exit codes

- 0: means it was successful. Anything other than 0 means it failed
- 1: a good general catch-all "there was an error"
- 2: a bash internal error, meaning you or the program tried to use bash in an incorrect way
- 126: Either you don't have permission or the file isn't executable
- 127: Command not found
- 128: The exit command itself had a problem, usually that you provided a non-integer exit code to it
- 130: You ended the program with CTRL+C
- 137: You ended the program with SIGKILL
- 255: Out-of-bounds, you tried to exit with a code larger than 255
