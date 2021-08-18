const liked_modal = document.getElementById("liked-modal")
const open_liked_modal = document.getElementById("open-liked-modal")
const close_liked_modal = document.getElementById("close-liked-modal")

open_liked_modal.addEventListener("click", openModal)
close_liked_modal.addEventListener("click", closeModal)

function openModal() {
    document.getElementById("backdrop").style.display = "block"
    liked_modal.style.display = "block"
    liked_modal.classList.add("show")
}
function closeModal() {
    document.getElementById("backdrop").style.display = "none"
    liked_modal.style.display = "none"
    liked_modal.classList.remove("show")
}

// When the user clicks anywhere outside of the liked_modal, close it
window.onclick = function(event) {
    if (event.target === liked_modal) {
        closeModal()
    }
}

