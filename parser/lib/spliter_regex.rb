# rubocop:disable Metrics/LineLength
# rubocop:disable Style/RegexpLiteral
class SpliterRegex
  SELECTOR_START = /^[\w|\-|\,|\.|\>|\#| |\:|\[|\]]*\{/
  PROPERTY = /^[[^\$|\,|\.|\>|\#]|a-z|A-Z|\-|\_]*\: ?[\s|\d|a-z|A-Z|\#|\/|\-|\,|\(|\)|\.|\%|\'|\"|\\]*\;$/
  SELECTOR_END = /\}$/
  VARIABLE_ASSINMENT = /^\$[[^\,|\.|\>|\#|\-]|a-z|A-Z|\-|\_]*\: [\s|\d|a-z|A-Z|\#|\/|\-|\,|\(|\)|\.|\%|\'|\"|\\]*\;$/
  PROP_WITH_VALUE = /^[[^\$|\,|\.|\>|\#]|a-z|A-Z|\-|\_]*\: \$[\s|\d|a-z|A-Z|\#|\/|\-|\_]*\;$/
  MIXIN = /@mixin [\-|\_|\s|a-z|A-Z]*\{$/
  MIXIN_USING = /@include [\-|\_|a-z|A-Z]*\;/
  VARIABLE_NAME = /^([[^\,|\.|\>|\#|\s]|a-z|A-Z|\-|\_]*)\:/
  VARIABLE_VALUE = /(\: [\s|\d|a-z|A-Z|\#|\/|\-|\,|\(|\)|\.|\%|\'|\"|\\]*\;$)/
  PROP_NAME = /^([[^\$|\,|\.|\>|\#|\s]|a-z|A-Z|\-|\_]*)\:/
  VALUE_VAL = /(\: [\$|\s|\d|a-z|A-Z|\#|\/|\-|\_|,]*\;$)/
  VALUE_VAL2 = /(\: ?[\s|\d|a-z|A-Z|\#|\/|\-|\,|\(|\)|\.|\%|\'|\"|\\]*\;$)/
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Style/RegexpLiteral
