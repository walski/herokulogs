# Herokulogs

A tool to get a clear view on log tails of heroku apps

## Usage

```
$ heroku logs --tail | herokulogs FORMAT
```

### Format options:

```
2: http status
b: bytes
c: connect time
d: date
f: fwd IP
h: host
l: log level
m: method
p: path
s: service time
t: type
y: dyno
```

## Examples

```
# Log status code, HTTP method and path:
$ heroku logs --tail | herokulogs.rb 2mp
```

Optionally you can add a second paramter which is interpreted as a Ruby regex that has to match on the raw log line in order to print it to STDOUT.

```
# Log path only when it comes from a web dyno
$ heroku logs --tail | herokulogs p "dyno=web\.\d+"
```