const edit_btns = document.querySelectorAll('.comment-actions .edit'),
      get_comment_text_container = (btn) => {
        return btn.parentElement
                  .parentElement
                  .nextElementSibling
                  .nextElementSibling
      }

edit_btns.forEach(btn => {
  btn.addEventListener('click', () => {
    const container = get_comment_text_container(btn),
          comment_text = container.querySelector('.comment-text'),
          form = container.querySelector('.form'),
          cancel_btn = form.querySelector('.cancel')

    comment_text.style.display = 'none'
    form.style.display = 'block'

    cancel_btn.addEventListener('click', () => {
      form.style.display = 'none'
      comment_text.style.display = 'block'
    })
  })
})

const edit_history_btns = document.querySelectorAll('.edited'),
      edit_history_modal = document.querySelector('.edit-history-modal'),
      hr = document.createElement('hr'),
      get_author_info = (btn_element, date) => {
        const author_info = btn_element.parentElement.parentElement.parentElement.cloneNode(true),
              subtext = author_info.querySelector('.subtext'),
              children = subtext.children
  
        // Remove the dot and 'edited' from the subtext
        subtext.removeChild(children[1])
        subtext.removeChild(children[1])

        created_date = author_info.querySelector('.created-date')
        created_date.innerHTML = `<i class="far fa-calendar-alt"></i> ${date.toLocaleDateString()} <i class="far fa-clock"></i> ${date.getUTCHours()}:${date.getUTCMinutes()}`

        return author_info
      }
      create_comment_element = (author_info, comment_text) => {
        const container = document.createElement('div')
        container.classList.add('form', 'container')

        container.appendChild(author_info)
        container.appendChild(hr.cloneNode(false))

        const div = document.createElement('div')
        div.innerText = comment_text
        container.appendChild(div)

        return container
      }

edit_history_btns.forEach(btn => {
  btn.addEventListener('click', () => {
    while (edit_history_modal.firstChild) {
      edit_history_modal.removeChild(edit_history_modal.firstChild)
    }

    fetch(`${location.origin}${location.pathname}/comments/${btn.dataset['comment_id']}`, {
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then(data => data.json())
    .then(json => {
      json.forEach(comment => {
        const author_info = get_author_info(btn, new Date(comment['created_at'])),
              comment_element = create_comment_element(author_info, comment['comment_text'])

        edit_history_modal.appendChild(comment_element)
      })
    })
  })
})