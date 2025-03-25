const customName = document.getElementById('customname');
const randomize = document.querySelector('.randomize');
const story = document.querySelector('.story');

function randomValueFromArray(array){
  const random = Math.floor(Math.random()*array.length);
  return array[random];
}

const storyText = "It was 94 degrees Fahrenheit outside, so :insertx: decided to embrace adventure. Upon reaching :inserty:, they took a deep breath, processed the absurdity of existence, and then :insertz:. Bob saw everything but simply nodded--they had long accepted that :insertx: was a force of chaotic energy, and just wanted to go home.";
const insertX = ["Lord Farquad", "Jojo Siwa", "Joe Biden"];
const insertY = ["the lost city of Atlantis, which turned out to be a kiddie pool", "the Bermuda Triangle", "Britney Spears' basement"];
const insertZ = ["cried desperately to the point of death", "challenged a pigeon to a duel and lost", "got put on the TSA watch list"];

randomize.addEventListener('click', result);

function randomValueFromArray(array) {
  return array[Math.floor(Math.random() * array.length)];
}

function result() {
  let newStory = storyText;

  const xItem = randomValueFromArray(insertX);
  const yItem = randomValueFromArray(insertY);
  const zItem = randomValueFromArray(insertZ);

  newStory = newStory.replaceAll(':insertx:', xItem);
  newStory = newStory.replaceAll(':inserty:', yItem);
  newStory = newStory.replaceAll(':insertz:', zItem);

  if(customName.value !== '') {
    const name = customName.value;
    newStory = newStory.replace('Bob', name);
  }

  if(document.getElementById("uk").checked) {
    const weight = Math.round(300 / 14) + ' stone';
    const temperature = Math.round((94 - 32) * 5 / 9) + ' centigrade';
    
    newStory = newStory.replace('300 pounds', weight);
    newStory = newStory.replace('94 fahrenheit', temperature);
  }

  story.textContent = newStory;
  story.style.visibility = 'visible';
}
