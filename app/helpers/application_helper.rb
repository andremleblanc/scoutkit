module ApplicationHelper
  def print_nav_label(label)
    label.titleize
  end

  def number_to_human(number)
    super(number, format: '%n%u', units: { thousand: 'K', million: 'M', billion: 'B' })
  end

  def print_title(title)
    title = title.present? ? title : t("titles.#{controller_name}")
    title.titleize
  end

  def success
    flash[:success]
  end

  def title(title)
    content_for :title, title.to_s
  end
end
