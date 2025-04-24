let phoneNumber = '';
let sequence = [];
let userInput = [];
let currentDigit = 0;
let awaitingSimon = false;

const colors = ['green', 'red', 'blue', 'yellow'];

const phoneInput = document.getElementById('phone');
const changeBtn = document.getElementById('change-digit');
const phoneDisplay = document.getElementById('phone-display');
const status = document.getElementById('status');
const buttons = document.querySelectorAll('.color-button');

// Play the game
function playSequence(seq, index) {
  if (index >= seq.length) {
    awaitingSimon = true;
    changeBtn.style.display = 'inline-block';
    status.textContent = `Repeat the sequence (${seq.length} steps)`;
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
  status.textContent = 'Enter next digit';
}

// listener guy for each color button
buttons.forEach(button => {
  button.addEventListener('click', () => {
    if (!awaitingSimon) return;
    const color = button.classList[1];
    flash(color);
    userInput.push(color);
    const correct = userInput.every((c, i) => c === sequence[i]);
    if (!correct) {
      status.textContent = 'Wrong! Try again.';
      userInput = [];
      setTimeout(() => playSequence(sequence, 0), 1000);
    } else if (userInput.length === sequence.length) {
      changeBtn.style.display = 'none';
      phoneNumber += currentDigit;
      updatePhoneDisplay();
      status.textContent = 'Correct!';
      if (phoneNumber.length === 10) {
        status.textContent = `${phoneNumber} submitted, thank you!`;
        phoneInput.disabled = true;
      } else {
        setTimeout(resetGame, 1000);
      }
    }
  });
});

// Input the digit and start the game
phoneInput.addEventListener('input', () => {
  const val = phoneInput.value.trim();
  if (!/^[0-9]$/.test(val)) {
    phoneInput.value = '';
    return;
  }
  phoneInput.disabled = true;
  currentDigit = val;
  sequence = generateSequence(parseInt(val));
  status.textContent = 'Watch the sequence...';
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
  status.textContent = 'Digit canceled. Enter a new digit.';
  updatePhoneDisplay();
  changeBtn.style.display = 'none';
});

updatePhoneDisplay();