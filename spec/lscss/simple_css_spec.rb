require './spec/spec_helper'
require './lscss/lscss'

RSpec.describe 'Simple CSS' do
  it 'works with css' do
    input_css_string = '.reply-list:before {
  display: none;
}
.reply-list li::before {
  background: #c7cacb none repeat scroll 0 0;
  content: "";
  height: 2px;
  left: -88px;
  position: absolute;
  top: 39px;
  width: 88px;
}
.comments-list li {
  display: block;
  margin-bottom: 50px;
  position: relative;
}
.comments-list li:after {
  content: '';
  display: block;
  clear: both;
  height: 0;
  width: 0;
}
.reply-list {
  clear: both;
  margin-top: 35px;
  padding-left: 138px;
}
.comments-list .comment-avatar {
  border: 5px solid #fff;
  border-radius: 4px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
  float: left;
  height: 100px;
  overflow: hidden;
  position: relative;
  width: 100px;
  z-index: 2;
}
.comments-list .comment-avatar img {
  height: 100%;
  width: 100%;
}
.reply-list .comment-avatar {
  height: 80px;
  width: 80px;
}
.comment-main-level::after {
  clear: both;
  content: "";
  display: block;
  height: 0;
  width: 0;
}
.comments-list .comment-box {
  border: 1px solid #e5e5e5;
  float: right;
  position: relative;
  width: 84%;
}
.comments-list .comment-box:before,
.comments-list .comment-box:after {
  content: "";
  height: 0;
  width: 0;
  position: absolute;
  display: block;
  border-width: 10px 12px 10px 0;
  border-style: solid;
  border-color: transparent #f1f1f1;
  top: 8px;
  left: -11px;
}
.comments-list .comment-box::before {
  border-color: transparent #ddd;
  border-width: 11px 11px 9px 0;
  left: -12px;
}
.reply-list .comment-box {
  width: 85%;
}
.comment-box .comment-head {
  background: #f1f1f1;
  padding: 10px 12px;
  border-bottom: 1px solid #ddd;
  overflow: hidden;
  -webkit-border-radius: 4px 4px 0 0;
  -moz-border-radius: 4px 4px 0 0;
  border-radius: 4px 4px 0 0;
}
.comment-box .comment-head i {
  float: right;
  margin-left: 14px;
  position: relative;
  top: 2px;
  color: #A6A6A6;
  cursor: pointer;
  -webkit-transition: color 0.3s ease;
  -o-transition: color 0.3s ease;
  transition: color 0.3s ease;
}
.comment-box .comment-head i:hover {
  color: #8ec448;
}
.comment-box .comment-name {
  color: #555;
  display: inline-block;
  float: left;
  font-size: 14px;
  font-weight: 700;
  margin-bottom: 0;
  margin-top: 0;
  margin-right: 10px;
}
.comment-box .comment-head span {
  color: #999;
  float: left;
  font-size: 12px;
  line-height: 16px;
  position: relative;
}
.comment-box .comment-content {
  padding: 12px;
  -webkit-border-radius: 0 0 4px 4px;
  -moz-border-radius: 0 0 4px 4px;
  border-radius: 0 0 4px 4px;
}
.hand-hover {
  cursor: pointer;
}
.hamburger-inner,.hamburger-inner::after,.hamburger-inner::before {
  width: 37px;
  height: 1px;
  border-radius: 0;
}
[data-icon]:before {
  font-family: "et-line";
  content: attr(data-icon);
  speak: none;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  display: inline-block;
}
.et-icon-mobile, .et-icon-laptop, .et-icon-desktop, .et-icon-tablet, .et-icon-phone, .et-icon-document, .et-icon-documents, .et-icon-search, .et-icon-clipboard, .et-icon-newspaper, .et-icon-notebook, .et-icon-book-open, .et-icon-browser, .et-icon-calendar, .et-icon-presentation, .et-icon-picture, .et-icon-pictures, .et-icon-video, .et-icon-camera, .et-icon-printer, .et-icon-toolbox, .et-icon-briefcase, .et-icon-wallet, .et-icon-gift, .et-icon-bargraph, .et-icon-grid, .et-icon-expand, .et-icon-focus, .et-icon-edit, .et-icon-adjustments, .et-icon-ribbon, .et-icon-hourglass, .et-icon-lock, .et-icon-megaphone, .et-icon-shield, .et-icon-trophy, .et-icon-flag, .et-icon-map, .et-icon-puzzle, .et-icon-basket, .et-icon-envelope, .et-icon-streetsign, .et-icon-telescope, .et-icon-gears, .et-icon-key, .et-icon-paperclip, .et-icon-attachment, .et-icon-pricetags, .et-icon-lightbulb, .et-icon-layers, .et-icon-pencil, .et-icon-tools, .et-icon-tools-2, .et-icon-scissors, .et-icon-paintbrush, .et-icon-magnifying-glass, .et-icon-circle-compass, .et-icon-linegraph, .et-icon-mic, .et-icon-strategy, .et-icon-beaker, .et-icon-caution, .et-icon-recycle, .et-icon-anchor, .et-icon-profile-male, .et-icon-profile-female, .et-icon-bike, .et-icon-wine, .et-icon-hotairballoon, .et-icon-globe, .et-icon-genius, .et-icon-map-pin, .et-icon-dial, .et-icon-chat, .et-icon-heart, .et-icon-cloud, .et-icon-upload, .et-icon-download, .et-icon-target, .et-icon-hazardous, .et-icon-piechart, .et-icon-speedometer, .et-icon-global, .et-icon-compass, .et-icon-lifesaver, .et-icon-clock, .et-icon-aperture, .et-icon-quote, .et-icon-scope, .et-icon-alarmclock, .et-icon-refresh, .et-icon-happy, .et-icon-sad, .et-icon-facebook, .et-icon-twitter, .et-icon-googleplus, .et-icon-rss, .et-icon-tumblr, .et-icon-linkedin, .et-icon-dribbble {
  font-family: "et-line";
  speak: none;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  display: inline-block;
}
.et-icon-mobile:before {
  content: "\e000";
}
.et-icon-laptop:before {
  content: "\e001";
}
.et-icon-desktop:before {
  content: "\e002";
}
.et-icon-tablet:before {
  content: "\e003";
}
.et-icon-phone:before {
  content: "\e004";
}
.et-icon-document:before {
  content: "\e005";
}'

    output_css = LSCSS::MainMachine.new(input_css_string).perform
    expect(output_css).to eq(input_css_string)
  end
end
