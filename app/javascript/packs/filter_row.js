const filter_categories = document.querySelectorAll('.filter-categories .category')
      url = new URL(location.href),
      toggle_selected = (selected_category) => {
        filter_categories.forEach(category => {
          if (category.dataset.filter === selected_category) {
            category.classList.add('selected')
          } else {
            category.classList.remove('selected')
          }
        })
      }

filter_categories.forEach(category => {
  const category_value = category.dataset.filter,
        sort_value = document.querySelector('.filter-order .sort').value
  
  category.addEventListener('click', () => {
    url.searchParams.set('category', category_value)
    url.searchParams.set('sort', sort_value)
    toggle_selected(category_value)
    location.href = url.href
  })
})