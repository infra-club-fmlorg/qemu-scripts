template_first=template/template-first-half.html
template_second=template/template-second-half.html

build:
	cat $(template_first) $(MD) $(template_second) > dist/$(NAME)

build-cloud-infrastructure:
	cat  $(template_first) markdown/cloud-infrastructure.md $(template_second) > dist/cloud-infrastructure.html

