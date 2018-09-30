# ezrgif

GIF effects from the CLI.

## Get it

```sh
docker pull quay.io/sergey_grebenshchikov/ezrgif
docker tag quay.io/sergey_grebenshchikov/ezrgif ezrgif
```

## Use it

```sh
$ docker run --rm -i ezrgif -h
Usage:
    ezrgif (roll | wobble | pulse | zoom | shake | optimize) [ -h ] [ OPTIONS ]
```


## Example

```sh
$ alias gif="docker run -i --rm ezrgif"
```
```sh
$ <doc/moth.png | gif pulse -0 1.0 -1 1.5 -n 20 | gif wobble -d 3x100 -p 100% -c 100% | gif optimize > doc/moth.gif
```

![before](doc/moth.png)![after](doc/moth.gif)
