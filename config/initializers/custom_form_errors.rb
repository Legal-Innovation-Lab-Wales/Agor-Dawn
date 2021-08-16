ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input,select,textarea')
  error_messages = instance.object.errors.messages

  html = nil
  if field
    field['class'] = "#{field['class']} invalid"

    value = field.attributes['name']
                 .value
                 .match(/\[(.*?)\]/)[0]
                 .delete('[]')
    
    error_message = error_messages[value.to_sym][0]
    error_message = 'is invalid' unless error_message.present?

    html = <<HTML
#{fragment.to_s} 
<p class=\"error\">
#{value.capitalize} #{error_message}
</p>
HTML
    html
  else
    html = html_tag
  end

  html.html_safe
end