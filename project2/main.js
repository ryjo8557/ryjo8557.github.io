let phoneNumber = '';
let sequence = [];
let userInput = [];
let currentDigit = 0;
let awaitingSimon = false;

const colors = ['green', 'red', 'blue', 'yellow'];

const phoneInput = document.getElementById('phone');
const phoneDisplay = document.getElementById('phone-display');
const buttons = document.querySelectorAll('.color-button');
const status = document.getElementById('status');

function flash(color) {
  const button = document.querySelector(`.${color}`);
  button.classList.add('active');
  setTimeout(() => button.classList.remove('active'), 400);
}

function flashAllRed(callback) {
  buttons.forEach(btn => {
    btn.classList.add('error');
  });
  setTimeout(() => {
    buttons.forEach(btn => btn.classList.remove('error'));
    if (callback) callback();
  }, 500);
}

function playSequence(seq, index) {
  if (index === 0) {
    status.textContent = 'Watch the sequence';
    phoneInput.disabled = true;
  }

  if (index >= seq.length) {
    awaitingSimon = true;
    status.textContent = `Repeat the sequence (${seq.length} steps)`;
    phoneInput.disabled = false;
    return;
  }

  flash(seq[index]);
  setTimeout(() => playSequence(seq, index + 1), 700);
}

function addToSequence() {
  const randomColor = colors[Math.floor(Math.random() * colors.length)];
  sequence.push(randomColor);
}

function updatePhoneDisplay() {
  if (phoneNumber.length >= 10) {
    document.getElementById('current-phone').style.display = 'none';
  } else {
    document.getElementById('current-phone').style.display = 'block';
    phoneDisplay.textContent = phoneNumber;
  }
}

function resetGame() {
  userInput = [];
  awaitingSimon = false;
  phoneInput.disabled = false;
  phoneInput.value = '';
  phoneInput.focus();
  status.textContent = 'Enter next digit';
}

buttons.forEach(function (button) {
  button.addEventListener('click', function () {
    if (!awaitingSimon) return;

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
      flashAllRed(() => playSequence(sequence, 0));
    } else if (userInput.length === sequence.length) {
      phoneNumber += currentDigit;
      updatePhoneDisplay();

      if (phoneNumber.length === 10) {
        phoneInput.disabled = true;
        status.textContent = 'Phone number submitted!';
      } else {
        setTimeout(resetGame, 1000);
      }
    }
  });
});

phoneInput.addEventListener('input', function () {
  const val = phoneInput.value.trim();
  if (!/^[0-9]$/.test(val)) {
    phoneInput.value = '';
    return;
  }

  phoneInput.disabled = true;
  currentDigit = val;
  phoneInput.value = '';

  addToSequence();
  playSequence(sequence, 0);
});

updatePhoneDisplay();