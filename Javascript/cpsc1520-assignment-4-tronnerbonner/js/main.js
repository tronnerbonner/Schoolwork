// Your code here...
let friendMenu = document.querySelector('.friends>a');
let homeMenu = document.querySelector('.home>a')
let contentSelector = document.querySelector('.content');
//Adds selected
function menuSelected(value) {
    value.classList.add('pure-menu-selected');
};

//Removed selected
function menuRemoved(value) {
    value.classList.remove('pure-menu-selected');
};

//On Friends click
friendMenu.addEventListener('click', (evt)=> {
    clearContent();
    menuSelected(friendMenu.parentElement);
    menuRemoved(homeMenu.parentElement);
    friendFetch();
    evt.preventDefault();
});

//On Home click
homeMenu.addEventListener('click', (evt)=> {
    clearContent();
    menuSelected(homeMenu.parentElement);
    menuRemoved(friendMenu.parentElement);
    evt.preventDefault();
})

//Fetches the friends from the friends json
function friendFetch() {
    fetch("../friends/friends.json").then(response => {
        console.log(response.status);
        return response.json();
    }).then(json_data => {
        friendList(json_data);
    });
};

//Creates the friend list
function friendList(value) {
    friendListInitialize();
    let ulSelector = document.querySelector('div.content > ul');
    //Loops for each friend and displays the data
    value.forEach(item => {
        console.log(item.firstName);
        let li = document.createElement('li');
        let a = document.createElement('a');
        a.setAttribute('class', 'pure-menu-link');
        a.setAttribute('data-id', item.id);
        let friendName = document.createTextNode(`${item.firstName} ${item.lastName}`);
        li.setAttribute('class', 'pure-menu-item');
        a.appendChild(friendName);
        li.appendChild(a);
        ulSelector.appendChild(li);
    });
};

//The first portion of the displayed friend list 
function friendListInitialize() {
    //Element creation and attribute setting
    let div = document.createElement('div');
    div.setAttribute('class', 'pure-menu custom-restricted-width');
    let span = document.createElement('span');
    let friendHeading = document.createTextNode('Friends');
    span.setAttribute('class', 'pure-menu-heading');
    span.appendChild(friendHeading);
    let ul = document.createElement('ul');
    ul.setAttribute('class', 'pure-menu-list');
    //Giving the parents children
    contentSelector.appendChild(div);
    contentSelector.appendChild(span);
    contentSelector.appendChild(ul);
};

//On friend click
contentSelector.addEventListener('click', (evt) => {
    if(evt.target.classList.contains('pure-menu-link')) {
        clearContent();
        let dataID = evt.target.getAttribute('data-id');

        friendGeneration(dataID);
    }
    evt.preventDefault();
});

//This fetches data from the friends unique json file
function friendGeneration(value) {
    fetch(`../friends/${value}.json`).then(response => {
        console.log(response.status);
        return response.json();
    }).then(json_data => {
        createFriend(json_data);
    })
};

//Displays the information from the friends unique json file
function createFriend(value) {
    //I should have wrapped all of these in a function
    //Setting element creation
    let friendDiv = document.createElement('div');
    let identityDiv = document.createElement('div');
    let img = document.createElement('img');
    let h2 = document.createElement('h2');
    let ul = document.createElement('ul');
    let emailLI = document.createElement('li');
    let emailSpan = document.createElement('span')
    let townLI = document.createElement('li');
    let townSpan = document.createElement('span')
    let bio = document.createElement('p');

    //Setting attributes/text
    friendDiv.setAttribute('class', 'friend');
    identityDiv.setAttribute('class', 'identity')
    img.setAttribute('src', `img/${value.avatar}`);
    img.setAttribute('class', 'photo');
    h2.setAttribute('class', 'name');
    h2.innerHTML = `${value.firstName} ${value.lastName}`;
    emailSpan.setAttribute('class', 'label');
    emailSpan.innerHTML = "email:";
    townSpan.setAttribute('class', 'label');
    townSpan.innerHTML = "hometown:"
    bio.setAttribute('class', 'bio');
    bio.innerHTML = value.bio;

    //Giving the parents children
    contentSelector.appendChild(friendDiv);
    friendDiv.appendChild(identityDiv);
    identityDiv.appendChild(img);
    identityDiv.appendChild(h2);
    identityDiv.appendChild(ul);
    ul.appendChild(emailLI);
    ul.appendChild(townLI);
    emailLI.appendChild(emailSpan);
    emailLI.innerHTML += `\xa0${value.email}`;
    townLI.appendChild(townSpan);
    townLI.innerHTML += `\xa0${value.hometown}`;
    friendDiv.appendChild(bio);

};

//Clears content div
function clearContent() {
    contentSelector.innerHTML = "";
};