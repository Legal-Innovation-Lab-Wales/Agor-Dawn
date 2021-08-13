import variables from '../../assets/stylesheets/variables.scss';

const CSS = {
  screenSm: variables.screensm
}

const search = document.querySelector('nav .search'),
      search_btn = search.querySelector('.search-icon'),
      search_input = search.querySelector('.search-input'),
      mobile_search = document.querySelector('.mobile-search'),
      mobile_search_btn = mobile_search.querySelector('.search-icon'),
      mobile_search_input = mobile_search.querySelector('.search-input'),
      search_function = input => {
        const url = new URL(location.href)
        url.searchParams.set('query', input.value)
        location.href = url.href
      }

search_btn.addEventListener('click', () => {
  let search_input_display = window.getComputedStyle(search_input).display
  if (search_input_display === 'block') { // Search button functions as intended
    search_function(search_input)
  } else if (search_input_display === 'none') { // Search button reveals a search input on mobile'
    mobile_search.classList.toggle('hide')
    if (mobile_search.classList.contains('hide')) {
      search_btn.classList.add('fa-search')
      search_btn.classList.remove('fa-times')
    } else {
      search_btn.classList.remove('fa-search')
      search_btn.classList.add('fa-times')
    }
  } else {
    alert('An error has occurred, please refresh your browser')
  }
})

mobile_search_btn.addEventListener('click', () => {
  search_function(mobile_search_input)
})

window.addEventListener('resize', () => {
  if (window.innerWidth >= parseInt(CSS.screenSm.replace('px', ''))) {
    search_btn.classList.remove('fa-times')
    search_btn.classList.add('fa-search')
  } else {
    if (!mobile_search.classList.contains('hide')) {
      search_btn.classList.add('fa-times')
      search_btn.classList.remove('fa-search')
    }
  }
})