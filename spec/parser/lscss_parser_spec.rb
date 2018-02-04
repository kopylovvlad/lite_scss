require './spec/spec_helper'
require './parser/lscss_parser'

RSpec.describe 'LSCSSParser' do
  let(:lscss_text) do
    [
      'nav ul, nav ol {',
      'margin: 0;',
      'padding: 0px;',
      'list-style: none;',
      'font: 12pt/10pt sans-serif;',
      'font: Helvetica, sans-serif;',
      '}',
      '#div1 {',
      'margin: 2220px;',
      'z-index:   9999999;',
      'padding: 0;',
      '.div > p {',
      'font-size: 12px;',
      'color: #123454;',
      'color: #ffffaa;',
      'font: normal small-caps 12px/14px fantasy;',
      'margin: 0px 10px 0px 15px;',
      '$primary_color: #333;',
      '$font-stack:    Helvetica, sans-serif;',
      'body {',
      'font: $font-stack;',
      'color: red;',
      'color: $primary_color;',
      '@mixin border-radius {',
      '-webkit-border-radius: $radius;',
      '-moz-border-radius: $radius;',
      '-ms-border-radius: $radius;',
      'border-radius: $radius;',
      '.box {',
      '@include border-radius;',
      '@mixin red_color {',
      'bolder-color: red;',
      '.superbox {',
      '@include red_color;',
      '.reply-list:before{',
      'span.icon:before {'
    ].join("\n\r")
  end

  let(:spliter_doc_with_description) do
    [
      ['nav ul, nav ol {', 'selector start'],
      ['margin: 0;', 'property'],
      ['padding: 0px;', 'property'],
      ['list-style: none;', 'property'],
      ['font: 12pt/10pt sans-serif;', 'property'],
      ['font: Helvetica, sans-serif;', 'property'],
      ['}', 'selector end'],
      ['#div1 {', 'selector start'],
      ['margin: 2220px;', 'property'],
      ['z-index:   9999999;', 'property'],
      ['padding: 0;', 'property'],
      ['.div > p {', 'selector start'],
      ['font-size: 12px;', 'property'],
      ['color: #123454;', 'property'],
      ['color: #ffffaa;', 'property'],
      ['font: normal small-caps 12px/14px fantasy;', 'property'],
      ['margin: 0px 10px 0px 15px;', 'property'],
      ['$primary_color: #333;', 'variable assinment'],
      ['$font-stack:    Helvetica, sans-serif;', 'variable assinment'],
      ['body {', 'selector start'],
      ['font: $font-stack;', 'property with variable'],
      ['color: red;', 'property'],
      ['color: $primary_color;', 'property with variable'],
      ['@mixin border-radius {', 'mixin start'],
      ['-webkit-border-radius: $radius;', 'property with variable'],
      ['-moz-border-radius: $radius;', 'property with variable'],
      ['-ms-border-radius: $radius;', 'property with variable'],
      ['border-radius: $radius;', 'property with variable'],
      ['.box {', 'selector start'],
      ['@include border-radius;', 'mixin using'],
      ['@mixin red_color {', 'mixin start'],
      ['bolder-color: red;', 'property'],
      ['.superbox {', 'selector start'],
      ['@include red_color;', 'mixin using'],
      ['.reply-list:before{', 'selector start'],
      ['span.icon:before {', 'selector start']
    ].map do |i|
      ParserNodeBuilder.new(i[0]).build
    end
  end

  it 'exists' do
    expect(LSCSSParser.new('').is_a?(LSCSSParser)).to eq(true)
  end

  describe 'spliter_text' do
    it 'works' do
      output = LSCSSParser.new('').spliter_text(lscss_text)
      expect(output).to eq(spliter_doc_with_description)
    end
  end

  describe 'transform_to_nodes' do

    describe 'transform one selector with properties' do
      let(:input) do
        [
          ['nav ul, nav ol {', 'selector start'],
          ['margin: 0;', 'property'],
          ['padding: 0px;', 'property'],
          ['list-style: none;', 'property'],
          ['font: 12pt/10pt sans-serif;', 'property'],
          ['}', 'selector end']
        ].map do |i|
          ParserNodeBuilder.new(i[0]).build
        end
      end

      let(:right_output) do
        [
          AstNodeBuilder.new(
            'Selector.new',
            'nav ul, nav ol',
            [
              AstNodeBuilder.new(
                'Property.new',
                'margin',
                [],
                AstNodeValue.new('VirtualString.new', '0')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'padding',
                [],
                AstNodeValue.new('VirtualString.new', '0px')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'list-style',
                [],
                AstNodeValue.new('VirtualString.new', 'none')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'font',
                [],
                AstNodeValue.new('VirtualString.new', '12pt/10pt sans-serif')
              ).build
            ],
            AstNodeValue.new('', '')
          ).build
        ]
      end

      it 'works' do
        output = LSCSSParser.new('').transform_to_nodes(input)
        expect(output).to eq(right_output)
      end
    end

    describe 'transform selectors' do

      let(:input) do
        [
          ['selector start', "#div1 {"],
          ['property', "margin: 0;"],
          ['property', "padding: 0;"],
          ['property', "list-style: none;"],
          ['selector end', "}"],
          ['selector start', ".div > p {"],
          ['property', "font-size: 12px;"],
          ['property', "color: #123454;"],
          ['property', "font: normal small-caps 12px/14px fantasy;"],
          ['selector end', "}"],
          ['selector start', "ul > li{"],
          ['selector end', "}"]
        ].map do |a, b|
          ParserNodeBuilder.new(b).build
        end
      end

      let(:right_output) do
        [
          AstNodeBuilder.new(
            'Selector.new',
            '#div1',
            [
              AstNodeBuilder.new(
                'Property.new',
                'margin',
                [],
                AstNodeValue.new('VirtualString.new', '0')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'padding',
                [],
                AstNodeValue.new('VirtualString.new', '0')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'list-style',
                [],
                AstNodeValue.new('VirtualString.new', 'none')
              ).build
            ],
            AstNodeValue.new('', '')
          ).build,
          AstNodeBuilder.new(
            'Selector.new',
            '.div > p',
            [
              AstNodeBuilder.new(
                'Property.new',
                'font-size',
                [],
                AstNodeValue.new('VirtualString.new', '12px')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'color',
                [],
                AstNodeValue.new('VirtualString.new', '#123454')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'font',
                [],
                AstNodeValue.new(
                  'VirtualString.new',
                  'normal small-caps 12px/14px fantasy'
                )
              ).build
            ],
            AstNodeValue.new('', '')
          ).build,
          AstNodeBuilder.new(
            'Selector.new',
            'ul > li',
            [],
            AstNodeValue.new('', '')
          ).build
        ]
      end

      it 'works' do
        output = LSCSSParser.new('').transform_to_nodes(input)
        expect(output).to eq(right_output)
      end

    end
  end

  describe 'variable assigns' do
    let(:input) do
      [
        ParserNodeBuilder.new(
          '$font-stack: Helvetica, sans-serif;'
        ).build,
        ParserNodeBuilder.new('$primary-color: #333;').build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'VariableAssign.new',
          'font-stack',
          [],
          AstNodeValue.new('VirtualString.new', 'Helvetica, sans-serif')
        ).build,
        AstNodeBuilder.new(
          'VariableAssign.new',
          'primary-color',
          [],
          AstNodeValue.new('VirtualString.new', '#333')
        ).build
      ]
    end

    it 'works' do
      output = LSCSSParser.new('').transform_to_nodes(input)
      expect(output).to eq(right_output)
    end
  end

  describe 'transform variables' do
    let(:input) do
      [
        ParserNodeBuilder.new(
          '$font-stack: Helvetica, sans-serif;'
        ).build,
        ParserNodeBuilder.new('$primary-color: #333;').build,
        ParserNodeBuilder.new('body {').build,
        ParserNodeBuilder.new('font: $font-stack;').build,
        ParserNodeBuilder.new(
          'color: $primary-color;'
        ).build,
        ParserNodeBuilder.new('font-size: 12px;').build,
        ParserNodeBuilder.new('}').build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'VariableAssign.new',
          'font-stack',
          [],
          AstNodeValue.new('VirtualString.new', 'Helvetica, sans-serif')
        ).build,
        AstNodeBuilder.new(
          'VariableAssign.new',
          'primary-color',
          [],
          AstNodeValue.new('VirtualString.new', '#333')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'body',
          [
            AstNodeBuilder.new(
              'Property.new',
              'font',
              [],
              AstNodeValue.new('Variable.new', 'font-stack')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('Variable.new', 'primary-color')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              'font-size',
              [],
              AstNodeValue.new('VirtualString.new', '12px')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    it 'works' do
      output = LSCSSParser.new('').transform_to_nodes(input)
      expect(output).to eq(right_output)
    end
  end

  describe 'mixin assing and using' do
    let(:input) do
      [
        ParserNodeBuilder.new(
          '@mixin border-radius {'
        ).build,
        ParserNodeBuilder.new(
          '-webkit-border-radius: $radius;'
        ).build,
        ParserNodeBuilder.new(
          '-moz-border-radius: $radius;'
        ).build,
        ParserNodeBuilder.new(
          '-ms-border-radius: $radius;'
        ).build,
        ParserNodeBuilder.new(
          'border-radius: $radius;'
        ).build,
        ParserNodeBuilder.new('}').build,
        ParserNodeBuilder.new(
          '@mixin default_b-radius {'
        ).build,
        ParserNodeBuilder.new(
          'border-radius: 10px;'
        ).build,
        ParserNodeBuilder.new(
          '-webkit-border-radius: 10px;'
        ).build,
        ParserNodeBuilder.new(
          '-moz-border-radius: 10px;'
        ).build,
        ParserNodeBuilder.new(
          '-ms-border-radius: 10px;'
        ).build,
        ParserNodeBuilder.new('}').build,
        ParserNodeBuilder.new('.box {').build,
        ParserNodeBuilder.new('@include border-radius;').build,
        ParserNodeBuilder.new('}').build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'MixinAssign.new',
          'border-radius',
          [
            AstNodeBuilder.new(
              'Property.new',
              '-webkit-border-radius',
              [],
              AstNodeValue.new('Variable.new', 'radius')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              '-moz-border-radius',
              [],
              AstNodeValue.new('Variable.new', 'radius')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              '-ms-border-radius',
              [],
              AstNodeValue.new('Variable.new', 'radius')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              'border-radius',
              [],
              AstNodeValue.new('Variable.new', 'radius')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'MixinAssign.new',
          'default_b-radius',
          [
            AstNodeBuilder.new(
              'Property.new',
              'border-radius',
              [],
              AstNodeValue.new('VirtualString.new', '10px')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              '-webkit-border-radius',
              [],
              AstNodeValue.new('VirtualString.new', '10px')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              '-moz-border-radius',
              [],
              AstNodeValue.new('VirtualString.new', '10px')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              '-ms-border-radius',
              [],
              AstNodeValue.new('VirtualString.new', '10px')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          '.box',
          [
            AstNodeBuilder.new(
              'Mixin.new',
              'border-radius',
              [],
              AstNodeValue.new('', '')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    it 'works' do
      output = LSCSSParser.new('').transform_to_nodes(input)
      expect(output).to eq(right_output)
    end
  end

  describe 'nested' do
    let(:input) do
      'nav {
        ul {
          margin: 0;
          padding: 0;
          list-style: none;
          li {
            display: block;
            color: red;

            p, div {
              display: block;
              color: blue;

              span {
                color: green;
              }
            }
            span {
              color: yellow;
            }
          }
        }
        li { display: inline-block; }
        a {
          display: block;
          padding: 6px 12px;
          text-decoration: none;
        }
      }'
    end

    let(:right_output) do
      [
      AstNodeBuilder.new(
        'Selector.new',
        'nav',
        [
          AstNodeBuilder.new(
            'Selector.new',
            'ul',
            [
              AstNodeBuilder.new(
                'Property.new',
                'margin',
                [],
                AstNodeValue.new('VirtualString.new', '0')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'padding',
                [],
                AstNodeValue.new('VirtualString.new', '0')
              ).build,
              AstNodeBuilder.new(
                'Property.new',
                'list-style',
                [],
                AstNodeValue.new('VirtualString.new', 'none')
              ).build,
              AstNodeBuilder.new(
                'Selector.new',
                'li',
                [
                AstNodeBuilder.new(
                  'Property.new',
                  'display',
                  [],
                  AstNodeValue.new('VirtualString.new', 'block')
                ).build,
                AstNodeBuilder.new(
                  'Property.new',
                  'color',
                  [],
                  AstNodeValue.new('VirtualString.new', 'red')
                ).build,
                AstNodeBuilder.new(
                  'Selector.new',
                  'p, div',
                  [
                  AstNodeBuilder.new(
                    'Property.new',
                    'display',
                    [],
                    AstNodeValue.new('VirtualString.new', 'block')
                  ).build,
                  AstNodeBuilder.new(
                    'Property.new',
                    'color',
                    [],
                    AstNodeValue.new('VirtualString.new', 'blue')
                  ).build,
                  AstNodeBuilder.new(
                    'Selector.new',
                    'span',
                    [
                    AstNodeBuilder.new(
                      'Property.new',
                      'color',
                      [],
                      AstNodeValue.new('VirtualString.new', 'green')
                    ).build
                    ],
                    AstNodeValue.new('', '')
                  ).build
                  ],
                  AstNodeValue.new('', '')
                ).build,
                AstNodeBuilder.new(
                  'Selector.new',
                  'span',
                  [
                  AstNodeBuilder.new(
                    'Property.new',
                    'color',
                    [],
                    AstNodeValue.new('VirtualString.new', 'yellow')
                  ).build
                  ],
                  AstNodeValue.new('', '')
                ).build
                ],
                AstNodeValue.new('', '')
              ).build
            ],
            AstNodeValue.new('', '')
          ).build,
          AstNodeBuilder.new(
            'Selector.new',
            'li',
            [
            AstNodeBuilder.new(
              'Property.new',
              'display',
              [],
              AstNodeValue.new('VirtualString.new', 'inline-block')
            ).build
            ],
            AstNodeValue.new('', '')
          ).build,
          AstNodeBuilder.new(
            'Selector.new',
            'a',
            [
            AstNodeBuilder.new(
              'Property.new',
              'display',
              [],
              AstNodeValue.new('VirtualString.new', 'block')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              'padding',
              [],
              AstNodeValue.new('VirtualString.new', '6px 12px')
            ).build,
            AstNodeBuilder.new(
              'Property.new',
              'text-decoration',
              [],
              AstNodeValue.new('VirtualString.new', 'none')
            ).build
            ],
            AstNodeValue.new('', '')
          ).build
        ],
        AstNodeValue.new('', '')
      ).build
      ]
    end

    it 'works' do
      output = LSCSSParser.new(input).perform
      expect(output).to eq(right_output)
    end
  end
end
