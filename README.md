# csv-libsonnet

Jsonnet library to parse CSV files.

Tested with test suite from [csv-spectrum](https://github.com/max-mapper/csv-spectrum).

## Usage

```
local parser = import 'github.com/Duologic/csv-libsonnet/main.libsonnet';
local csv = importstr 'path/to/your.csv';

parser.parse(csv)
```
