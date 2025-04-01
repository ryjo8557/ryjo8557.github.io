
class Keyboard {
    constructor(gameManager) {
        this.gameManager = gameManager;
        this.initializeKeyboard();
    }
    
    initializeKeyboard() {
        // Event listener for Keys.
        document.querySelectorAll('.key:not(#enter-key):not(#backspace-key)').forEach(key => {
            key.addEventListener('click', () => this.handleKeyClick(key.innerText));
        });

        // Event listener for Enter and Backspace.
        document.getElementById('enter-key').addEventListener('click', () => this.handleKeyClick('Enter'));
        document.getElementById('backspace-key').addEventListener('click', () => this.handleKeyClick('Backspace'));
        
        // Key Listener
        document.addEventListener('keydown', (event) => {
            const key = event.key.toUpperCase();
            if (key === 'ENTER') {
                this.handleKeyClick('Enter');
            } else if (key === 'BACKSPACE') {
                this.handleKeyClick('Backspace');
            } else if (/^[A-Z]$/.test(key)) {
                this.handleKeyClick(key);
            }
        });
    }
    
    handleKeyClick(key) {
        this.gameManager.handleInput(key);
    }
    
    updateKeyColor(letter, color) {
        document.querySelectorAll('.key').forEach(key => {
            if (key.innerText === letter) {
                switch(color) {
                    case 'green':
                        key.style.backgroundColor = '#538d4e';
                        break;
                    case 'yellow':
                        if (key.style.backgroundColor !== 'rgb(83, 141, 78)') { // #538d4e
                            key.style.backgroundColor = '#b59f3b';
                        }
                        break;
                    case 'grey':
                        if (key.style.backgroundColor !== 'rgb(83, 141, 78)' && 
                            key.style.backgroundColor !== 'rgb(181, 159, 59)') {
                            key.style.backgroundColor = '#3a3a3c';
                        }
                        break;
                }
            }
        });
    }
}
