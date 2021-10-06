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