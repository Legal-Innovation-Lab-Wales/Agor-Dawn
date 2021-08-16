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
      isFalseyOrWhiteSpace = (str) => {
        return (!str || str.length === 0 || /^\s*$/.test(str))
      },
      is_desktop_view = () => {
        return window.innerWidth >= parseInt(CSS.screenSm.replace('px', ''))
      },
      toggle_desktop_search = () => {
        search_btn.classList.remove('fa-times')
        search_btn.classList.add('fa-search')
      },
      toggle_mobile_search = () => {
        search_btn.classList.remove('fa-search')
        search_btn.classList.add('fa-times')
      },
      search_function = input => {
        if (!isFalseyOrWhiteSpace(input.value)) {
          const url = new URL(location.origin)
          url.searchParams.set('query', input.value)
          location.href = url.href
        }
      }

search_btn.addEventListener('click', () => {
  if (is_desktop_view()) {
    search_function(search_input)
  } else {
    mobile_search.classList.toggle('hide')
    if (mobile_search.classList.contains('hide')) {
      toggle_desktop_search()
    } else {
      toggle_mobile_search()
    }
  }
})

search_input.addEventListener('keyup', e => { 
  if (e.key === 'Enter') {
    search_function(search_input)
  }
})

mobile_search_btn.addEventListener('click', () => {
  search_function(mobile_search_input)
})

mobile_search_input.addEventListener('keyup', e => {
  if (e.key === 'Enter') {
    search_function(mobile_search_input)
  }
})

window.addEventListener('resize', () => {
  if (is_desktop_view()) {
    toggle_desktop_search()
  } else {
    if (!mobile_search.classList.contains('hide')) {
      toggle_mobile_search()
    }
  }
})