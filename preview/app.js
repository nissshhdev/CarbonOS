// CarbonOS Interactive Prototype Logic
document.addEventListener('DOMContentLoaded', () => {
  const drawerBtn = document.getElementById('drawer-toggle-btn');
  const drawerMenu = document.getElementById('drawer-menu');
  const themeBtn = document.getElementById('theme-switcher-btn');
  const themeModeText = document.getElementById('theme-mode-text');
  const termThemeVal = document.getElementById('term-theme-val');
  const termWindow = document.getElementById('terminal-window');
  const vboxWindow = document.getElementById('vbox-window');
  const closeVboxBtn = document.getElementById('close-vbox-guide');
  const interactiveInput = document.querySelector('.interactive-input');
  const termHistory = document.querySelector('.terminal-history');

  // Toggle Drawer Menu
  drawerBtn.addEventListener('click', (e) => {
    e.stopPropagation();
    drawerMenu.classList.toggle('hidden');
    drawerBtn.classList.toggle('active');
  });

  document.addEventListener('click', (e) => {
    if (!drawerMenu.contains(e.target) && !drawerBtn.contains(e.target)) {
      drawerMenu.classList.add('hidden');
      drawerBtn.classList.remove('active');
    }
  });

  // Toggle Dark / Light Mode
  function toggleTheme(mode) {
    const isDark = document.body.classList.contains('theme-dark');
    if (mode === 'light' || (mode === undefined && isDark)) {
      document.body.classList.remove('theme-dark');
      document.body.classList.add('theme-light');
      themeModeText.textContent = 'Carbon Light';
      if (termThemeVal) termThemeVal.textContent = 'Carbon-Light';
    } else {
      document.body.classList.remove('theme-light');
      document.body.classList.add('theme-dark');
      themeModeText.textContent = 'Carbon Dark';
      if (termThemeVal) termThemeVal.textContent = 'Carbon-Dark';
    }
  }

  themeBtn.addEventListener('click', () => toggleTheme());

  // App Launchers in Drawer
  document.querySelectorAll('.drawer-item').forEach(item => {
    item.addEventListener('click', () => {
      const app = item.getAttribute('data-app');
      drawerMenu.classList.add('hidden');
      drawerBtn.classList.remove('active');

      if (app === 'theme') {
        toggleTheme();
      } else if (app === 'terminal') {
        termWindow.style.display = 'flex';
        termWindow.style.zIndex = 20;
        vboxWindow.style.zIndex = 10;
      } else if (app === 'vbox') {
        vboxWindow.style.display = 'flex';
        vboxWindow.style.zIndex = 20;
        termWindow.style.zIndex = 10;
      }
    });
  });

  // Desktop Icons
  document.getElementById('icon-theme').addEventListener('click', () => toggleTheme());
  document.getElementById('icon-terminal').addEventListener('click', () => {
    termWindow.style.display = 'flex';
  });
  document.getElementById('icon-docs').addEventListener('click', () => {
    vboxWindow.style.display = 'flex';
  });

  if (closeVboxBtn) {
    closeVboxBtn.addEventListener('click', () => {
      vboxWindow.style.display = 'none';
    });
  }

  // Interactive Terminal Enter handler
  if (interactiveInput) {
    interactiveInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        e.preventDefault();
        const cmd = interactiveInput.innerText.trim();
        executeCommand(cmd);
      }
    });
  }

  function executeCommand(cmd) {
    const outputDiv = document.createElement('div');
    outputDiv.className = 'term-result';

    if (cmd === 'carbon-toggle-theme' || cmd === 'toggle-theme') {
      toggleTheme();
      outputDiv.innerHTML = `<span class="c-green">✓ Switched IBM Carbon Theme.</span>`;
    } else if (cmd === 'fastfetch' || cmd === 'neofetch') {
      outputDiv.innerHTML = `<span class="c-blue">CarbonOS 2026.1 (IBM Carbon Edition) - Fastfetch refreshed.</span>`;
    } else if (cmd === 'drawer' || cmd === 'menu') {
      drawerMenu.classList.remove('hidden');
      outputDiv.innerHTML = `<span class="c-cyan">Opened Drawer applications menu.</span>`;
    } else if (cmd === 'help') {
      outputDiv.innerHTML = `Available commands:<br>  • <span class="c-cyan">carbon-toggle-theme</span> : Switch between Dark/Light mode<br>  • <span class="c-cyan">fastfetch</span> : View system specs and IBM logo<br>  • <span class="c-cyan">drawer</span> : Open application launcher<br>  • <span class="c-cyan">clear</span> : Clear terminal screen`;
    } else if (cmd === 'clear') {
      termHistory.innerHTML = '';
      addNewPromptLine();
      return;
    } else {
      outputDiv.innerHTML = `<span class="c-blue">zsh: command executed: ${cmd}</span>`;
    }

    termHistory.appendChild(outputDiv);
    addNewPromptLine();
  }

  function addNewPromptLine() {
    const promptDiv = document.createElement('div');
    promptDiv.innerHTML = `
      <div class="term-line prompt-line">
        <span class="c-blue">┌──(</span><span class="c-white font-bold">carbon</span><span class="c-blue">@</span><span class="c-cyan">carbon-os</span><span class="c-blue">)-[</span><span class="c-white">~</span><span class="c-blue">]</span>
      </div>
      <div class="term-line prompt-cmd">
        <span class="c-blue">└─</span><span class="c-blue font-bold">$ </span><span class="interactive-input" contenteditable="true" spellcheck="false"></span><span class="cursor">█</span>
      </div>
    `;
    termHistory.appendChild(promptDiv);
    const newInput = promptDiv.querySelector('.interactive-input');
    newInput.focus();
    newInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        e.preventDefault();
        executeCommand(newInput.innerText.trim());
      }
    });
  }

  // Update Clock every second
  function updateClock() {
    const clockEl = document.getElementById('clock-display');
    const now = new Date();
    const options = { weekday: 'short', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' };
    clockEl.textContent = now.toLocaleDateString('en-US', options);
  }
  setInterval(updateClock, 1000);
  updateClock();
});
