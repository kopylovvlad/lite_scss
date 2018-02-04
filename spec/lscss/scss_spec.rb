require './spec/spec_helper'
require './lscss/lscss'

RSpec.describe 'SCSS' do
  it 'works with scss' do
    input_str = '$blue: #3bbfce;
$margin: 16px;
$link: #15157d;
$link_bottom: #15157d;
$input_font_size: 13px;
$content_bg: #F1F1F1;
$input_color: #4E4D4D;
$input_color_placeholder: #959595;
$text_color: black;

.content-navigation {
  border-color: $blue;
  color: $blue;
}

.border {
  padding: $margin;
  margin: $margin;
  border-color: $blue;
}
a { color: $link; }
span.link {
  color: $link;
  text-decoration: underline;
}

$title-font: normal 24px/1.5 "Open Sans", sans-serif;
$cool-red: #F44336;
$box-shadow-bottom-only: 0 2px 1px 0 rgba(0, 0, 0, 0.2);

h1.title {
  font: $title-font;
  color: $cool-red;
}

div.container {
  color: $cool-red;
  background: #fff;
  width: 100%;
  box-shadow: $box-shadow-bottom-only;
}


@mixin square {
  width: 20px;
  height: 20px;
  background-color: rgb(0,0,255);
}

.small-blue-square {
  @include square;
}

.big-red-square {
  @include square;
}

$tilt: rotate(15deg);
@mixin transform-tilt {

  -webkit-transform: $tilt; /* Ch <36, Saf 5.1+, iOS, An =<4.4.4 */
      -ms-transform: $tilt; /* IE 9 */
          transform: $tilt; /* IE 10, Fx 16+, Op 12.1+ */
}

.frame:hover {
  @include transform-tilt;
}

$awesome-blue: #2196F3;

a {
  padding: 10px 15px;
  background-color: $awesome-blue;
}

a:hover {
  background-color: $awesome-blue;
}'

    output_str = '.content-navigation {
  border-color: #3bbfce;
  color: #3bbfce;
}
.border {
  padding: 16px;
  margin: 16px;
  border-color: #3bbfce;
}
a {
  color: #15157d;
}
span.link {
  color: #15157d;
  text-decoration: underline;
}
h1.title {
  font: normal 24px/1.5 "Open Sans", sans-serif;
  color: #F44336;
}
div.container {
  color: #F44336;
  background: #fff;
  width: 100%;
  box-shadow: 0 2px 1px 0 rgba(0, 0, 0, 0.2);
}
.small-blue-square {
  width: 20px;
  height: 20px;
  background-color: rgb(0,0,255);
}
.big-red-square {
  width: 20px;
  height: 20px;
  background-color: rgb(0,0,255);
}
.frame:hover {
  -webkit-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  transform: rotate(15deg);
}
a {
  padding: 10px 15px;
  background-color: #2196F3;
}
a:hover {
  background-color: #2196F3;
}'

    output_css = LSCSS::MainMachine.new(input_str).perform
    expect(output_css).to eq(output_str)
  end

  it 'works with nested scss' do
    input_str = '$blueprint-grid-columns:     5;
$blueprint-grid-width:       150px;
$blueprint-grid-margin:      20px;

$blueprint-font-family:      Helvetica Neue, Arial, Helvetica, sans-serif;
$blueprint-fixed-font-family: "andale mono", "lucida console", monospace;
$blueprint-font-size:        12px;

$text-color:                 #555555;
$light-text-color:           #a0a0a0;
$quote-text-color:           #f27a00;
$disclosure-text-color:      #ed7c06;

$thick-border:               8px solid black;
$dotted-border:              1px dotted #999999;

$header-background-color:    #f07c05;
$paging-background-color:    black;
$unfocused-background-color: #f1f0ec;
$quote-background-color:     #f1f0ec;

$story-title-color:          #f07c05;

