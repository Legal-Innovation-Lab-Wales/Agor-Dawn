const like_modal = document.getElementById("exampleModal")
const open_liked_modal = document.getElementById("open_liked_modal")
const close_liked_modal = document.getElementById("close_liked_modal")

open_liked_modal.addEventListener("click", openModal)
close_liked_modal.addEventListener("click", closeModal)

function openModal() {
    document.getElementById("backdrop").style.display = "block"
    like_modal.style.display = "block"
    like_modal.classList.add("show")
}
function closeModal() {
    document.getElementById("backdrop").style.display = "none"
    like_modal.style.display = "none"
    like_modal.classList.remove("show")
}


// When the user clicks anywhere outside of the like_modal, close it
window.onclick = function(event) {
    if (event.target === like_modal) {
        closeModal()
    }
}

window.onload = event =>{
    openModal()
}