function commentLimitHandler() {
	commentLengthBox = document.getElementById("commentLength");
	comment = document.getElementById("comment").value;
	commentLength = comment.length;
	commentLengthBox.innerHTML = commentLength + "/" + maxCommentLength;
	if(commentLength > maxCommentLength) { //too long
		commentLengthBox.setAttribute("style", "color: red;");
		document.getElementById("commentSubmit").disabled = true;
	} else if(comment.replace(/\s/g, "").length < minCommentLength) {
		commentLengthBox.innerHTML = commentLength + "/" + maxCommentLength + " (you need at least " + minCommentLength + " letters to post)";
		commentLengthBox.setAttribute("style", "color: red;");
		document.getElementById("commentSubmit").disabled = true;
	} else { //of a good posting length
		commentLengthBox.setAttribute("style", "");
		document.getElementById("commentSubmit").disabled = false;
	}
}

function postSubmitButtonHandler() {
	titleOK = !(titleLength > maxTitleLength || document.getElementById("title").value.replace(/\s/g, "").length < minTitleLength);
	bodyOK = !(bodyLength > maxBodyLength || document.getElementById("body").value.replace(/\s/g, "").length < minBodyLength);
	fileOK = !(document.getElementById("fileInput").files[0].size > maxFileSize);
	submitButton = document.getElementById("submitButton");
	if (titleOK && bodyOK && fileOK) {
		submitButton.disabled = false;
		submitButton.setAttribute("style", "background: green");
	} else {
		submitButton.disabled = true;
		submitButton.setAttribute("style", "background: white");
	}
}

function titleLimitHandler() {
	titleLengthBox = document.getElementById("titleLength");
	title = document.getElementById("title").value;
	titleLength = title.length;
	titleLengthBox.innerHTML = titleLength + "/" + maxTitleLength;
	submitButton = document.getElementById("submitButton");
	if(titleLength > maxTitleLength) { //too long
		titleLengthBox.setAttribute("style", "color: red;");
	} else if(title.replace(/\s/g, "").length < minTitleLength) {
		titleLengthBox.innerHTML = titleLength + "/" + maxTitleLength + " (you need at least " + minTitleLength + " letters to post)";
		titleLengthBox.setAttribute("style", "color: red;");
	} else { //of a good posting length
		titleLengthBox.setAttribute("style", "");
	}
	postSubmitButtonHandler();
}

function bodyLimitHandler() {
	bodyLengthBox = document.getElementById("bodyLength");
	body = document.getElementById("body").value;
	bodyLength = body.length;
	bodyLengthBox.innerHTML = "&nbsp;" + bodyLength + "/" + maxBodyLength;
	submitButton = document.getElementById("submitButton");
	if(bodyLength > maxBodyLength) { //too long
		bodyLengthBox.setAttribute("style", "color: red;");
	} else if(body.replace(/\s/g, "").length < minBodyLength) {
		bodyLengthBox.innerHTML = "&nbsp;" + bodyLength + "/" + maxBodyLength + " (you need at least " + minBodyLength + " letters to post)";
		bodyLengthBox.setAttribute("style", "color: red;");
	} else { //of a good posting length
		bodyLengthBox.setAttribute("style", "");
	}
	postSubmitButtonHandler();
}