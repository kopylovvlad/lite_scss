require './spec/spec_helper'
require './transformer/lscss_transformer'
require './transformer/lib/ast_node_value'
require './transformer/lib/ast_node_builder'
require './transformer/lib/ast_transformer'

RSpec.describe 'LSCSSTransformer' do
  it 'exists' do
    expect(LSCSSTransformer.new([]).is_a?(LSCSSTransformer)).to eq(true)
  end

  describe 'transform a selector with properties' do
    let(:ast_before) do
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

    let(:ast_after) do
      [
        Selector.new(
          'nav ul, nav ol',
          [
            Property.new('margin', VirtualString.new('0')),
            Property.new('padding', VirtualString.new('0px')),
            Property.new('list-style', VirtualString.new('none')),
            Property.new('font', VirtualString.new('12pt/10pt sans-serif')),
          ]
        )
      ]
    end

    it 'works' do
      ast = AstToMachine.new(ast_before).perform
      expect(ast).to eq(ast_after)
    end
  end

  describe 'transform selectors' do
    let(:ast_before) do
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

    let(:ast_after) do
      [
        Selector.new(
          '#div1',
          [
            Property.new('margin', VirtualString.new('0')),
            Property.new('padding', VirtualString.new('0')),
            Property.new('list-style', VirtualString.new('none'))
          ]
        ),
        Selector.new(
          '.div > p',
          [
            Property.new('font-size', VirtualString.new('12px')),
            Property.new('color', VirtualString.new('#123454')),
            Property.new(
              'font',
              VirtualString.new('normal small-caps 12px/14px fantasy')
            )
          ]
        ),
        Selector.new('ul > li', [])
      ]
    end

    it 'works' do
      ast = AstToMachine.new(ast_before).perform
      expect(ast).to eq(ast_after)
    end
  end


  # HERE:
  describe 'transform variable assing' do
    let(:input) do
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

    let(:right_output) do
      [
        VariableAssign.new(
          :'font-stack',
          VirtualString.new('Helvetica, sans-serif')
        ),
        VariableAssign.new(
          :'primary-color',
          VirtualString.new('#333')
        )
      ]
    end

    it 'works' do
      ast = AstToMachine.new(input).perform
      expect(ast).to eq(right_output)
    end
  end

  describe 'transform variables' do
    let(:input) do
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

    let(:right_output) do
      [
        VariableAssign.new(
          :'font-stack',
          VirtualString.new('Helvetica, sans-serif')
        ),
        VariableAssign.new(
          :'primary-color',
          VirtualString.new('#333')
        ),
        Selector.new(
          'body',
          [
            Property.new(
              'font',
              Variable.new(:'font-stack')
            ),
            Property.new(
              'color',
              Variable.new(:'primary-color')
            ),
            Property.new(
              'font-size',
              VirtualString.new('12px')
            )
          ]
        )
      ]
    end

    it 'works' do
      ast = AstToMachine.new(input).perform
      expect(ast).to eq(right_output)
    end
  end


  describe 'transform mixins' do
    let(:input) do
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
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          '.magicbox',
          [
            AstNodeBuilder.new(
              'Mixin.new',
              'border-radius',
              [],
              AstNodeValue.new('', '')
            ).build,
            AstNodeBuilder.new(
              'Mixin.new',
              'default_b-radius',
              [],
              AstNodeValue.new('', '')
            ).build,
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    let(:right_output) do
      [
        MixinAssign.new(
          :'border-radius',
          [
            Property.new(
              '-webkit-border-radius',
              Variable.new(:radius)
            ),
            Property.new(
              '-moz-border-radius',
              Variable.new(:radius)
            ),
            Property.new(
              '-ms-border-radius',
              Variable.new(:radius)
            ),
            Property.new(
              'border-radius',
              Variable.new(:radius)
            )
          ]
        ),
        MixinAssign.new(
          :'default_b-radius',
          [
            Property.new(
              'border-radius',
              VirtualString.new('10px')
            ),
            Property.new(
              '-webkit-border-radius',
              VirtualString.new('10px')
            ),
            Property.new(
              '-moz-border-radius',
              VirtualString.new('10px')
            ),
            Property.new(
              '-ms-border-radius',
              VirtualString.new('10px')
            )
          ]
        ),
        Selector.new(
          '.box',
          [Mixin.new(:'border-radius')]
        ),
        Selector.new(
          '.magicbox',
          [
            Mixin.new(:'border-radius'),
            Mixin.new(:'default_b-radius')
          ]
        )
      ]
    end

    it 'works' do
      ast = AstToMachine.new(input).perform
      expect(ast).to eq(right_output)
    end
  end

  describe 'transformer 1' do
    let(:input) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'nav',
          [
            AstNodeBuilder.new(
              'Property.new',
              'font-size',
              [],
              AstNodeValue.new('VirtualString.new', '12px')
            ).build,
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
                ).build
              ],
              AstNodeValue.new('', '')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'nav',
          [
            AstNodeBuilder.new(
              'Property.new',
              'font-size',
              [],
              AstNodeValue.new('VirtualString.new', '12px')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'nav ul',
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
        ).build
      ]
    end

    it 'works' do
      ast = AstTransformer.new(input).perform
      expect(ast).to eq(right_output)
    end
  end

  describe 'transformer 2 (optimize)' do
    let(:input) do
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
                ).build
              ],
              AstNodeValue.new('', '')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'nav ul',
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
        ).build
      ]
    end

    it 'works' do
      ast = AstTransformer.new(input).perform
      expect(ast).to eq(right_output)
    end
  end

  describe 'transformer 3 (combinate)' do
    let(:input) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'div, p, section',
          [
            AstNodeBuilder.new(
              'Selector.new',
              'ul, ol, li,',
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
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'div ul, div ol, div li, p ul, p ol, p li, section ul, section ol, section li',
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
        ).build
      ]
    end

    it 'works' do
      ast = AstTransformer.new(input).perform
      expect(ast).to eq(right_output)
    end
  end

  describe 'transformer 4 (nested combinate)' do
    let(:input) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'div, p, section',
          [
            AstNodeBuilder.new(
              'Selector.new',
              'ul, ol, li,',
              [
                AstNodeBuilder.new(
                  'Selector.new',
                  'span, i',
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
                ).build
              ],
              AstNodeValue.new('', '')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'div ul span, div ul i, div ol span, div ol i, div li span, div li i, p ul span, p ul i, p ol span, p ol i, p li span, p li i, section ul span, section ul i, section ol span, section ol i, section li span, section li i',
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
        ).build
      ]
    end

    it 'works' do
      ast = AstTransformer.new(input).perform
      expect(ast).to eq(right_output)
    end
  end

  describe 'transformer 5 (deep combinate)' do
    let(:input) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'div, p, section',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'yellow')
            ).build,
            AstNodeBuilder.new(
              'Selector.new',
              'ul, ol, li,',
              [
                AstNodeBuilder.new(
                  'Property.new',
                  'color',
                  [],
                  AstNodeValue.new('VirtualString.new', 'red')
                ).build,
                AstNodeBuilder.new(
                  'Selector.new',
                  'span, i',
                  [
                    AstNodeBuilder.new(
                      'Property.new',
                      'color',
                      [],
                      AstNodeValue.new('VirtualString.new', 'blue')
                    ).build
                  ],
                  AstNodeValue.new('', '')
                ).build
              ],
              AstNodeValue.new('', '')
            ).build,
            AstNodeBuilder.new(
              'Selector.new',
              'span, i',
              [
                AstNodeBuilder.new(
                  'Property.new',
                  'color',
                  [],
                  AstNodeValue.new('VirtualString.new', 'green')
                ).build
              ],
              AstNodeValue.new('', '')
            ).build,
            AstNodeBuilder.new(
              'Selector.new',
              'span > blink',
              [
                AstNodeBuilder.new(
                  'Property.new',
                  'color',
                  [],
                  AstNodeValue.new('VirtualString.new', 'brown')
                ).build
              ],
              AstNodeValue.new('', '')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'p',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'pink')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    let(:right_output) do
      [
        AstNodeBuilder.new(
          'Selector.new',
          'div, p, section',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'yellow')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'div ul, div ol, div li, p ul, p ol, p li, section ul, section ol, section li',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'red')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'div ul span, div ul i, div ol span, div ol i, div li span, div li i, p ul span, p ul i, p ol span, p ol i, p li span, p li i, section ul span, section ul i, section ol span, section ol i, section li span, section li i',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'blue')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'div span, div i, p span, p i, section span, section i',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'green')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'div span > blink, p span > blink, section span > blink',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'brown')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build,
        AstNodeBuilder.new(
          'Selector.new',
          'p',
          [
            AstNodeBuilder.new(
              'Property.new',
              'color',
              [],
              AstNodeValue.new('VirtualString.new', 'pink')
            ).build
          ],
          AstNodeValue.new('', '')
        ).build
      ]
    end

    it 'works' do
      ast = AstTransformer.new(input).perform
      expect(ast).to eq(right_output)
    end
  end
end
