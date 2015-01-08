def search_tags(tag)
  visit '/'
  fill_in :search_tags, with: 'sauce'
  click_on 'Search'
end
