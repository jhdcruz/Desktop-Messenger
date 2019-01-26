const electronTitlebarWindows = require('electron-titlebar-windows');
const { remote } = require('electron');
/** Options */
let titlebar = new electronTitlebarWindows({
    color: 'rgb(48, 48, 48)',
    backgroundColor: 'rgb(255, 255, 255)',
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
    remote.getCurrentWindow().close();
});
/** Event#fullscreen */
titlebar.on('fullscreen', () => {
    console.info('fullscreen');
    remote.getCurrentWindow().setFullScreen(true);
});
/** Event#minimize */
titlebar.on('minimize', () => {
    console.info('minimize');
    remote.getCurrentWindow().minimize();
});
/** Event#maximize */
titlebar.on('maximize', () => {
    console.info('maximize');
    remote.getCurrentWindow().setFullScreen(false);
    remote.getCurrentWindow().maximize();
});

// source: `https://github.com/sidneys/electron-titlebar-windows/blob/master/app/main.html`