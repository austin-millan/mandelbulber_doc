.PHONY: all

clean:
	rm -rf *.aux *.idx *.lo* *.out *.tox *texput.log *.pdf build/

pdf:
	mkdir -p build
	docker run \
		--rm \
		-v `pwd`:/data \
		-w /data \
		-it schickling/latex:latest \
		pdflatex -halt-on-error -file-line-error -interaction=nonstopmode -output-directory build handbook.tex

compress:
	docker run \
		--rm \
		-v `pwd`:/data \
		-w /data \
		-it minidocks/ghostscript \
		bash -c "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/build/handbook-compressed.pdf /build/handbook.pdf"

image:
	docker build -t mandelbulber_docs:latest .
