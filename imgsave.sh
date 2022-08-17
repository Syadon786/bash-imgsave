#!/usr/bin/bash
usage () { 
     echo "imgsave: Képek átmásolása egy telefonról dátum alapján egy másik adathordozóra."
     echo -e "\t Argumentumok sorban: forrásmappa, célmappa, kezdődátum, végdátum" 
}

parameters () {
     echo "Forrásmappa: $1"
     echo "Célmappa: $2"
     echo  "Intervallum: $3-$4"
}

if [ $# -lt 4 ]
    then 
        usage
else
    echo $1
    parameters "$1" "$2" $3 $4 

    dates=()
    start=$3
    end=$4

    start=$(date -d $start +%Y%m%d)
    end=$(date -d $end +%Y%m%d)

    while [[ $start -le $end ]]
    do
            dates+=($start)
            start=$(date -d"$start + 1 day" +"%Y%m%d")
    done

    cd "$1"
    mkdir -p "$2"

    filenames=()
    for date in "${dates[@]}"
    do
         filenames+=($(ls | grep "IMG_$date"))
         echo $date
    done
    
    echo "Képek másolása folyamatban..."
    
    for filename in "${filenames[@]}"
    do 
        mkdir -p $2/${filename:4:8}
        cp ${filename} $2/${filename:4:8}/    
    done
    
    echo "Másolás befejeződött!"
fi


