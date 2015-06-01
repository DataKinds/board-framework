var postWindowOpen = false;

function cancelPost() {
	document.body.removeChild(document.getElementById("postFormHolder"));
	document.body.removeChild(document.getElementById("shade"));
	postWindowOpen = false;
}

function displayPostForm() {
	if(!postWindowOpen) {
		postWindowOpen = true;
		var shade = document.createElement("div");
		shade.setAttribute("class", "darken");
		shade.setAttribute("id", "shade");
		shade.setAttribute("onclick", "cancelPost()");
		document.body.appendChild(shade);

		var postFormHolder = document.createElement("div");
		postFormHolder.setAttribute("class", "postFormHolder");
		postFormHolder.setAttribute("id", "postFormHolder");
		document.body.appendChild(postFormHolder);
		var postForm = document.createElement("form");
		postForm.setAttribute("action", "/createpost");
		postForm.setAttribute("method", "post");
		postForm.setAttribute("class", "postForm");
		postForm.setAttribute("autocomplete", "off");
		postFormHolder.appendChild(postForm);

		var titleHolder = document.createElement("div");
		postForm.appendChild(titleHolder);
		var titleInput = document.createElement("input");
		titleInput.setAttribute("type", "text");
		titleInput.setAttribute("id", "title");
		titleInput.setAttribute("name", "title");
		titleInput.setAttribute("class", "titleInput");
		titleInput.setAttribute("placeholder", "Title here...");
		titleInput.setAttribute("autocomplete", "off");
		titleInput.setAttribute("onkeypress", "titleLimitHandler(); return(event.keyCode != 13)"); //disallow enter and run limit handler
		titleInput.setAttribute("onkeyup", "titleLimitHandler()");
		titleHolder.appendChild(titleInput);
		var titleLength = document.createElement("div");
		titleLength.innerHTML = "0/150 (you need at least 2 letters to post)";
		titleLength.setAttribute("float", "left");
		titleLength.setAttribute("class", "length");
		titleLength.setAttribute("style", "color: red;");
		titleLength.setAttribute("id", "titleLength");
		titleHolder.appendChild(titleLength);

		var bodyHolder = document.createElement("div");
		postForm.appendChild(bodyHolder);
		var bodyInput = document.createElement("textarea");
		bodyInput.setAttribute("type", "text");
		bodyInput.setAttribute("id", "body");
		bodyInput.setAttribute("name", "body");
		bodyInput.setAttribute("class", "bodyInput");
		bodyInput.setAttribute("placeholder", "Body here...");
		bodyInput.setAttribute("autocomplete", "off");
		bodyInput.setAttribute("onkeypress", "bodyLimitHandler()"); //disallow enter and run limit handler
		bodyInput.setAttribute("onkeyup", "bodyLimitHandler()");
		bodyHolder.appendChild(bodyInput);
		var bodyLength = document.createElement("div");
		bodyLength.innerHTML = "&nbsp;0/5000 (you need at least 2 letters to post)";
		bodyLength.setAttribute("float", "left");
		bodyLength.setAttribute("class", "length");
		bodyLength.setAttribute("style", "color: red;");
		bodyLength.setAttribute("id", "bodyLength");
		bodyHolder.appendChild(bodyLength);

		var submit = document.createElement("button");
		submit.setAttribute("type", "submit");
		submit.setAttribute("class", "submitButton");
		submit.setAttribute("id", "submitButton");
		submit.setAttribute("disabled", "true");
		submit.innerHTML = "Submit";
		postForm.appendChild(submit);

		var cancel = document.createElement("button");
		cancel.setAttribute("type", "button");
		cancel.setAttribute("class", "cancelButton");
		cancel.setAttribute("onclick", "cancelPost()");
		cancel.innerHTML = "Cancel";
		postForm.appendChild(cancel);
	}
}
