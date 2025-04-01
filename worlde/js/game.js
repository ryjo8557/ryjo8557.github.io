class WordleGame {
    constructor() {
        this.solution = '';
        this.gameState = {
            guesses: [],
            currentGuess: '',
            currentRowIndex: 0,
            previousLength: 0,
            gameOver: false
        };
        
        this.initializeGameGrid();
        this.keyboard = new Keyboard(this);
        this.initializeGame();
    }
    
    async initializeGame() {
        try {
            const response = await fetch('data/wordlist.json');
            const wordList = await response.json();
            
            // Fetch word list.
            const allWords = Object.values(wordList).flat();
            this.solution = allWords[Math.floor(Math.random() * allWords.length)].toUpperCase();
            
            // For Development.
            console.log('Solution:', this.solution);
            
            return this.solution;
        } catch (error) {
            console.error('Error initializing game:', error);
            return null;
        }
    }
    
    initializeGameGrid() {
        const gridContainer = document.getElementById('grid-container');
        gridContainer.innerHTML = '';
        
        for (let row = 0; row < 6; row++) {
            const gridRow = document.createElement('div');
            gridRow.className = 'grid-row';
            
            for (let col = 0; col < 5; col++) {
                const gridSquare = document.createElement('div');
                gridSquare.className = 'grid-square';
                gridSquare.id = `square-${row * 5 + col}`;
                gridRow.appendChild(gridSquare);
            }
            
            gridContainer.appendChild(gridRow);
        }
    }
    
    handleInput(key) {
        if (this.gameState.gameOver) {
            return;
        }
        
        if (key === 'Enter') {
            this.submitGuess();
            return;
        }

        if (key === 'Backspace') {
            this.deleteLastLetter();
            return;
        }

        if (/^[A-Z]$/.test(key) && this.gameState.currentGuess.length < 5) {
            this.addLetter(key);
        }
    }
    
    addLetter(letter) {
        if (this.gameState.currentGuess.length < 5) {
            this.gameState.currentGuess += letter;
            this.updateDisplay();
        }
    }
    
    deleteLastLetter() {
        if (this.gameState.currentGuess.length > 0) {
            this.gameState.currentGuess = this.gameState.currentGuess.slice(0, -1);
            this.updateDisplay();
        }
    }
    
    submitGuess() {
        if (this.gameState.currentGuess.length === 5) {
            const colors = this.checkWord(this.gameState.currentGuess);
            this.updateColors(this.gameState.currentRowIndex, colors);
            
            for (let i = 0; i < 5; i++) {
                const letter = this.gameState.currentGuess[i];
                this.keyboard.updateKeyColor(letter, colors[i]);
            }
            
            this.gameState.guesses.push(this.gameState.currentGuess);
            
            if (this.gameState.currentGuess === this.solution) {
                this.gameWon();
                return;
            }
            
            if (this.gameState.currentRowIndex >= 5) {
                this.gameLost();
                return;
            }
            
            this.gameState.currentRowIndex++;
            this.gameState.currentGuess = '';
            this.gameState.previousLength = 0;
        }
    }
    
    checkWord(guess) {
        const result = new Array(5).fill('grey');
        const solutionChars = this.solution.split('');
        const guessChars = guess.split('');
        
        for (let i = 0; i < 5; i++) {
            if (guessChars[i] === solutionChars[i]) {
                result[i] = 'green';
                solutionChars[i] = null;
                guessChars[i] = null;
            }
        }
        
        for (let i = 0; i < 5; i++) {
            if (guessChars[i] !== null) {
                const index = solutionChars.indexOf(guessChars[i]);
                if (index !== -1) {
                    result[i] = 'yellow';
                    solutionChars[index] = null;
                }
            }
        }
        
        return result;
    }
    
    updateColors(rowIndex, colors) {
        const startIndex = rowIndex * 5;
        
        colors.forEach((color, index) => {
            setTimeout(() => {
                const square = document.getElementById(`square-${startIndex + index}`);
                square.classList.add('flip');
                
                setTimeout(() => {
                    switch (color) {
                        case 'grey':
                            square.style.backgroundColor = '#3a3a3c';
                            square.style.border = '2px solid #3a3a3c';
                            break;
                        case 'yellow':
                            square.style.backgroundColor = '#b59f3b';
                            square.style.border = '2px solid #b59f3b';
                            break;
                        case 'green':
                            square.style.backgroundColor = '#538d4e';
                            square.style.border = '2px solid #538d4e';
                            break;
                    }
                }, 300);
                
                setTimeout(() => {
                    square.classList.remove('flip');
                }, 600);
            }, index * 250);
        });
    }
    
    updateDisplay() {
        const startIndex = this.gameState.currentRowIndex * 5;
        const currentLength = this.gameState.currentGuess.length;
        
        for (let i = 0; i < 5; i++) {
            const square = document.getElementById(`square-${startIndex + i}`);
            square.innerText = i < currentLength ? this.gameState.currentGuess[i] : '';
            
            if (i < currentLength) {
                square.style.borderColor = '#fff';
            } else {
                square.style.borderColor = '#565a5f';
            }
        }
        
        if (currentLength > this.gameState.previousLength) {
            const lastIndex = startIndex + currentLength - 1;
            const square = document.getElementById(`square-${lastIndex}`);
            square.classList.add('animate');
            setTimeout(() => square.classList.remove('animate'), 200);
        }
        
        this.gameState.previousLength = currentLength;
    }
    
    gameWon() {
        this.gameState.gameOver = true;
        setTimeout(() => {
            alert('Congratulations! You guessed the word!');
        }, 1500);
    }
    
    gameLost() {
        this.gameState.gameOver = true;
        setTimeout(() => {
            alert(`Game over! The word was: ${this.solution}`);
        }, 1500);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new WordleGame();
});