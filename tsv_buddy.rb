# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    output = []
    skills = tsv.split("\n")
    keys = skills[0].split("\t")
    keys.map! { |x| x.chomp }
    skills.shift

    skills.each do |line|
      values = line.split("\t")
      hash = Hash.new
      keys.each_index { |index| hash[keys[index]] = values[index].chomp }
      output.push(hash)
    end
    @data = output
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    input_yml = @data
    line1 = input_yml[0]
    keys = line1.keys
    output = keys.join("\t")+ "\n"
    input_yml.each do |record|
      record.each_value { |value| output << value + "\t" }
      output.strip!
      output << "\n"
    end
    output
    end
  end