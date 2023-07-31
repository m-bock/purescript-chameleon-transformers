build:
    spago build

test:
    spago test

format:
    purs-tidy format-in-place 'src/**/*.purs'
    purs-tidy format-in-place 'test/**/*.purs'

check-format:
    purs-tidy check 'src/**/*.purs'
    purs-tidy check 'test/**/*.purs'

gen-readme:
    npx purs-to-md --input-purs demo/SampleReadme.purs --output-md README.md