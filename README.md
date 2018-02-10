
# Lite SCSS
Lite SCSS (lscss) is a little pet project. I wrote it to practice how to write a compiler. It is an attempt to implement a compiler like SASS. I wrote it just for fun.

# Features
* Multiline comments
```scss
/*
it is a comment.
:-)
*/
p { color: red; }
/* another comment */
```

* Variables
```scss
$other-color: green;
$main_color: green;
$second_color: yellow;

p {
  color: $second_color;
  width: 500px;
  border: $std_border;
}
.bad_div {
  color: $second_color;
  border: $std_border;
}
```

* Mixins
```scss
$tilt: rotate(15deg);

@mixin transform-tilt {
  -webkit-transform: $tilt;
      -ms-transform: $tilt;
          transform: $tilt;
}
@mixin square {
  width: 20px;
  height: 20px;
  background-color: rgb(0,0,255);
}

.small-blue-square {
  @include square;
}
.frame:hover {
  @include transform-tilt;
}
```

* Nesting
```scss
#header {
  height: 72px;
  background: $header-background-color;
  text-color: $light-text-color;

  h1 {
    color: white;
    text-color: $quote-text-color;
    @include ffont;

    a {
      width: 116px;
      height: 72px;
      display: block;
      text-decoration: none;
    }
  }

  ul {
    padding: 0 0 0 25px;
    li {
      padding: 0 20px 0 0;
      text-transform: uppercase;
      a {
        width: 100px;
        height: 72px;
        display: block;
      }
    }
  }
}
```

# Constraints
* Variables and mixins can not be nested
* Mixins don't support arguments

# Example of usage

You can see some example files in source/ folder.
After running command you can see compiled css files in css/ folder
```shell
./bin/lscss compile source/example1.lscss css/example1.css
./bin/lscss compile source/example2.lscss css/example2
./bin/lscss compile source/example3.lscss css/example3
```

## helpers
rubocop
```shell
./bin/rubocop
```

rubycritic
```shell
./bin/rubycritic
```
