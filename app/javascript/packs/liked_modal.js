const liked_modal = document.getElementById("liked-modal"),
    open_liked_modal = document.getElementById("open-liked-modal"),
    close_liked_modal = document.getElementById("close-liked-modal"),
    backdrop = document.getElementById("backdrop"),
    open_modal = () => {
        backdrop.style.display = "block"
        liked_modal.style.display = "block"
        liked_modal.classList.add("show")
    },
    close_modal = () => {
        backdrop.style.display = "none";
        liked_modal.style.display = "none";
        liked_modal.classList.remove("show");
    }

window.onclick = event => {
    if (event.target === liked_modal) close_modal()
}
open_liked_modal.addEventListener("click", open_modal)
close_liked_modal.addEventListener("click", close_modal)