function quine() {
  console.log(
    quine.toString() +
      "\n\n" +
      "// Outside comment\n" +
      main.toString() +
      "\n\n" +
      "main();"
  );
}

// Outside comment
function main() {
  // Inside comment
  quine();
}

main();
