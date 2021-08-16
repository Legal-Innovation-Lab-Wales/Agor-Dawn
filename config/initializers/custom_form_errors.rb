ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input,select,textarea')
  error_messages = instance.object.errors.messages

  html = nil
  if field
    value = field.attributes['type'].value
    message = "#{value.capitalize} #{error_messages[value.to_sym][0]}"
    field['class'] = "#{field['class']} invalid"

    html = <<HTML
#{fragment.to_s} 
<p class=\"error\">#{message}</p>
HTML
    html
  else
    html = html_tag
  end

  html.html_safe
end