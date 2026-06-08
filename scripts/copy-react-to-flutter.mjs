import fs from 'node:fs';
import path from 'node:path';

const source = path.resolve('dist');
const target = path.resolve('flutter_shell/assets/react_ui');

if (!fs.existsSync(source)) {
  console.error('Missing dist folder. Run npm run build first.');
  process.exit(1);
}

fs.rmSync(target, { recursive: true, force: true });
fs.mkdirSync(target, { recursive: true });
fs.cpSync(source, target, { recursive: true });
console.log(`Copied ${source} to ${target}`);