$tilt: rotate(15deg);
@mixin transform-tilt {
  -webkit-transform: $tilt;
      -ms-transform: $tilt;
          transform: $tilt;
}

@mixin ffont {
  color: $text-color;
  height: 15px;
  font-size: 15px;
}

body {
  background-color: $unfocused-background-color;
  background: url("/images/white-bg.jpg") repeat-y 50% 0;
  color: $text-color;
}

.content_wrapper {
  width: 910px;
}

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

      text-color: $light-text-color;
    }
  }

  ul {
    padding: 0 0 0 25px;
    li {
      padding: 0 20px 0 0;
      text-transform: uppercase;
      a {

        border: $dotted-border;
        color: #febf0f;
        text-decoration: none;
        width: 100px;
        height: 72px;
        display: block;
      }
    }
  }
}

#paging {
  background: $paging-background-color;
  height: 33px;
  padding: 15px 0 0 0;

  h6 {
    color: #908f8b;
    padding-right: 20px;
    text-transform: uppercase;
    @include transform-tilt;

    a {
      color: #f07b07;
      text-decoration: none;
      @include ffont;
    }
  }

  ul {
    @include ffont;
    li {
      padding: 3px 4px;
      a {
        color: #4c4c4c;
        width: 10px;
        height: 10px;
        display: block;

        @include transform-tilt;
      }
    }
  }

  @include ffont;
}

#content {
    position: relative;
    #previous {
      position: absolute;
      top: 0;
      left: 0;
      text-align: right;
      @include ffont;
    }
    #next {
      position: absolute;
      top: 0;
      right: 0;
      text-align: left;
      @include transform-tilt;
    }
}

#thread {
  width: 910px;
  top: 0px;
  left: 0px;
}

.js {
  @include transform-tilt;
  #content {
    overflow: hidden;
    width: 100%;
  }

  #thread {
    padding: 0;
    width: 5000px;
    position: absolute;
  }
}

.story {
  width: 810px;
  padding: 0 50px;

  h4.date {
    background: $unfocused-background-color;
    padding: 10px 20px;
  }

  h1 {
    padding: 40px 0 20px 0;
    border-bottom: $thick-border;
    color: $story-title-color;
  }

  .artifacts {

    .row {
      border-bottom: $dotted-border;
      margin-bottom: $blueprint-grid-margin;
      @include transform-tilt;
    }

    .artifact {
      color: $light-text-color;
      img {
        margin-bottom: 0.5em;
        @include ffont;
      }
      a {
        font-weight: bold;
        text-decoration: none;
        color: #0a83e0;
        color: red;
      }
    }

  }

  .information {
    border-bottom: $dotted-border;
    margin-left: 40px;

    .quote {
      color: $quote-text-color;
      blockquote {
        color: $quote-text-color;
        margin: 0;
        padding: 12px 18px;
        background: $quote-background-color;
      }
      cite {
        @include ffont;
        display: block;
        padding: 0.5em 18px 1.5em 18px;
      }
    }

    .disclosure {
      border-top: $dotted-border;
      h5 {
        padding: 10px 0;
        margin: 0;
        color: $disclosure-text-color;
      }
      p {
        color: #a8a8a8;
      }
    }
  }
}

