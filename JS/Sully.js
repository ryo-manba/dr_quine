function execute(command) {
  const { exec } = require("child_process");

  exec(command, (err, stdout, stderr) => {
    if (err) {
      process.stderr.write(stderr);
      return;
    }
    process.stdout.write(stdout);
  });
}

function quine() {
  const fs = require("fs");
  let i = 5;
  if (process.env.CHILD) {
    i--;
  }
  if (i < 0) {
    return;
  }

  const filename = `Sully_${i}.js`;
  const code = `${execute.toString()}\n
${quine.toString().replace(/let i = \d/, `let i = ${i}`)}\n\nquine();\n`;

  fs.writeFile(filename, code, function (err) {
    if (err) {
      return console.error(err);
    }
  });

  execute(`CHILD=${i} node ${filename}`);
}

quine();
