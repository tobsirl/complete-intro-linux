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

### Run if first one succeeds

```bash
touch status.txt && date >> status.txt && uptime >> status.txt
cat status.txt
```

You can see it does all three commands right in a row. That's what the `&&` operator does. It runs from left to right (touch, date, then uptime). The `&&` operator will bail if any of those commands fails.

### Run if first one fails

`||` if one fails

```bash
false || echo hi # you'll see hi
false && echo hi # you won't see hi
```

### Always Run

To always run the second command

```bash
false ; true ; echo hey # you'll see hey
```

### Subcommands

Running commands within a command.

```bash
echo I think $(whoami) is a very cool user # I think ubuntu is very cool
```

`$()` allows you to run commands inside of another command. You can also use backticks ``

```bash
echo $(date +%x) – $(uptime) >> log.txt
```

## wget

wget works like cp but instead of copying a local file you're copying something off the net.

```bash
wget https://raw.githubusercontent.com/btholt/bash2048/master/bash2048.sh
chmod 700 bash2048.sh
. bash2048.sh
```

## curl

```bash
# run python server
python3 -m http.server 8000 --bind 0.0.0.0 

curl http://localhost:8000 # request to the server
```

### Output

curl can be used in a greater chain of commands.
`curl <url> > output.txt`

You can also use `-o <file name>` to redirect output to a file or just `-O` to redirect it to a file named by the same file name

### HTTP Verbs

`curl -I http://localhost:8000`
This will send a HEAD request instead of a GET request. HEAD requests just get the endpoint metadata and don't actually do a full request.

```bash
curl -X POST http://localhost:8000
curl -d "this is the body being sent with the HTTP request" http://localhost:8000
# both of these requests will fail because our static
# file server doesn't know what to do with POST requests
```

`-X` allows you to specify what verb you want to use.

```bash
curl -X PUT http://localhost:8000
curl -X PATCH http://localhost:8000
curl -X DELETE http://localhost:8000
curl -X OPTIONS http://localhost:8000
curl -X LOL_THIS_ISNT_REAL http://localhost:8000
```

### Cookies

```bash
curl -b "name=test" http://localhost:8000
```

### Redirects

```bash
curl http://bit.ly/linux-cli # won't redirect by default
curl -L http://bit.ly/linux-cli # -L tells curl to redirect
```

### Headers

```bash
curl -H "'accept-language: en-US" -H "Authorization: Bearer 12345" http://localhost:8000 # multiple headers
```

## Writing Your Own Scripts

 Bash allows you to put many commands into one file to create a program of programs which is called a shell script.

### Bashscript

```bash
mkdir -p ~/temp # -p mean don't error if it exists in this case, it does other things too
cd ~/temp
touch file{1..10}.txt
echo done
```

### Hashbang

To make the script executable you need to add `#!`, after hashbang you add the absolute path.
You can then execute this file with `./`

```bash
#! /bin/bash
```

### PATH

To run files from anywhere on your computer, you use a variable called `PATH`

### Variables

### Setting a Variable

```bash
#! /bin/bash

DESTINATION=~/temp
FILE_PREFIX=file

mkdir -p $DESTINATION
cd $DESTINATION
touch ${FILE_PREFIX}{1..10}.txt
echo done
```

### User Input

Read user input using `read`

```bash
#! /bin/bash

DESTINATION=~/temp
read -p "enter a file prefix: " FILE_PREFIX

mkdir -p $DESTINATION
cd $DESTINATION
touch ${FILE_PREFIX}{1..10}.txt
echo done
```

The `-p` flag allows us to prompt the user with a string, letting them know what we're expecting

### Arguments

Passing arguments into our program

```bash
#! /bin/bash

DESTINATION=$1
read -p "enter a file prefix: " FILE_PREFIX

mkdir -p $DESTINATION
cd $DESTINATION
touch ${FILE_PREFIX}{1..10}.txt
echo done
```

`$1` represents the first argument

## Conditionals

### if

```bash
#! /bin/bash

DESTINATION=$1
read -p "enter a file prefix: " FILE_PREFIX

if [ -z $DESTINATION ]; then
  echo "no path provided, defaulting to ~/temp"
  DESTINATION=~/temp
fi

mkdir -p $DESTINATION
cd $DESTINATION
touch ${FILE_PREFIX}{1..10}.txt
echo done
```

The `[]` are a special notation which actually translate to test commands. So our condition actually evaluates to `test -z $DESTINATION`.

```bash
test -z ""
echo $? # 0, this is true
test -z "lol"
echo $? # 1, this is false
```

There's a ton operators you can do with test. Here are some examples:

```bash
test 15 -eq 15 # 0
test brian = brian # 0
test brian != brian # 1
test 15 -gt 10 # 0 gt means greater than
test 15 -le 10 # 1 le means less than or equal to
test -e ~/some-file.txt # tests to see if a file exists
test -w ~/some-file.txt # tests to see if a file exists and you can write to it
```

### else and elif

```bash
if [ $1 -gt 10 ]; then
  echo "greater than 10"
elif [ $1 -lt 10 ]; then
  echo "less than 10"
else
  echo "equals 10"
fi
```

### Case Statements

```bash
case $1 in
  "smile")
    echo ":)"
    ;;
  "sad")
    echo ":("
    ;;
  "laugh")
    echo ":D"
    ;;
  "sword")
    echo "o()xxx[{::::::::::::::>"
    ;;
  "surprise")
    echo "O_O"
    ;;
  *)
    echo "I don't know that one yet!"
    ;;
esac
```

## Loops and Arrays

Fundamentals of any programming language

### Arrays and For Loops

```bash
#!/bin/bash

friends=(Kyle Marc Jem "Paul Tobin" Sarah) # define an array

echo My second friend is ${friends[1]} # access an element in the array

for friend in ${friends[*]} # access every element of the array
do # start
    echo friend: $friend
done # ebd

echo "I have ${#friends[*]} friends" # show the length
```

### While

```bash
# let "NUM_TO_GUESS = ${RANDOM} % 10 + 1"
NUM_TO_GUESS=$(( $RANDOM % 10 + 1 ))
GUESSED_NUM=0

echo "guess a number between 1 and 10"

while [ $NUM_TO_GUESS -ne $GUESSED_NUM ]
do
  read -p "your guess: " GUESSED_NUM
done

echo "you got it!"
```