#footer {
  background: white;
  width: 810px;
  padding: $blueprint-grid-margin;

  .inner {
    border-top: $thick-border;
    @include ffont;
    padding: 30px 0;
  }

  p {
    color: #b3b3b3;
  }

  ul {

    li {
      padding: 0 30px 0 0;
      a {
        text-decoration: none;
        color: #ef7a06;
      }
    }
  }
}'
    output_str = 'body {
  background-color: #f1f0ec;
  background: url("/images/white-bg.jpg") repeat-y 50% 0;
  color: #555555;
}
.content_wrapper {
  width: 910px;
}
#header {
  height: 72px;
  background: #f07c05;
  text-color: #a0a0a0;
}
#header h1 {
  color: white;
  text-color: #f27a00;
  color: #555555;
  height: 15px;
  font-size: 15px;
}
#header h1 a {
  width: 116px;
  height: 72px;
  display: block;
  text-decoration: none;
  text-color: #a0a0a0;
}
#header ul {
  padding: 0 0 0 25px;
}
#header ul li {
  padding: 0 20px 0 0;
  text-transform: uppercase;
}
#header ul li a {
  border: 1px dotted #999999;
  color: #febf0f;
  text-decoration: none;
  width: 100px;
  height: 72px;
  display: block;
}
#paging {
  background: black;
  height: 33px;
  padding: 15px 0 0 0;
  color: #555555;
  height: 15px;
  font-size: 15px;
}
#paging h6 {
  color: #908f8b;
  padding-right: 20px;
  text-transform: uppercase;
  -webkit-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  transform: rotate(15deg);
}
#paging h6 a {
  color: #f07b07;
  text-decoration: none;
  color: #555555;
  height: 15px;
  font-size: 15px;
}
#paging ul {
  color: #555555;
  height: 15px;
  font-size: 15px;
}
#paging ul li {
  padding: 3px 4px;
}
#paging ul li a {
  color: #4c4c4c;
  width: 10px;
  height: 10px;
  display: block;
  -webkit-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  transform: rotate(15deg);
}
#content {
  position: relative;
}
#content #previous {
  position: absolute;
  top: 0;
  left: 0;
  text-align: right;
  color: #555555;
  height: 15px;
  font-size: 15px;
}
#content #next {
  position: absolute;
  top: 0;
  right: 0;
  text-align: left;
  -webkit-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  transform: rotate(15deg);
}
#thread {
  width: 910px;
  top: 0px;
  left: 0px;
}
.js {
  -webkit-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  transform: rotate(15deg);
}
.js #content {
  overflow: hidden;
  width: 100%;
}
.js #thread {
  padding: 0;
  width: 5000px;
  position: absolute;
}
.story {
  width: 810px;
  padding: 0 50px;
}
.story h4.date {
  background: #f1f0ec;
  padding: 10px 20px;
}
.story h1 {
  padding: 40px 0 20px 0;
  border-bottom: 8px solid black;
  color: #f07c05;
}
.story .artifacts .row {
  border-bottom: 1px dotted #999999;
  margin-bottom: 20px;
  -webkit-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  transform: rotate(15deg);
}
.story .artifacts .artifact {
  color: #a0a0a0;
}
.story .artifacts .artifact img {
  margin-bottom: 0.5em;
  color: #555555;
  height: 15px;
  font-size: 15px;
}
.story .artifacts .artifact a {
  font-weight: bold;
  text-decoration: none;
  color: #0a83e0;
  color: red;
}
.story .information {
  border-bottom: 1px dotted #999999;
  margin-left: 40px;
}
.story .information .quote {
  color: #f27a00;
}
.story .information .quote blockquote {
  color: #f27a00;
  margin: 0;
  padding: 12px 18px;
  background: #f1f0ec;
}
.story .information .quote cite {
  color: #555555;
  height: 15px;
  font-size: 15px;
  display: block;
  padding: 0.5em 18px 1.5em 18px;
}
.story .information .disclosure {
  border-top: 1px dotted #999999;
}
.story .information .disclosure h5 {
  padding: 10px 0;
  margin: 0;
  color: #ed7c06;
}
.story .information .disclosure p {
  color: #a8a8a8;
}
#footer {
  background: white;
  width: 810px;
  padding: 20px;
}
#footer .inner {
  border-top: 8px solid black;
  color: #555555;
  height: 15px;
  font-size: 15px;
  padding: 30px 0;
}
#footer p {
  color: #b3b3b3;
}
#footer ul li {
  padding: 0 30px 0 0;
}
#footer ul li a {
  text-decoration: none;
  color: #ef7a06;
}'

    output_css = LSCSS::MainMachine.new(input_str).perform
    expect(output_css).to eq(output_str)
  end
end
