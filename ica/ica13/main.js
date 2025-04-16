const canvas = document.querySelector("canvas");
const ctx = canvas.getContext("2d");

const width = canvas.width = window.innerWidth;
const height = canvas.height = window.innerHeight;

function random(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomRGB() {
  return `rgb(${random(0, 255)} ${random(0, 255)} ${random(0, 255)})`;
}

class Ball {
  constructor(x, y, velX, velY, color, size) {
    this.x = x;
    this.y = y;
    this.velX = velX;
    this.velY = velY;
    this.color = color;
    this.size = size;
  }

  draw() {
    ctx.beginPath();
    ctx.fillStyle = this.color;
    ctx.arc(this.x, this.y, this.size, 0, 2 * Math.PI);
    ctx.fill();
  }

  update() {
    if ((this.x + this.size) >= width) {
      this.velX = -this.velX;
    }

    if ((this.x - this.size) <= 0) {
      this.velX = -this.velX;
    }

    if ((this.y + this.size) >= height) {
      this.velY = -this.velY;
    }

    if ((this.y - this.size) <= 0) {
      this.velY = -this.velY;
    }

    this.x += this.velX;
    this.y += this.velY;
  }

  collisionDetect() {
    for (let j = 0; j < balls.length; j++) {
      if (!(this === balls[j])) {
        const dx = this.x - balls[j].x;
        const dy = this.y - balls[j].y;
        const distance = Math.sqrt(dx * dx + dy * dy);

        if (distance < this.size + balls[j].size) {
          // bounce baby bounce
          const angle = Math.atan2(dy, dx);

          const speed1 = this.velX * Math.cos(angle) + this.velY * Math.sin(angle);
          const speed2 = balls[j].velX * Math.cos(angle) + balls[j].velY * Math.sin(angle);

          if (speed1 - speed2 < 0) {
            let tempVelX = this.velX;
            let tempVelY = this.velY;
            this.velX = balls[j].velX;
            this.velY = balls[j].velY;
            balls[j].velX = tempVelX;
            balls[j].velY = tempVelY;
          }
        }
      }
    }
  }
}

const balls = [];

while (balls.length < 25) {
    const size = random(10, 20);
    const speed = 5;
    const angle = Math.random() * Math.PI * 2;
  
    const velX = Math.cos(angle) * speed;
    const velY = Math.sin(angle) * speed;
  
    const ball = new Ball(
      random(size, canvas.width - size),
      random(size, canvas.height - size),
      velX,
      velY,
      randomRGB(),
      size
    );
  
    balls.push(ball);
  }
  
function loop() {
  ctx.fillStyle = "rgb(0 0 0 / 25%)";
  ctx.fillRect(0, 0, width, height);

  for (const ball of balls) {
    ball.draw();
    ball.update();
    ball.collisionDetect();
  }

  requestAnimationFrame(loop);
}

loop();