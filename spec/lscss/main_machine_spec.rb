require './spec/spec_helper'
require './lscss/lscss'

RSpec.describe 'LSCSS::MainMachine' do

  it 'works with lscss' do
    input_lscss_string = '
/*
2018 year
lscss
*/
nav ul, nav ol {margin: 0;padding: 0px;list-style: none;font: 12pt/10pt sans-serif;}
#div1 {
  margin: 0;
  padding: 0;
  list-style: none;
}
/* variables */
$other-color: green;
$main_color: green;
$second_color: yellow;
$std_border: 2px solid black;
$context-box-value: 0 0 4px 4px;

/* mixins */
@mixin border-radius {
  -webkit-border-radius: 10px;
     -moz-border-radius: 10px;
      -ms-border-radius: 10px;
          border-radius: 10px;
}
@mixin main_font {
  font-size: 14px;
  font-weight: 700;
}
@mixin context-box {
  -webkit-border-radius: $context-box-value;
  -moz-border-radius: $context-box-value;
  border-radius: $context-box-value;
}

/* something */
.div > p {
  font-size: 12px;
  color: #123454;
  font: normal small-caps 12px/14px fantasy;
}
.div > p.sttt {}
/**
.comments-list li {
  display: block;
  margin-bottom: 50px;
  position: relative;
}
.reply-list {
  clear: both;
  margin-top: 35px;
  padding-left: 138px;
}
*/
p,li,h1 {
  color: $main_color;
}

/* other comment */

p {
  color: $second_color;
  width: 500px;
  border: $std_border;
}
.bad_div {
  color: $second_color;
  border: $std_border;
}
.bad_p {
  color: $main_color;
  color: $other-color;
}

/* mixin using  */
.box { @include border-radius; }
.hamburg {
  @include main_font;
}

.hamburg_box {
  color: #999;
  float: left;
  font-size: 12px;
  @include main_font;
  @include border-radius;
}
.comment-box .comment-content {
  padding: 12px;
  @include context-box;
}
'

    right_output_css_string = 'nav ul, nav ol {
  margin: 0;
  padding: 0px;
  list-style: none;
  font: 12pt/10pt sans-serif;
}
#div1 {
  margin: 0;
  padding: 0;
  list-style: none;
}
.div > p {
  font-size: 12px;
  color: #123454;
  font: normal small-caps 12px/14px fantasy;
}
.div > p.sttt {
}
p,li,h1 {
  color: green;
}
p {
  color: yellow;
  width: 500px;
  border: 2px solid black;
}
.bad_div {
  color: yellow;
  border: 2px solid black;
}
.bad_p {
  color: green;
  color: green;
}
.box {
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  -ms-border-radius: 10px;
  border-radius: 10px;
}
.hamburg {
  font-size: 14px;
  font-weight: 700;
}
.hamburg_box {
  color: #999;
  float: left;
  font-size: 12px;
  font-size: 14px;
  font-weight: 700;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  -ms-border-radius: 10px;
  border-radius: 10px;
}
.comment-box .comment-content {
  padding: 12px;
  -webkit-border-radius: 0 0 4px 4px;
  -moz-border-radius: 0 0 4px 4px;
  border-radius: 0 0 4px 4px;
}'

    output_css = LSCSS::MainMachine.new(input_lscss_string).perform
    expect(output_css).to eq(right_output_css_string)
  end
end
