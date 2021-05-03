// Enter your JavaScript for the solution here...
//Grabbing the form
let input = document.querySelector('input');
let resetBar = document.querySelector('.reset');

//Main array
let thumbDisplay = document.querySelectorAll('.thumb-display');
let thumbArray = Array.from(thumbDisplay);

function filterHandler(e) {
    //Grabbing Search Results
    let search = e.target.value;

    thumbArray.forEach(function(element, index){


        let arrayP = thumbArray[index].querySelector('p');
        let arrayDiv = thumbArray[index];
        console.log(arrayP.innerHTML);
        
        //Checks if there are any search matches
        if(arrayP.innerHTML.includes(search)){
            //Remove hidden class
            arrayDiv.classList.remove('hidden');
        }
        else{
            //Add hidden class
            arrayDiv.classList.add('hidden');
        }
        
        //Checks if search is empty or has content
        if(search){
            //Remove hidden class
            resetBar.classList.remove('hidden');
        }
        else{
            //Add hidden class
            resetBar.classList.add('hidden');
        }

    });    
}

function resetHandler(evt){
    //Grab form value
    let filterSearch = document.querySelector('.frm-control');

    //Set form value to nothing
    filterSearch.value = "";

    //Add hidden class
    resetBar.classList.add('hidden');

    //Remove hidden class
    thumbArray.forEach(function(element, index){
        let arrayDiv = thumbArray[index];
        arrayDiv.classList.remove('hidden');       
    });    

    evt.preventDefault();
}


//Input event listener and text change event
input.addEventListener("input", filterHandler);

//Reset event listener
resetBar.addEventListener("click", resetHandler);
