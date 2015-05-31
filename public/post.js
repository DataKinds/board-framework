function displayPostForm() {
	var postFormHolder = document.createElement("div");
	postFormHolder.setAttribute("class", "postFormHolder");
	document.body.appendChild(postFormHolder);
	var postForm = document.createElement("form");
	postForm.setAttribute("action", "/createpost");
	postForm.setAttribute("method", "post");
	postForm.setAttribute("autocomplete", "off");
	postFormHolder.appendChild(postForm);

	var titleHolder = document.createElement("div");
	postForm.appendChild(titleHolder);
	var titleLabel = document.createElement("label");
	titleLabel.setAttribute("for", "title");
	titleLabel.innerHTML = "Title:";
	titleHolder.appendChild(titleLabel);
	var titleInput = document.createElement("input");
	titleInput.setAttribute("type", "text");
	titleInput.setAttribute("id", "title");
	titleInput.setAttribute("name", "title");
	titleInput.setAttribute("autocomplete", "off");
	titleHolder.appendChild(titleInput);

	var bodyHolder = document.createElement("div");
	postForm.appendChild(bodyHolder);
	var bodyLabel = document.createElement("label");
	bodyLabel.setAttribute("for", "body");
	bodyLabel.innerHTML = "Body:";
	bodyHolder.appendChild(titleLabel);
	var bodyInput = document.createElement("textarea");
	bodyInput.setAttribute("type", "text");
	bodyInput.setAttribute("id", "body");
	bodyInput.setAttribute("name", "body");
	bodyInput.setAttribute("autocomplete", "off");
	bodyHolder.appendChild(bodyInput);

	var submit = document.createElement("button");
	submit.setAttribute("type", "submit");
	submit.innerHTML = "Submit";
	postForm.appendChild(submit);
}
