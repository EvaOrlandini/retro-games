// TODO: write your code here
const announcement = document.querySelector(".winner");

const elementsPlayer1 = document.querySelectorAll("#player1-race td");
let activePlayer1 = document.querySelector("#player1-race .active");
let activeIndex1 = Array.from(elementsPlayer1).indexOf(activePlayer1);

const elementsPlayer2 = document.querySelectorAll("#player2-race td");
let activePlayer2 = document.querySelector("#player2-race .active");
let activeIndex2 = Array.from(elementsPlayer2).indexOf(activePlayer2);

document.addEventListener("keyup", (event) => {
  if (event.key === "q" && activeIndex1 < elementsPlayer1.length - 1) {
    activePlayer1 = document.querySelector("#player1-race .active");
    activePlayer1.classList.remove("active");
    activeIndex1 += 1;
    elementsPlayer1[activeIndex1].classList.add("active");
    if (activeIndex1 === elementsPlayer1.length - 1) {
      announcement.innerText = "the winner is player 1";
    }
  }
});

document.addEventListener("keyup", (event) => {
  if (event.key === "p" && activeIndex2 < elementsPlayer2.length - 1) {
    activePlayer2 = document.querySelector("#player2-race .active");
    activePlayer2.classList.remove("active");
    activeIndex2 += 1;
    elementsPlayer2[activeIndex2].classList.add("active");
    if (activeIndex2 === elementsPlayer2.length - 1) {
      announcement.innerText = "the winner is player 2";
    }
  }
});

const button = document.querySelector("button");
button.addEventListener("click", (event) => {
  activeIndex1 = 0;
  activeIndex2 = 0;

  activePlayer1 = document.querySelector("#player1-race .active");
  activePlayer1.classList.remove("active");
  elementsPlayer1[0].classList.add("active");

  activePlayer2 = document.querySelector("#player2-race .active");
  activePlayer2.classList.remove("active");
  elementsPlayer2[0].classList.add("active");

  announcement.innerText = "";
});
