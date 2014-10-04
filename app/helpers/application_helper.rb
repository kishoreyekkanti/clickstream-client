module ApplicationHelper
  def markdown(text)
    CodeRay.scan(text, :javascript).div
  end
end
