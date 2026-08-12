/* Kanakku & ERP Theme Switcher Script */
(function () {
    function getSavedTheme() {
        return localStorage.getItem('theme') || 'dark';
    }

    function applyTheme(theme) {
        var isLight = (theme === 'light');
        document.documentElement.setAttribute("data-bs-theme", isLight ? "light" : "dark");
        document.documentElement.setAttribute('data-theme', isLight ? "light" : "dark");
        
        if (document.body) {
            if (isLight) {
                document.body.classList.add('light-mode');
                document.body.setAttribute('data-theme', 'light');
            } else {
                document.body.classList.remove('light-mode');
                document.body.setAttribute('data-theme', 'dark');
            }
        }

        var btnIcon = document.getElementById('theme_toggle_icon');
        var btn = document.getElementById('theme_toggle_btn');
        if (btnIcon) {
            if (isLight) {
                btnIcon.className = 'fa-solid fa-moon fs-14';
                btnIcon.style.color = '#7539FF';
            } else {
                btnIcon.className = 'fa-solid fa-sun fs-14';
                btnIcon.style.color = '#FBBF24';
            }
        }
        if (btn) {
            btn.title = isLight ? "Switch to Dark Mode" : "Switch to Light Mode";
        }
    }

    // Apply immediately to avoid flash
    var currentTheme = getSavedTheme();
    document.documentElement.setAttribute("data-bs-theme", currentTheme === 'light' ? "light" : "dark");
    document.documentElement.setAttribute('data-theme', currentTheme === 'light' ? "light" : "dark");

    document.addEventListener("DOMContentLoaded", function () {
        applyTheme(getSavedTheme());

        var toggleBtn = document.getElementById('theme_toggle_btn');
        if (toggleBtn) {
            toggleBtn.addEventListener('click', function (e) {
                e.preventDefault();
                var activeTheme = (document.body && document.body.classList.contains('light-mode')) ? 'light' : 'dark';
                var newTheme = (activeTheme === 'dark') ? 'light' : 'dark';
                localStorage.setItem('theme', newTheme);
                applyTheme(newTheme);
            });
        }
    });
})();
