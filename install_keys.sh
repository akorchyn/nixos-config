for file in gpg/*
do
    echo "Decoding file: $file"

    gpg $file
    if [[ $? -ne 0 ]]
    then
        echo "Failed to decode a key: $file"
    fi
    file=${file%".gpg"}
    echo "Decoded file to $file"
    gpg --import $file
    if [[ $? -ne 0 ]]
    then
        echo "failed to insert a key: $file"
    else
        rm -f $file
        echo "Success"
    fi
done