clear
login(){
    echo "Enter your Username:"
    read user #username
    echo "Enter your Password:"
    read pass #password
    if [ "$user" = "user" ] && [ "$pass" = "pass" ]
        then
        echo "login success"
        else
            echo
            echo "Enter a valid username and password"
            echo "-----------------------------------"
            echo "To login again press 1"
            echo "To exit press [CTRL + C]"
            read choice
            if [ "$choice" = 1 ] 
            then
                clear
                login
            fi
    fi
}

add(){
    clear
    echo "Add a record to the prisoners database"
    echo "Enter the prisoner id:"
    read p_id
    echo "Enter the name of the prisoner:"
    read p_name
    echo "Enter the cell no of the prisoner:"
    read p_cell
    echo "Enter the prisoner punished date:(DD-MM-YYYY)"
    read p_in
    echo "Enter the punishment duration:(in months)"
    read p_out
    record="$p_id $p_name $p_cell $p_in $p_out"
    echo $record >> prisoner_db
    echo "Record successfully added"
    sleep 1
}

search() {
    clear
    echo "Enter the prisoner id:"
    read search_id
    echo
    echo "loading the record of the prisoner with id : $search_id"
    grep ^$search_id prisoner_db
    if [ $? -ne 0 ]
    then
        echo "record for prisoner id $search_id does not exist"
        echo
        echo "---press 1: to add a record with this id---"
        echo "---press 2: to exit---"
        read s_choice
        if [ $s_choice -eq 1 ]
        then
            add
        elif [ $s_choice -eq 2 ]
        then
            menu
        fi
    fi
    echo
    echo "---PRESS q/Q TO GO BACK TO THE MENU---"
    read q
    if [ "$q" = "q" ] || [ "$q" = "Q" ]
    then
        menu
    fi
}


view() {
    clear
    echo "Showing the records of the prisoners"
    less prisoner_db
}

delete() {
    clear
    echo "Enter the prisoner id to be deleted:"
    read delete_id
    dn="deleting prisoner with id $delete_id"
    grep ^$delete_id prisoner_db
    if [ $? -ne 0 ]
    then
        echo "Record for id $delete_id does not exist"
    else
        grep -v $delete_id prisoner_db >> temp
        cp temp prisoner_db
        echo "Record deleted successfully"
    fi
}

menu() {
    clear
    echo "----------MAIN MENU----------"
    echo "1. ADD RECORD"
    echo "2. SEARCH RECORD"
    echo "3. EDIT RECORD"
    echo "4. VIEW RECORD"
    echo "5. DELETE RECORD"
    echo "6. EXIT"
    echo
    echo "ENTER YOUR CHOICE"
    read choice
    case $choice in 
        1) add ;;
        2) search ;;
        3) edit ;;
        4) view ;;
        5) delete ;;
        6) echo "Exiting the application." 
           t=0 ;;
        *) echo "Enter a valid choice."
    esac
}

start() {
    echo "***********************************"
    echo "WELCOME TO PRISON MANAGEMENT SYSTEM"
    echo "***********************************"
    login
    t=1
    while [ $t -ne 0 ]
    do  
        menu
        sleep 1
    done
}

start