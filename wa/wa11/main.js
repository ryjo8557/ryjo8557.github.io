const displayedImage = document.querySelector('.displayed-img');
const thumbBar = document.querySelector('.thumb-bar');
const btn = document.querySelector('button');
const overlay = document.querySelector('.overlay');

const imageFilenames = ['pic1.jpg', 'pic2.jpg', 'pic3.jpg', 'pic4.jpg', 'pic5.jpg'];
const imageAlts = [
  'Hollow Knight bench in Queens Garden',
  'Quirrel and the Knight',
  'The Hive Knight',
  'Hornet from Silksong',
  'Hornet and the Knight fighting'
];

for (let i = 0; i < imageFilenames.length; i++) {
  const newImage = document.createElement('img');
  newImage.src = 'images/' + imageFilenames[i];
  newImage.alt = imageAlts[i];
  thumbBar.appendChild(newImage);

  newImage.addEventListener('click', function () {
    displayedImage.src = newImage.src;
    displayedImage.alt = newImage.alt;
  });
}

btn.addEventListener('click', function () {
  const isDark = btn.className === 'dark';

  if (isDark) {
    btn.className = 'light';
    btn.textContent = 'Lighten';
    overlay.style.backgroundColor = 'rgb(0 0 0 / 50%)';
  } else {
    btn.className = 'dark';
    btn.textContent = 'Darken';
    overlay.style.backgroundColor = 'rgb(0 0 0 / 0%)';
  }
});