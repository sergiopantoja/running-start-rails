class ApplicationPresenter < SimpleDelegator
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TextHelper

  def self.build_collection(items)
    items.map { |item| new(item) }
  end

  def to_model
    __getobj__
  end

  # for Rails helpers like form_for
  def class
    __getobj__.class
  end
end
