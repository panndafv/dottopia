// The double-click launcher (start.bat, start-mac.command, start-linux.sh): starts the private
// dev world (server/dev.mjs) and opens it in the browser as soon as it answers. Nothing here is needed to
// run DOTOPIA from a terminal; `npm run dev` does the same without opening a browser.
import { spawn } from 'node:child_process';
import http from 'node:http';

const major = +process.versions.node.split('.')[0];
if (major < 20) {
  console.error(`DOTOPIA needs Node.js 20 or newer, and this computer has ${process.version}.`);
  console.error('Install the LTS version from https://nodejs.org/ and run this again.');
  process.exit(1);
}

const PORT = process.env.PORT || '5183';
process.env.PORT = PORT;
const URL = `http://localhost:${PORT}/?dev`; // ?dev: speed controls, so you can watch days go by in seconds

let opened = false;
function openBrowser() {
  if (opened) return;
  opened = true;
  const cmd = process.platform === 'win32' ? `start "" "${URL}"` : process.platform === 'darwin' ? `open "${URL}"` : `xdg-open "${URL}"`;
  const child = spawn(cmd, { shell: true, stdio: 'ignore', detached: true, windowsHide: true });
  child.on('error', () => {}); // no browser opener on this system: the URL is printed below anyway
  child.unref();
  console.log('');
  console.log(`DOTOPIA is open in your browser at ${URL}`);
  console.log('Close this window (or press Ctrl+C) to stop. The world is saved and carries on next time.');
  console.log('');
}

// is a DOTOPIA already answering on this port?
function isRunning(cb) {
  const req = http.get(`http://127.0.0.1:${PORT}/health`, { timeout: 1500 }, (res) => { res.resume(); cb(res.statusCode === 200); });
  req.on('timeout', () => req.destroy());
  req.on('error', () => cb(false));
}

// knock on the door every half second until the world answers, then open the page
function poll(tries) {
  isRunning((up) => { if (up) openBrowser(); else if (tries < 120) setTimeout(() => poll(tries + 1), 500); });
}

isRunning((up) => {
  if (up) {
    console.log('DOTOPIA is already running on this computer. Opening it.');
    openBrowser();
    setTimeout(() => process.exit(0), 1500);
    return;
  }
  // something that is not DOTOPIA holds the port: say so instead of crashing with a stack trace
  process.on('uncaughtException', (err) => {
    if (err && err.code === 'EADDRINUSE') {
      console.error(`Something else is already using port ${PORT}. Close it, or run this with PORT set to another number.`);
      process.exit(1);
    }
    console.error(err);
    process.exit(1);
  });
  console.log('Starting DOTOPIA, a private world on this computer...');
  poll(0);
  import('./dev.mjs');
});
