# Module that can be included (mixin) to take and output Yaml data
require 'yaml'
module YamlBuddy
  #takes a yaml string and converts it into a data structure in @data.
  def take_yaml(yaml)
  	@data = YAML.load(yaml)
  end
  #converts any data in @data into a yaml string.
  def to_yaml
  	@data.to_yaml
  end
end
