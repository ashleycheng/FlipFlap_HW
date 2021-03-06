require 'minitest/autorun'
require 'minitest/rg'

require_relative 'flip_flap'

YML_DATA = File.read('data/survey.yml')
TSV_DATA = File.read('data/survey.tsv')
#print TSV_DATA
describe 'FlipFlap specs' do
  it 'supports tsv inputs' do
    FlipFlap.input_formats.must_include 'tsv'
  end

  it 'supports yaml inputs' do
    FlipFlap.input_formats.must_include 'yaml'
  end

  it 'should convert yml to tsv' do
    flipper = FlipFlap.new
    flipper.take_yaml(YML_DATA)
    flipper.to_tsv.must_equal TSV_DATA
  end

  it 'should convert tsv to yml' do
    flipper = FlipFlap.new
    flipper.take_tsv(TSV_DATA)
    flipper.to_yaml.must_equal YML_DATA
  end

  it 'should store Yaml in data we can retrieve' do
    flipper = FlipFlap.new
    flipper.data.must_be_nil
    flipper.take_yaml(YML_DATA)
    flipper.data.wont_be_nil
  end

  it 'should store TSV in data we can retrieve' do
    flipper = FlipFlap.new
    flipper.data.must_be_nil
    flipper.take_tsv(TSV_DATA)
    flipper.data.wont_be_nil
  end
end

describe 'application specs' do
  it 'should convert yml to tsv from command line' do
    `ruby yml_to_tsv.rb data/survey.yml data/test.tsv`
    File.file?('data/test.tsv').must_equal true
    diff = FileUtils.compare_file('data/survey.tsv', 'data/test.tsv')
    diff.must_equal true
  end

  it 'should convert tsv to yml from command line' do
    `ruby tsv_to_yml.rb data/survey.tsv data/test.yml`
    File.file?('data/test.yml').must_equal true
    diff = FileUtils.compare_file('data/survey.yml', 'data/test.yml')
    diff.must_equal true
  end

  after do
    `rm data/test.* > /dev/null 2>&1`
  end
end
