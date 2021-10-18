const btn_close = document.querySelectorAll('.btn-close')

btn_close.forEach(btn => {
  btn.addEventListener('click', () => {
    const alert = btn.closest('.alert')

    alert.style.display = 'none';
  })
})