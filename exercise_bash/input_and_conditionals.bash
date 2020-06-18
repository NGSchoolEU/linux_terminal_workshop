echo "Your first argument was $1 and the filename is $0"
echo "what is your name?"
read name
echo "hello $name"

if [ $1 = "secret" ]; then
    echo "you found a secret!"
else
    echo "nothing to add"
fi
