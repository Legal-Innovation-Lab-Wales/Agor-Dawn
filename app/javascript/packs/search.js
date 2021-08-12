const search = document.querySelector('nav .search'),
      search_btn = search.querySelector('.search-icon'),
      search_input = search.querySelector('.search-input'),
      mobile_search = document.querySelector('.mobile-search'),
      mobile_search_btn = mobile_search.querySelector('.search-icon'),
      mobile_search_input = mobile_search.querySelector('.search-input'),
      isFalseyOrWhiteSpace = (str) => {
        return (!str || str.length === 0 || /^\s*$/.test(str))
      },
      search_function = (input) => {
        if (isFalseyOrWhiteSpace(input.value)) {
          alert('No search value')
        } else {
          alert(`Searching for '${input.value}'`)
        }
      }

search_btn.addEventListener('click', () => {
  let search_input_display = window.getComputedStyle(search_input).display
  if (search_input_display === 'block') { // Search button functions as intended
    search_function(search_input)
  } else if (search_input_display === 'none') { // Search button reveals a search input on mobile
    search_btn.classList.toggle('fa-search')
    search_btn.classList.toggle('fa-times')
    mobile_search.classList.toggle('hide')
  } else {
    alert('An error has occurred, please refresh your browser')
  }
})

mobile_search_btn.addEventListener('click', () => {
  search_function(mobile_search_input)
})