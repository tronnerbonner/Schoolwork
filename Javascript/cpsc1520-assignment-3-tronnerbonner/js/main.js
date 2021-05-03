// Enter JavaScript for the exercise here...
//Grabbing error div
let error = document.querySelector(".error");

//Parent node
let transactionParent = document.querySelector("tbody");

//To fixed
function financial(x) {
    return Number.parseFloat(x).toFixed(2);
}

//Total values
let debitTotal;
let creditTotal;

//Function and event listener for submitting
document.querySelector('input[type=submit]').addEventListener('click', (evt)=> {
    //Grabbing inputted values
    let description = document.querySelector("input", "description").value;
    let transaction = document.querySelector("select").value;
    let amount = document.querySelector('[name="currency"]').value;
    error.innerHTML = "";

    //Validation
    let transactionValidation = true;

    //Grabbing numbers
    let amountRounded = financial(amount);
    debitSelector = document.querySelector(".debits").innerHTML;
    creditSelector = document.querySelector(".credits").innerHTML;
    //Remove $
    debitAmount = debitSelector.replace('$', '');
    creditAmount = creditSelector.replace('$', '');

    //check if something was typed into description
    if(!description.length) {
        error.innerHTML += "Description cannot be empty <br />"
        transactionValidation = false;
    } else {
        
    }

    //check if transaction is default
    if(transaction === "") {
        transactionValidation = false;
        error.innerHTML += "No transaction type was selected <br />"
        transactionValidation = false;
    } else {
        
    }

    //check if amount is negative
    if(amount < 0){
        error.innerHTML += "The value cannot be less than 0"
        transactionValidation = false;
    } else {

    }

    if(transactionValidation === true){
        //Amount editing
        //on debit
        if (transaction === "debit"){
            debitTotal = parseFloat(debitAmount) + parseFloat(amount);
            document.querySelector(".debits").innerHTML = "$" + financial(debitTotal);
        //on credit
        } else if (transaction === "credit") {
            creditTotal = parseFloat(creditAmount) + parseFloat(amount);
            document.querySelector(".credits").innerHTML = "$" + financial(creditTotal);
        } else {

        }


        //Node editing
        descriptionText = document.createTextNode(description);
        transactionText = document.createTextNode(transaction);
        amountText = document.createTextNode("$" + amountRounded);

        tr = document.createElement('tr');
        descriptionRow = document.createElement('td');
        transactionRow = document.createElement('td');
        amountRow = document.createElement('td');
        toolsRow = document.createElement('td');
        i = document.createElement('i');

        tr.setAttribute('class', transaction);
        
        amountRow.setAttribute('class', transaction);
        toolsRow.setAttribute('class', 'tools');
        i.setAttribute('class', "delete fa fa-trash-o");

        descriptionRow.appendChild(descriptionText);
        transactionRow.appendChild(transactionText);
        amountRow.appendChild(amountText);
        toolsRow.appendChild(i);

        tr.appendChild(descriptionRow);
        tr.appendChild(transactionRow);
        tr.appendChild(amountRow);
        tr.appendChild(toolsRow);

        //adding child
        transactionParent.appendChild(tr);

        
    } else {
        
    }

    evt.preventDefault();
});


document.querySelector('tbody').addEventListener('click', (evt)=> {

    //grabbing the correct target
    tdTools = evt.target.parentNode;
    tableRow = tdTools.parentNode;

    //grabbing the correct element
    let tableChildren = tableRow.children;
    let amountToSubtractRaw = tableChildren[2].innerHTML;
    let amounToSubtract = amountToSubtractRaw.replace('$', '');


    //If the click is actually on the trash can
    if (evt.target.classList.contains('delete')) {
        //Just making sure
        if (confirm("Do you want to remove this transaction from the list?")) {

            //Selecing the current values
            debitSelector = document.querySelector(".debits").innerHTML;
            creditSelector = document.querySelector(".credits").innerHTML;
            //removing $
            debitAmount = debitSelector.replace('$', '');
            creditAmount = creditSelector.replace('$', '');

            //on debit
            if (tableRow.classList.contains("debit")) {
                debitTotal = parseFloat(debitAmount) - parseFloat(amounToSubtract);
                document.querySelector(".debits").innerHTML = '$' + financial(debitTotal);
            //on credit
            } else {
                creditTotal = parseFloat(creditAmount) - parseFloat(amounToSubtract);
                document.querySelector(".credits").innerHTML = '$' + financial(creditTotal);
            } 
            //Removing child
            transactionParent.removeChild(tableRow);
		} else {
			
		}
    } else {
        
    }

    evt.preventDefault();
});


/*Timer function*/
function inactiveTimer() {
    alert("You have been inactive for 2 minutes. Press ok to refresh the page");
    location.reload(); 
} 

//Initializing timeout
let actualTimeout;

/*Timer Function*/
function timerTimeout() {
    actualTimeout = setTimeout(inactiveTimer, 120000);
} 

/*Resetting timer*/
function timerReset() {
    clearTimeout(actualTimeout);
    timerTimeout();
}

/*Timer on click*/
addEventListener("click", (evt)=> {
    timerReset();
    evt.preventDefault();
});

/*Timer on mousemove*/
addEventListener("mousemove", (evt)=> {
    timerReset();
    evt.preventDefault();
});

/*Timer starting up on load*/
document.querySelector("body").onload = (evt) => {
    timerTimeout();
    evt.preventDefault();
}