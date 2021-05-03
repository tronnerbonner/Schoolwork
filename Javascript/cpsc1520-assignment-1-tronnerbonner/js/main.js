// Enter your JavaScript for the solution here...

//global variables
let imgDisplay = document.querySelector("div.meme-display > img");
let topTextDisplay = document.querySelector("p.top-text");
let bottomTextDisplay = document.querySelector("p.bottom-text");
let error = document.querySelector('div.error');

//grabbing form for readability

let memeForm = document.querySelector(".meme-form");

//submit function event handler
memeForm.addEventListener("submit", function(evt) {
    //grab form elements
    let memeImageElem = memeForm.elements.memeImage;
    let topTextElem = memeForm.elements.memeTopText;
    let bottomTextElem = memeForm.elements.memeBottomText;

    //grabbing values
    let memeImage = memeImageElem.value;
    let topText = topTextElem.value;
    let bottomText = bottomTextElem.value;

    //error value
    let error = document.querySelector('div.error');

    //img valiation
    if (memeImage === ""){
        error.innerHTML = "<p>Please Select a Valid Meme</p>";
    }
    else {
        //top text validation
        if (topText.trim() === ""){
            error.innerHTML = "<p>Please input top text</p>"
        }
        else {
            //bottom text validation
            if (bottomText.trim() === "") {
                error.innerHTML = "<p>Please input bottom text<p>"
            }
            //validation passed, display meme input
            else {
                topTextDisplay.innerHTML = topText;
                bottomTextDisplay.innerHTML = bottomText;

                if(memeImage === "fry-meme") {
                    imgDisplay.src = "img/fry-meme.png";
                    imgDisplay.alt = "Futurama Fry Meme";
                }
                //lotr
                else if (memeImage === "one-does-not-simply-meme") {
                    imgDisplay.src = "img/one-does-not-simply-meme.png";
                    imgDisplay.alt = "Ones Does Not Simply Meme";
                }
                //most interesting man
                else if (memeImage === "most-interesting-man-meme") {
                    imgDisplay.src = "img/most-interesting-man-meme.png";
                    imgDisplay.alt = "Most Interesting Man";
                }
                //If somehow you managed to select another option
                else{
                    error.innerHTML = "<p>Please Select a Valid Meme</p>";
                }
            }
        }
    }

    //prevent default
    evt.preventDefault();
});

//reset function event handler
memeForm.addEventListener("reset", function(evt) {
 
    //reset for reset button
    imgDisplay.src = "https://via.placeholder.com/550x300?text=Choose+an+image+from+the+dropdown";
    imgDisplay.alt = "Placeholder Image";
    topTextDisplay.innerHTML = "";
    bottomTextDisplay.innerHTML = "";
    error.innerHTML = "";

    //prevent default
    evt.preventDefault();
});