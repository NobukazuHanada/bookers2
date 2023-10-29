function setFavorites(bookId, counts, method) {
    const anchors = document.querySelectorAll(`[data-book-id="${bookId}"]`);
    for (let anchor of anchors) {
        anchor.textContent = `♡${counts}いいね`;
        anchor.setAttribute("data-method", method);
    }
}

window.setFavorites = setFavorites