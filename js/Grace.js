const fs = require("fs");
const filename = "Grace_kid.js";
(function quine() {
  // No macros in JS, using IIFE.
  const code = `const fs = require("fs");\nconst filename = "${filename}";\n(${quine.toString()})();\n`;
  fs.writeFile(filename, code, function (err) {
    if (err) {
      return console.error(err);
    }
  });
})();
