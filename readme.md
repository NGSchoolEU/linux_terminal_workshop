# Basics of Linux Terminal and Bash

## Why use terminal and Bash?

Linux terminal is one of primary ways to interact with Linux system. This is because in enables commanding the system in a very good way -- precise, repeatable and explainable. 
The name means that you access the system through typing commands and receiving input as a text, usually displayed on the screen. Compared to using a GUI - a Windows-like interaction here instead of gestures and images you use words and symbols. 

While terminal itself is just a name for a type of access, not neccessarely a functions that would be available, (for example you can have a terminal access to a [super-small microcontroler](https://docs.micropython.org/en/latest/esp8266/tutorial/repl.html)), usually what we want is a Shell -- a program that takes commands written in terminal and passes them to the system.

The most popular shell is bash and we will be using it thoughout this workshop.

## Navigating in (Bash) terminal


`pwd #show current working directory`

`ls #list directory contents`

`cd #change directory`

`cd ~ #move to home directory`

`cd .. #move down`

`cd / #move to root directory`

`cd - #move to previous directory`

⭾ Tab key is super important as it enables automatic completion

It is also very good to use (globbing)[https://en.wikipedia.org/wiki/Glob_(programming)] that is a to expand arguments using star * or question mark ?

`ls -al /dev/rand*`


`history` is a nice command that shows what you have previously imputted

You can use ! to repeat commands
`!123` will repeat command 123 from history

`!!` will repeat last command, it is super usefull with `sudo !!` when you forget sudo

`!$` will enable you to use last argument from the last command



## Working with files and directories

It is good to know what to do with files and directories in the Linux system especially as nearly everything can be accessed that way

`cd /dev` 

`ls #lists the directory contents` , the dev directory shows that different devices such as hard disks,  modems or even random number generators are considered files in the linux system

`ls -al` will list the directory with two flags. *a* will show all files as well as special ones such as . and ..
l flag will show the long output

Let's understand the output

crw-rw-rw-   1 root root        1,   8 cze 12 12:25 random

first is a file type (b,c is a block, character special file, - is a regular file, d is dir l is link. (More can be found here)[https://linuxize.com/post/how-to-list-files-in-linux-using-the-ls-command/])

then there are permissions. This is an important concept as files and directories can be used by multiple users, there are 3 main permissions, to read write and to execute. It the case above user can read and write, also the group that user is as well as others.

the number next to the permissions is the number of hard links. In linux system we can have links to files. Soft links are like hiperlinks to a file while hard links make file appear as if in two places in one. The difference is when deleting the file, when you delete the file with soft link, soft links stop working. When you delete file with hard links, the file is not really deleted as long as it has hard links.

root root means the owner and group. In this case the owner is root and the group is also root, so the owner and group permissions apply to the root. 

Next is size of file in bytes.

then we have the date of last modification in the local time format

and finally the name of the file.

`mkdir #make new directory`

`rmdir #remove empty dir`

`rm #remove file`

`rm -rf #remove file, recursevely (the whole directory tree), force `

`touch #makes and empty file`

`mv #move file`

`cp #copy file`

`ln -s` make symbolic link


## Terminal programs

There are many of fantastic programs accessable through terminal, many of them already part of the GNU-Linux System. 

`ps` 
`ps -aux`

`date`

`ssh` is a command to login to a different computers through a secure way
`screen` is a great program that may require install. It enables you to have a long-running taks through *sessions* that you can log in and log out from.

`cron` is a program that enables you to schedule repeated tasks

and finally 
`cowsay` is a program to make cow say what you want

## Programs for text analysys

Where Linux is most powerfull is with commands tha work on streams of data, particulary text.
This is also what a lot of scientific data looks like -- some analaysys program or device outputing a large text file.

`less` is a program to step through text file or text steam in a nice fashion

`cat` is a program to either display a file but originally to concatenate multiple text files

`echo` is a program to display text on screen








## Piping

Piping is a way to do things with *streams* of data. Most of Linux terminal programs output streams of data and can use streams of data coming from other programs as input.

This is nice, because you can connect multiple programs one to another, one doing one thing, instead of finding specialized program that does what you need. Also,
because we are sometimes working on very large files using streams -- where data can be passed line by line, means that you can get away with smaller amount of RAM and your program will run faster.

Basic way to form a pipe is by using the pipe | sign.

`echo -e "example text \nsome new line" | grep "example" `

This will pass the text to grep which will find lines with the word example in it.

There can be whole chains of commands, we can add another program (word count) that will show us number of lines found

`echo -e "example text \nsome new line" | grep "text" | wc -l`






## Bash language and scripts

The Bash is also a scripting language, that can be very usefull particularly when working on sets of files -- I do not reccomend it for a general computation as it can be quite tricky.

We can set variables to use in bash

`SOME_VARIABLE="Hello"
echo $SOME_VARIABLE`

Notice the lack of space before and after the equal sign

There is plenty of "environment variables" already set by the various programs and scripts on the system, use $ and tab to see them all.

`echo $SHELL #will display the shell currentely used`

You probably noticed but # is used to state comments.

When writing scripts, you usually create a file with .bash or .sh extension, starting with a line 

`#!/bin/bash` that informs the shell that you want bash to run the fallowing lines.




## Wrapup

This was just a small introduction to the powerfull terminal tools of a Linux system.
Linux continues philosophy coming from UNIX of having small, specialized tools with their own mini-languages (like grep or awk) that user can connect one to another using pipes.
Using Linux system to the maximum requires quite some time but will make you much faster and give you control.


