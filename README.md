Webpage crawler. I recommend to run sample rails app from `./sample_app` and test against it

    Usage: ./crawler [options]
        -u, --url STRING                 Base URL to fetch
        -c, --concurrency INTEGER        Number of concurrent crawling threads. Default: 4
        -p, --pages INTEGER              Max number of pages to fetch. Default: 50
        -d, --depth INTEGER              Max page depth relative to base url. Default: 3
        -h, --help                       Display this help
