.PHONY: all

clean:
	rm -rf *.aux *.idx *.lo* *.out *.tox *texput.log *.pdf build/

pdf:
	mkdir -p build
	docker run \
		--rm \
		-v `pwd`:/data \
		-it blang/latex:ubuntu \
		pdflatex -halt-on-error -file-line-error -interaction=nonstopmode -output-directory /data/build /data/handbook.tex

compress:
	docker run \
		--rm \
		-v `pwd`:/data \
		-it minidocks/ghostscript \
		bash -c "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/build/handbook-compressed.pdf /data/build/handbook.pdf"

image:
	docker build -t mandelbulber_docs:latest .
