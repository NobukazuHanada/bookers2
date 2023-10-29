function addComment(commentHTMLText) {
    const bookCommentsElement = document.getElementById("book_comments");
    const bookComment = document.createElement("div");
    bookComment.innerHTML = commentHTMLText;
    bookCommentsElement.appendChild(bookComment)
}

function deleteComment(commentId) {
    document.getElementById(`book_comment_id_${commentId}`).remove();
}

window.addComment = addComment;
window.deleteComment = deleteComment;