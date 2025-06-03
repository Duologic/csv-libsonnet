{
  local COMMA = ',',
  local DQUOTE = '"',
  local TDQUOTE = '""',
  local CR = '\r',
  local LF = '\n',
  local CRLF = CR + LF,

  parse(str):
    local records = self.parseRecords(str);
    local header = records[0];
    [
      std.foldl(
        function(acc, i)
          acc + {
            [header[i]]: record[i],
          },
        std.range(0, std.length(record) - 1),
        {},
      )
      for record in records[1:]
    ],

  parseRecords(str):
    local lexed = self.lex(str);
    local folded = std.foldl(
      function(acc, field)
        local line = field[0];
        local sanitized = self.sanitizeQuotes(field[1]);
        acc + {
          prevLine: line,
          [if acc.prevLine == line then 'record']+: [sanitized],
          [if acc.prevLine != line then 'record']: [sanitized],
          [if acc.prevLine != line then 'records']+: [acc.record],
        },
      lexed,
      { prevLine: 0, records: [] }
    );
    folded.records + [folded.record],

  sanitizeQuotes(str):
    if std.startsWith(str, DQUOTE)
    then std.strReplace(str[1:std.length(str) - 1], TDQUOTE, DQUOTE)
    else str,

  local lex = self.lex,
  lex(str, line=0):
    local field =
      if str[0] == DQUOTE
      then self.lexEscaped(str)
      else self.lexNonEscaped(str);

    [[line, field]]
    + (if !std.member(['', LF, CRLF], str[std.length(field):])
       then
         std.get(
           {
             [COMMA]: lex(str[std.length(field) + 1:], line),
             [LF]: lex(str[std.length(field) + 1:], line + 1),
             [CR]: lex(str[std.length(field) + 2:], line + 1),
           },
           str[std.length(field)],
           error 'unexpected character: ' + str
         )
       else []),

  lexNonEscaped(str):
    local lastCharIndices =
      std.sort(
        std.findSubstr(COMMA, str[1:])
        + std.findSubstr(LF, str[1:])
        + std.findSubstr(CRLF, str[1:])
      );

    local value =
      if std.length(lastCharIndices) == 0
      then str
      else str[0:lastCharIndices[0] + 1];

    if str[0] == ','
    then ''
    else std.stripChars(value, CRLF),

  lexEscaped(str):
    assert str[0] == DQUOTE : 'Expected " but got %s' % str[0];

    local escapedQuotesIndices =
      std.flatMap(
        function(i) [i, i + 1],
        std.findSubstr(TDQUOTE, str[1:])
      );

    local lastCharIndices =
      std.filterMap(
        function(i) !std.member(escapedQuotesIndices, i),
        function(i) i,
        std.findSubstr(DQUOTE, str[1:])
      );

    assert std.length(lastCharIndices) > 0 : 'Unterminated Escaped Field: ' + str;

    local value = str[0:lastCharIndices[0] + 2];

    value,
}
