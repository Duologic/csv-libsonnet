{
  local this = self,

  parse(str):
    local lined = this.lines(str);
    local header = lined[0];
    [
      std.foldl(
        function(acc, i)
          acc + {
            [header[i]]: this.sanitizeQuotes(line[i]),
          },
        std.range(0, std.length(line) - 1),
        {},
      )
      for line in lined[1:]
    ],

  sanitizeQuotes(str):
    if std.startsWith(str, '"')
    then std.strReplace(str[1:std.length(str) - 1], '""', '"')
    else str,

  lines(str):
    local lexed = this.lex(str);
    local folded = std.foldl(
      function(acc, field)
        acc + {
          prev: field[0],
          [if acc.prev == field[0] then 'row']+: [field[1]],
          [if acc.prev != field[0] then 'row']: [field[1]],
          [if acc.prev != field[0] then 'rows']+: [acc.row],
        },
      lexed,
      { prev: 0 }
    );
    folded.rows + [folded.row],

  lex(str, line=0):
    local field =
      if str[0] == '"'
      then this.lexQuoted(str)
      else this.lexField(str);

    [[line, field]]
    + (if str[std.length(field):] != '\n'
          && str[std.length(field):] != '\r\n'
          && str[std.length(field):] != ''
       then
         std.get(
           {
             '\n': this.lex(str[std.length(field) + 1:], line + 1),
             '\r': this.lex(str[std.length(field) + 2:], line + 1),
             ',': this.lex(str[std.length(field) + 1:], line),
           },
           str[std.length(field)],
           error 'unexpected character: ' + str
         )
       else []),

  lexField(str):
    local lastCharIndices = std.sort(
      std.map(function(i) i + 1, std.findSubstr(',', str[1:]))
      + std.map(function(i) i + 1, std.findSubstr('\n', str[1:]))
      + std.flatMap(function(i) [i + 1] + [i + 2], std.findSubstr('\r\n', str[1:]))
    );

    local value =
      if std.length(str) == 1
         || std.length(lastCharIndices) == 0
      then str
      else str[0:lastCharIndices[0]];

    value,

  lexQuoted(str):
    assert str[0] == '"' : 'Expected " but got %s' % str[0];

    local findLastChar = std.map(function(i) i + 1, std.findSubstr('"', str[1:]));
    local findEscapedChar = std.flatMap(function(i) [i + 1] + [i + 2], std.findSubstr('""', str[1:]));

    local lastCharIndices = std.filter(function(e) !std.member(findEscapedChar, e), findLastChar);

    assert std.length(lastCharIndices) > 0 : 'Unterminated Quoted Field: ' + str;

    local value = str[0:lastCharIndices[0] + 1];

    value,
}
