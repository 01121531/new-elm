/**
 * cron: 11 8,13,20 * * *
 * 只添加这个定时就可以了
 */
const { exec } = require('child_process');

function runScript(scriptPath) {
  return new Promise((resolve, reject) => {
    const command = `node ${scriptPath}`;
    const childProcess = exec(command);
    childProcess.stdout.on('data', (data) => {
      console.log(`${data}`);
    });

    childProcess.stderr.on('data', (data) => {
      console.error(`[${scriptPath}] stderr: ${data}`);
    });

    childProcess.on('close', (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Script ${scriptPath} exited with code ${code}`));
      }
    });
  });
}

const scripts = [
  '/ql/data/scripts/xiaodan01/ele_check_ck.js',
  '/ql/data/scripts/xiaodan01/ele_2048.js',
  '/ql/data/scripts/xiaodan01/ele_elge.js',
  '/ql/data/scripts/xiaodan01/ele_hctmm',
  '/ql/data/scripts/xiaodan01/ele_cycg.js',
  '/ql/data/scripts/xiaodan01/ele_mst.js',
  '/ql/data/scripts/xiaodan01/ele_lyb.js',
  '/ql/data/scripts/xiaodan01/ele_assest.js'
];


async function runScripts() {
  for (const script of scripts) {
   // console.log(`查找: ${script}`);
    try {
      await runScript(script);
    } catch (error) {
      console.error(`Error running script ${script}:`, error);
    }
  }
}

// 执行所有脚本
runScripts();
