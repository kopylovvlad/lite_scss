require './spec/spec_helper'
require './compiler/lscss_compiler'
Dir['./transformer/lib/*.rb'].each { |file| require file }

RSpec.describe 'LSCSSCompiler' do
  it 'exists' do
    expect(LSCSSCompiler.new([]).is_a?(LSCSSCompiler)).to eq(true)
  end

  describe 'run' do

    let(:input) do
      [
        VariableAssign.new(:main_color, VirtualString.new('green')),
        VariableAssign.new(:second_color, VirtualString.new('yellow')),
        VariableAssign.new(:std_border, VirtualString.new('2px solid black')),
        MixinAssign.new(
          :test_mixin,
          [
            Property.new('width', VirtualString.new('500px')),
            Property.new('height', VirtualString.new('700px'))
          ]
        ),
        MixinAssign.new(
          :main_font,
          [
            Property.new('font-family', VirtualString.new('"Times New Roman", Times, serif')),
            Property.new('font-style', VirtualString.new('italic')),
            Property.new('font-size', VirtualString.new('29px')),
            Property.new('font-weight', VirtualString.new('normal'))
          ]
        ),
        Selector.new(
          'p,li,h1',
          [
            Property.new('color', Variable.new(:main_color))
          ]
        ),
        Selector.new(
          'div',
          [
            Property.new('width', VirtualString.new('200px'))
          ]
        ),
        Selector.new(
          'p',
          [
            Property.new('color', Variable.new(:second_color)),
            Property.new('width', VirtualString.new('500px')),
            Property.new('border', Variable.new(:std_border))
          ]
        ),
        Selector.new(
          '.bad_div',
          [
            Property.new('color', Variable.new(:second_color)),
            Property.new('border', Variable.new(:std_border))
          ]
        ),
        Selector.new(
          '.bad_p',
          [
            Property.new('color', Variable.new(:main_color)),
            Property.new('color', Variable.new(:main_color))
          ]
        ),
        Selector.new(
          'div > p.main',
          [Mixin.new(:test_mixin)]
        ),
        Selector.new(
          '#hello_div',
          [
            Mixin.new(:main_font)
          ]
        ),
        Selector.new(
          '#hello_div2',
          [
            Mixin.new(:main_font),
            Property.new('font-weight', VirtualString.new('bold'))
          ]
        )
      ]
    end

    let(:output) do
      [

        'p,li,h1 {',
        '  color: green;',
        '}',
        'div {',
        '  width: 200px;',
        '}',
        'p {',
        '  color: yellow;',
        '  width: 500px;',
        '  border: 2px solid black;',
        '}',
        '.bad_div {',
        '  color: yellow;',
        '  border: 2px solid black;',
        '}',
        '.bad_p {',
        '  color: green;',
        '  color: green;',
        '}',
        'div > p.main {',
        '  width: 500px;',
        '  height: 700px;',
        '}',
        '#hello_div {',
        '  font-family: "Times New Roman", Times, serif;',
        '  font-style: italic;',
        '  font-size: 29px;',
        '  font-weight: normal;',
        '}',
        '#hello_div2 {',
        '  font-family: "Times New Roman", Times, serif;',
        '  font-style: italic;',
        '  font-size: 29px;',
        '  font-weight: normal;',
        '  font-weight: bold;',
        '}'
      ].join("\n")
    end

    it 'works' do
      document = LSCSSCompiler.new(input).run
      expect(document).to eq(output)
    end
  end
end
