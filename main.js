async function renderEULA() {
    const eulaText = document.querySelector('.eula-text');
    const eulaContent = await fetch('/EULA.md');
    eulaText.innerHTML = marked.parse(await eulaContent.text());
}

renderEULA();

const acceptButton = document.querySelector('#accept-eula');
acceptButton.addEventListener('change', () => {
    const downloadButton = document.querySelector('#dwnldbtn');
    downloadButton.disabled = !acceptButton.checked;
});