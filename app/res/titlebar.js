const electronTitlebarWindows = require('electron-titlebar-windows');
const { remote } = require('electron');
/** Options */
let titlebar = new electronTitlebarWindows({
    darkMode: true,
    color: 'rgb(230, 230, 230)',
    backgroundColor: 'rgb(50, 50, 50)',
    draggable: true,
    fullscreen: false
});
/**
 * DOM
 */
titlebar.appendTo();
/** Event#close */
titlebar.on('close', () => {
    console.info('close');
    remote.getCurrentWindow().hide();
});
/** Event#fullscreen */
titlebar.on('fullscreen', () => {
    let window = remote.BrowserWindow.getFocusedWindow();
    window.isMaximized() ? window.unmaximize() : window.maximize();
});
/** Event#minimize */
titlebar.on('minimize', () => {
    console.info('minimize');
    remote.getCurrentWindow().minimize();
});
/** Event#maximize */
titlebar.on('maximize', () => {
    console.info('maximize');
    let window = remote.BrowserWindow.getFocusedWindow();
    window.isMaximized() ? window.unmaximize() : window.maximize();
});

// source: `https://github.com/sidneys/electron-titlebar-windows/blob/master/app/main.html`