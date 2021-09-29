const flag_resolved = document.querySelector('input#project_flag_resolved'),
      flag_comments = document.querySelector('.field.flag-comments')

flag_resolved.addEventListener('click', () => {
  if (flag_resolved.checked) {
    flag_comments.style.display = 'block'
  } else {
    flag_comments.style.display = 'none'
  }
})