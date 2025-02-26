# Arrays to store patient information
declare -a patientnames
declare -a patientids
declare -a patientages

# Function to add a new patient
addPatient() {
    echo "Please Enter the name of patient:"
    read name
    patientnames+=("$name")

    echo "Please Enter patient ID:"
    read id
    patientids+=("$id")

    echo "Please Enter patient age:"
    read age
    patientages+=("$age")

    echo "Patient added successfully...."
}

# Function to display all patients
displayPatients() {
    if (( ${#patientnames[@]} == 0 )); then
        echo "No patients found."
    else
        echo "------ Patient List ------"
        for (( i = 0; i < ${#patientnames[@]}; i++ )); do
            echo "Patient Name: ${patientnames[$i]}"
            echo "Patient ID: ${patientids[$i]}"
            echo "Patient Age: ${patientages[$i]}"
            echo "-----------------------"
        done
    fi
}

# Function to display patients sorted by ID in ascending order
displaySortedById() {
    if (( ${#patientnames[@]} == 0 )); then
        echo "No patients found."
    else
        echo "------ Sorted Patient List by ID ------"
        # Create an array of indices sorted by patient ID
        sorted_indices=($(for i in "${!patientids[@]}"; do echo "$i ${patientids[$i]}"; done | sort -n -k2 | awk '{print $1}'))

        for index in "${sorted_indices[@]}"; do
            echo "Patient Name: ${patientnames[$index]}"
            echo "Patient ID: ${patientids[$index]}"
            echo "Patient Age: ${patientages[$index]}"
            echo "-----------------------"
        done
    fi
}

# Function to search for a patient by ID
searchPatient() {
    echo "Enter patient ID to search:"
    read searchid

    found=false
    for (( i = 0; i < ${#patientids[@]}; i++ )); do
        if [[ ${patientids[$i]} == $searchid ]]; then
            echo "Patient found:"
            echo "Patient Name: ${patientnames[$i]}"
            echo "Patient ID: ${patientids[$i]}"
            echo "Patient Age: ${patientages[$i]}"
            found=true
            break
        fi
    done

    if [[ $found == false ]]; then
        echo "Patient with ID $searchid not found...."
    fi
}

# Function to delete a patient by ID
deletePatient() {
    echo "Enter patient ID to delete:"
    read deleteid

    foundindex=-1
    for (( i = 0; i < ${#patientids[@]}; i++ )); do
        if [[ ${patientids[$i]} == $deleteid ]]; then
            foundindex=$i
            break
        fi
    done

    if (( foundindex != -1 )); then
        unset 'patientnames[$foundindex]'
        unset 'patientids[$foundindex]'
        unset 'patientages[$foundindex]'
        patientnames=("${patientnames[@]}")
        patientids=("${patientids[@]}")
        patientages=("${patientages[@]}")
        echo "Patient with ID $deleteid deleted successfully."
    else
        echo "Patient with ID $deleteid not found."
    fi
}

# Main menu
while true; do
    echo "----- Hospital Management System -----"
    echo "1. Add a patient"
    echo "2. Display all patients"
    echo "3. Display sorted patients by ID"
    echo "4. Search for a patient"
    echo "5. Delete a patient"
    echo "6. Exit"
    echo "--------------------------------------"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) addPatient;;
        2) displayPatients;;
        3) displaySortedById;;
        4) searchPatient;;
        5) deletePatient;;
        6) echo "Exiting..."; exit 0;;
        *) echo "Invalid choice. Please try again.";;
    esac

    echo
done
