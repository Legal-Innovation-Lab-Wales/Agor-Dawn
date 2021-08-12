const search_btn = document.querySelector('nav .search-icon'),
      search_input = document.querySelector('nav .search-input'),
      mobile_search = document.querySelector('.mobile-search'),
      mobile_search_btn = document.querySelector('.mobile-search .search-icon')

const search = () => {
  alert('Searching...')
}

search_btn.addEventListener('click', () => {
  let search_input_display = window.getComputedStyle(search_input).display
  if (search_input_display === 'block') { // Search button functions as intended
    // Take value of input field and post to search function
    search()
  } else if (search_input_display === 'none') { // Search button reveals a search input on mobile
    mobile_search.classList.toggle('hide')
  } else {
    alert('An error has occurred, please refresh your browser')
  }
})

mobile_search_btn.addEventListener('click', () => {
  search()
})