const url = new URL(`${location.href}/likes`),
      csrf_tokens = document.getElementsByName('csrf-token'),
      headers = {'Content-Type': 'application/json', 'X-CSRF-Token': csrf_tokens.length > 0 ? csrf_tokens[0].content : ''},
      like_btn = document.querySelector('.like-count .like-button'),
      like_icon = like_btn.querySelector('i'),
      like_count = document.querySelector('.like-count .count')

like_btn.addEventListener('click', () => {
  if (like_icon.classList.contains('far')) { // like
    fetch(url, {
      method: 'POST',
      headers: headers
    })
    .then(data => {
      like_icon.classList.remove('far')
      like_icon.classList.add('fas')
      like_count.innerText = `${parseInt(like_count.innerText.match(/\d+/)[0]) + 1} likes`
    })
    .catch(e => {
      console.log(e);
    })
  } else if (like_icon.classList.contains('fas')) { // unlike
    fetch(url, {
      method: 'DELETE',
      headers: headers
    })
    .then(data => {
      like_icon.classList.remove('fas')
      like_icon.classList.add('far')
      like_count.innerText = `${parseInt(like_count.innerText.match(/\d+/)[0]) - 1} likes`
    })
    .catch(e => {
      console.log(e)
    })
  }
})