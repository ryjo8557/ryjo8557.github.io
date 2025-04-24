let phoneNumber = '';
let sequence = [];
let userInput = [];
let currentDigit = 0;
let awaitingSimon = false;

const colors = ['green', 'red', 'blue', 'yellow'];

const phoneInput = document.getElementById('phone');
const changeBtn = document.getElementById('change-digit');
const phoneDisplay = document.getElementById('phone-display');
const buttons = document.querySelectorAll('.color-button');

// Play the game
function playSequence(seq, index) {
  if (index >= seq.length) {
    awaitingSimon = true;
    changeBtn.style.display = 'inline-block';
    textContent = `Repeat the sequence (${seq.length} steps)`;
    return;
  }
  flash(seq[index]);
  setTimeout(() => playSequence(seq, index + 1), 700);
}

// Make the buttons flash
function flash(color) {
  const button = document.querySelector(`.${color}`);
  button.classList.add('active');
  setTimeout(() => button.classList.remove('active'), 400);
}

// Generate a random color sequence bsaed on num of digits
function generateSequence(length) {
  const newSequence = [];
  for (let i = 0; i < length; i++) {
    const randomColor = colors[Math.floor(Math.random() * colors.length)];
    newSequence.push(randomColor);
  }
  return newSequence;
}

// Update the phone number display
function updatePhoneDisplay() {
  if (phoneNumber.length >= 10) {
    document.getElementById('current-phone').style.display = 'none';
  } else {
    document.getElementById('current-phone').style.display = 'block';
    phoneDisplay.textContent = phoneNumber;
  }
}

// Reset the game
function resetGame() {
  sequence = [];
  userInput = [];
  awaitingSimon = false;
  phoneInput.disabled = false;
  phoneInput.value = '';
  phoneInput.focus();
  textContent = 'Enter next digit';
}

// listener guy for each color button
buttons.forEach(function(button) {
    button.addEventListener('click', function() {
      if (!awaitingSimon) {
        return;
      }
      
      const color = button.classList[1];
      flash(color);
      userInput.push(color);
      
      let correct = true;
      for (let i = 0; i < userInput.length; i++) {
        if (userInput[i] !== sequence[i]) {
          correct = false;
          break;
        }
      }
  
      if (!correct) {
        userInput = [];
        setTimeout(function() {
          playSequence(sequence, 0);
        }, 1000);
      } else if (userInput.length === sequence.length) {
        changeBtn.style.display = 'none';
        phoneNumber += currentDigit;
        updatePhoneDisplay();
        if (phoneNumber.length === 10) {
          phoneInput.disabled = true;
        } else {
          setTimeout(resetGame, 1000);
        }
      }
    });
  });  

// Input the digit and start the game
phoneInput.addEventListener('input', function() {
    const val = phoneInput.value.trim();
    if (!/^[0-9]$/.test(val)) { //check if its a single digit
      phoneInput.value = '';
      return;
    }
    
    phoneInput.disabled = true;
    currentDigit = val;
    sequence = generateSequence(parseInt(val));
    playSequence(sequence, 0);
  });

// Change the current digit if needed
changeBtn.addEventListener('click', () => {
  sequence = [];
  userInput = [];
  awaitingSimon = false;
  currentDigit = 0;
  phoneInput.disabled = false;
  phoneInput.value = '';
  phoneInput.focus();
  textContent = 'Digit canceled. Enter a new digit.';
  updatePhoneDisplay();
  changeBtn.style.display = 'none';
});

updatePhoneDisplay();