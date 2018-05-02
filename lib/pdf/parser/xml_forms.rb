require "nokogiri"


class String
  def string_between_markers marker1, marker2
    self[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end
end

class XMLForms
  def parse(pdf)
    parsed = PDF.read(pdf)
    data = parsed.grep("><xfa:data")
    string = data.to_s
    val = string.string_between_markers('<xfa:data\n>', '</Form\n>')
    final = val.gsub('\n','')
    xml = Nokogiri::XML(final).to_xml
    return xml
  end
end
