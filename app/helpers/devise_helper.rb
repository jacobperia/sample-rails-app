module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:span, msg) }.join(', ')
    html = <<-HTML
    <div class="alert alert-warning alert-dismissible fade show" role="alert"> <button type="button"
    class="btn-close" data-bs-dismiss="alert"></button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
