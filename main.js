async function renderEULA() {
    const eulaText = document.querySelector('.eula-text');
    const eulaContent = await fetch('eula.md');
    eulaText.innerHTML = marked.parse(await eulaContent.text());
}

renderEULA();