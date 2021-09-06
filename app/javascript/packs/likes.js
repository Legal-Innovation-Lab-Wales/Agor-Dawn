const url = new URL(`${location.href}/likes`),
      csrf_tokens = document.getElementsByName('csrf-token'),
      headers = {'Content-Type': 'application/json', 'X-CSRF-Token': csrf_tokens.length > 0 ? csrf_tokens[0].content : ''},
      like_btn = document.querySelector('.like-count .like-button'),
      like_icon = like_btn.querySelector('i'),
      like_count = document.querySelector('.like-count .count'),
      like_metadata = document.querySelector('.stats .metadata.metadata-likes'),
      increment_counter = (count) => {
        count.innerHTML = count.innerHTML.replace(/\d+/, parseInt(count.innerText) + 1)
      },
      decrement_counter = (count) => {
        count.innerHTML = count.innerHTML.replace(/\d+/, parseInt(count.innerText) - 1)
      }



like_btn.addEventListener('click', () => {
  if (like_icon.classList.contains('far')) { // like
    fetch(url, {
      method: 'POST',
      headers: headers
    })
    .then(() => {
      like_icon.classList.remove('far')
      like_icon.classList.add('fas')
      increment_counter(like_count)
      increment_counter(like_metadata)
    })
    .catch(e => {
      console.log(e);
    })
  } else if (like_icon.classList.contains('fas')) { // unlike
    fetch(url, {
      method: 'DELETE',
      headers: headers
    })
    .then(() => {
      like_icon.classList.remove('fas')
      like_icon.classList.add('far')
      decrement_counter(like_count)
      decrement_counter(like_metadata)
    })
    .catch(e => {
      console.log(e)
    })
  }
})