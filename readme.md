# Basics of Linux Terminal and Bash

## Why use terminal and Bash?

Linux terminal is one of the primary ways to interact with the Linux system. This is because it enables commanding the system in an excellent way -- precise, repeatable, and explainable. 

Particularly in fields such as bioinformatics, robotics you will spend most of the time in the console (terminal), as most of the tools available are accessible from there.

The name terminal (or console) means that you access the system through typing commands and receiving input as a text, usually displayed on the screen. Compared to using a GUI - a Windows-like interaction here instead of gestures and images, you use words and symbols. 

The terminal itself is just a name for a type of access, not neccessarely a functions that would be available, (for example you can have a terminal access to a [super-small microcontroler](https://docs.micropython.org/en/latest/esp8266/tutorial/repl.html)).
Usually, what we want is a Shell -- a program that takes commands written in the terminal and passes them to the system.

The most popular shell is Bash, and we will be using it throughout this workshop.

## Navigating in (Bash) terminal

What you see the beginning is a *terminal prompt*

You usually will see username@hostname the : sign and the name of a directory you are currently in. ~ sign means that you are in *home* directory.

If I can teach you one thing during this workshop it is to really carefully read the output of the commands as in many situations the program will inform you what is going wrong.

`pwd #show current working directory.`

`ls #list directory contents`

`cd #change directory`

`cd ~ #move to home directory`

`cd .. #move down`

`cd / #move to root directory`

`cd - #move to previous directory`

⭾ Tab key is super important as it enables automatic completion.

It is also terrific to use [globbing](https://en.wikipedia.org/wiki/Glob_(programming)) that is a to expand arguments using star * or a question mark ?

`ls -al /dev/rand*`


`history` is a helpful command that shows what you have previously inputted
`man` is a command that shows you manual for a particular command.

You can use ! to repeat commands
`!123` will repeat command 123 from history

`!!` will repeat the last command, it is super useful with `sudo !!` when you forget sudo

`!$` will enable you to use the last argument from the previous command

ctr a will lead you to the beginning of a line 
ctr e will lear you to the end of line

## Working with files and directories

It is good to know what to do with files and directories in the Linux system especially as nearly everything can be accessed that way.

`cd /dev` 

`ls #lists the directory contents` , the dev directory shows that different devices such as hard disks,  modems or even random number generators are considered files in the Linux system.

`ls -al` will list the directory with two flags. *a* will show all files as well as special ones such as . and ..
l flag will show the long output

Let's understand the output.

crw-rw-rw-   1 root root        1,   8 cze 12 12:25 random

first is a file type (b,c is a block, special character file, - is a regular file, d is dir l is link. [More can be found here](https://linuxize.com/post/how-to-list-files-in-linux-using-the-ls-command/)

then there are permissions. This is an important concept as files and directories can be used by multiple users. There are three main permissions, to read write and to execute. It the case above the user can read and write, also the group that the user is as well as others.

The number next to the permissions is the number of hard links. In the Linux system we can have links to files. Soft links are like hiperlinks to a file while hard links make file appear as if in two places in one. The difference is when deleting the file, when you delete the file with a soft link, soft links stop working. When you delete a file with hard links, the file is not really deleted as long as it has hard links.

root root means the owner and group. In this case, the owner is root and the group is also root, so the owner and group permissions apply to the root. 

Next is the size of file in bytes.

then we have the date of last modification in the local time format

And finally the name of the file.

File permissions are important when for example you want to make the file to be usable
on a server or when you want the file to execute.

`ls -al` will show you *all* files with long format information.

`chmod +x executable_file.sh` will make the file executable


`mkdir #make new directory`

`rmdir #remove empty dir`

`rm #remove file`

`rm -rf #remove file, recursively (the whole directory tree), force `

`touch #makes and empty file`

`mv #move file`

`cp #copy file`

`ln -s` make symbolic link


## Terminal programs

Many fantastic programs are accessible through the terminal, and many of them are already part of the GNU-Linux System.
 

`ps` 
`ps -aux`

`date`

`ssh` is a command to login to a different computer in a secure way
`ssh new@sdf.org` you can play around the sdf public access unix system
`scp from to` is a program to copy files using ssh
`rsync` is a program to copy only files that are different between the two directories

`screen` is a great program that may require an install. It enables you to have a long-running tasks through *sessions* that you can log in and log out from.

`cron` is a program that enables you to schedule repeated tasks.

`wget` is a program to download files
`vim` is extremally powerfull but quite difficult text editor with its own mini-language

and finally 
`cowsay` is a program to make cow say what you want

## Programs for text analysys

Where Linux is most powerful is with commands that work on streams of data, particularly text.
This is also what a lot of scientific data looks like -- some analysis program or device outputting a large text file.

`less` is a program to step through text file or text steam in a friendly fashion

`cat` is a program to either display a file but originally to concatenate multiple text files

`echo` is a program to display text on screen

`head` is a program that shows you first lines of a file / stream
`tail` shows you bottom lines of a file or stream.

`wc` word count

The below examples use files from excercise_text folder.

### Grep -- searching for patterns in files
`grep 'TTCTC' short.fastq` will look for all lines that have TTCTC sequence

We can use regex to find some other and stranger sequences
`grep 'T.CTC' short.fastq` will find all sequences that start at T with multiple T letters and then CTC

`grep -A 2 -B 1 'TTCTC' short.fastq` will show two lines *After* and one line *Before* the thing we are looking for

`grep -n 'TTCTC' short.fastq` will show the line number of the find

Grep can also work on multiple files; you can either state them explicitly by naming them after space
or you can use globs for example 
`grep -n 'TCTC' *` will look for this pattern in all files in a directory

-v flag will show lines without a match



### Sed -- stream editing/ filtering files

Instead of just finding patterns in file sed can read a line, find a pattern and do something with this line.
This is particularly useful when we want to substitute some string that follows a pattern with some other pattern.

`sed "s/like/love/" random_likes.txt` will take every first occurrence of like in a line and substitute it with love
`sed "s/like/love/g" random_likes.txt` will replace all
`sed '1d' random_likes.txt` will delete first line
`sed "/don't/d" random_likes.txt` will delete line with don't

The patterns can use regex, and you have access to the result.

### awk

Awk is a program that works with *tabular* data

`awk  '{print $2}' short.gff3` will print the second column of a file (by default separated by space or tabs)
`awk  '{print $4+$5}' short.gff3` will add and print columns 4 and 5

`awk '{ if ($3 == "intron") { print } }' short.gff3` will print the whole row but only if third column equals intron

Generally I suggest moving to Python Pandas or R if you are doing something more ambitions with tabular data.
## Piping

Piping is a way to do things with *streams* of data. Most of Linux terminal programs output streams of data and can use streams of data coming from other applications as input.

This is nice, because you can connect multiple programs one to another, one doing one thing, instead of finding a specialized program that does what you need. Also,
because we are sometimes working on huge files using streams -- where data can be passed line by line, means that you can get away with a smaller amount of RAM, and your program will run faster (hopefully).

The most basic use of piping is streaming the output of the function to a file.

`ls > list_of_files.txt` will stream the ls to a file (see the resulting file)
`ls >> list_of_files.txt` will *append* to the end of file the result of ls command (try running it multiple times)


The basic way to form a pipe is by using the pipe | sign.

`echo -e "example text \nsome new line" | grep "example" `

This will pass the text to grep, which will find lines with the word example in it.

There can be whole chains of commands; we can add another program (word count) that will show us the number of lines found

`echo -e "example text \nsome new line" | grep "text" | wc -l`

Sometimes you want to see the result on a terminal and save it to file. Use tee command

`ls | tee result.txt`





## Bash language and scripts

The Bash is also a scripting language that can be very useful particularly when working on sets of files -- I do not recommend it for a general computation as it can be quite tricky (use Python instead ;)).

We can set variables to use in Bash.

`SOME_VARIABLE="Hello"
echo $SOME_VARIABLE`

Notice the lack of space before and after the equal sign

There is plenty of "environment variables" already set by the various programs and scripts on the system, use $ and tab to see them all.

`echo $SHELL #will display the shell currently used`

You probably noticed but # is used to state comments.

When writing scripts, you usually create a file with .bash or .sh extension, starting with a line 

`#!/bin/bash` that informs the shell that you want Bash to run the fallowing lines.
You also need to change permissions to +x to enable execution.

### conditionals

```
if [ $1 = "secret" ]; then
    echo "you found a secret!"
else
    echo "nothing to add"
fi
```

This will take first *argument* and compare it to the word "secret"


### loops

We can take input from another command and use it line-for-line


```
for name in $(cat names.txt)
do

    echo "her name was $name"
done
```

Or we can use the glob.

```
for file in *
do
    echo "this is a file: $file"
    echo ";)"
done
```

this will echo for each file in a directory



## Wrapup

This was just a small introduction to the powerful terminal tools of a Linux system.
Linux continues philosophy coming from UNIX of having small, specialized tools with their own mini-languages (like grep or awk) that user can connect one to another using pipes.
Using Linux system to the maximum requires quite some time but will make you much faster and give you control.

There is a lot more to show, so good luck on your adventure! 

