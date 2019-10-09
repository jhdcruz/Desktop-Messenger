const { app, BrowserWindow, Tray, Menu } = require("electron");
const gotTheLock = app.requestSingleInstanceLock();

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let win;

function createWindow() {
  // Create the browser window.
  win = new BrowserWindow({
    width: 620,
    height: 700,
    frame: false,
    webPreferences: {
      plugins: true,
      webviewTag: true,
      nodeIntegration: true
    }
  });
  win.setMinimumSize(500, 600);

  // and load the index.html of the app.
  win.loadFile(`app/index.html`);

  // Open DevTools
  // win.webContents.openDevTools({ mode: 'undocked' })

  // Emitted when the window is closed.
  win.on("closed", () => {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    win = null;
  });
}

// Single Instance Lock
if (!gotTheLock) {
  app.quit();
} else {
  app.on("second-instance", () => {
    // Someone tried to run a second instance, we should focus our window.
    if (win) {
      if (!win.isVisible()) win.show();
      win.focus();
    }
  });
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Wait until the app is ready
app.once("ready", () => {
  // Starts Browser
  createWindow();

  let tray = null;

  // Creates a tray
  tray = new Tray("icon.ico");

  // Context Menu
  const contextMenu = Menu.buildFromTemplate([
    {
      label: "Show/Hide Desktop Messenger",
      accelerator: "CmdOrCtrl+Q",
      click: function() {
        win.isVisible() ? win.hide() : win.show();
      }
    },
    {
      label: "Reload",
      accelerator: "CmdOrCtrl+R",
      click: function() {
        win.reload();
      }
    },
    {
      label: "Clear Data/Logout",
      accelerator: "CmdOrCtrl+D",
      click: function() {
        win.webContents.session.clearStorageData(function() {
          console.log("Data Cleaned");
        });

        app.relaunch() && app.quit();
      }
    },
    {
      type: "separator"
    },
    {
      label: "Quit",
      accelerator: "CmdOrCtrl+X",
      click: function() {
        app.quit();
      }
    }
  ]);

  tray.on("double-click", () => {
    win.isVisible() ? win.hide() : win.show();
  });

  tray.on("right-click", function() {
    contextMenu();
  });

  win.on("show", () => {
    tray.setHighlightMode("always");
  });

  win.on("hide", () => {
    tray.setHighlightMode("never");
  });

  tray.setToolTip("Desktop Messenger");
  tray.setContextMenu(contextMenu);
});

// Quit when all windows are closed.
// app.on('window-all-closed', () => {
// On macOS it is common for applications and their menu bar
// to stay active until the user quits explicitly with Cmd + Q
//   if (process.platform !== 'darwin') {
//     app.quit()
//   }
// })

app.on("activate", () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (win === null) {
    createWindow();
    win.focus();
  }
});
