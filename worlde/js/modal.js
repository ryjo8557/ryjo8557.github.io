document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('instructions-modal');
    const helpButton = document.getElementById('help-button');
    const closeButton = document.querySelector('.close');
    
    // Show Modal
    helpButton.addEventListener('click', () => {
        modal.style.display = 'flex';
    });
    
    // Close Modal
    closeButton.addEventListener('click', () => {
        modal.style.display = 'none';
    });
    
    // Close Modal
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
    
    // Show OnLoad
    modal.style.display = 'flex';
});