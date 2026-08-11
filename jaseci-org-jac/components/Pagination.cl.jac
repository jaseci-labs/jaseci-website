"""Blog pagination - ports `layouts/components/Pagination.js`."""

import from "@jac/runtime" { Link }

"""Every page link points at `/blog`, exactly as the Next.js component did."""
glob BASE_PATH: str = "/blog";

def:pub Pagination(current_page: int, total_pages: int) -> JsxElement {
    index_page_link = current_page == 2;
    has_prev_page = current_page > 1;
    has_next_page = total_pages > current_page;
    page_list = [n for n in range(1, total_pages + 1)];

    prev_href = BASE_PATH if index_page_link else BASE_PATH + "/page/" + str(current_page - 1);

    return <>
        {if total_pages > 1 {
            <nav key="pagination" className="mb-4 flex justify-center space-x-4" aria-label="Pagination">
                {#* previous *#}
                {if has_prev_page {
                    <Link key="prev" to={prev_href} className="rounded-lg border border-primary px-2 py-2 text-dark">
                        <span className="sr-only">Previous</span>
                        <svg
                            className="mt-1 h-5 w-5"
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                            aria-hidden="true"
                        >
                            <path
                                fillRule="evenodd"
                                d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                clipRule="evenodd"
                            />
                        </svg>
                    </Link>
                } else {
                    <span key="prev" className="rounded-lg border border-primary px-2 py-2 text-dark">
                        <span className="sr-only">Previous</span>
                        <svg
                            className="mt-1 h-5 w-5"
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                            aria-hidden="true"
                        >
                            <path
                                fillRule="evenodd"
                                d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                clipRule="evenodd"
                            />
                        </svg>
                    </span>
                }}

                {#* page index *#}
                {for (i, page) in enumerate(page_list) {
                    <span key={"page-" + str(i)}>
                        {if page == current_page {
                            <span
                                key="active"
                                aria-current="page"
                                className="rounded-lg border border-primary bg-primary px-4 py-2 text-white"
                            >
                                {page}
                            </span>
                        } else {
                            <Link
                                key="link"
                                to={BASE_PATH if i == 0 else BASE_PATH + "/page/" + str(page)}
                                aria-current="page"
                                className="rounded-lg border border-primary px-4 py-2 text-dark"
                            >
                                {page}
                            </Link>
                        }}
                    </span>
                }}

                {#* next page *#}
                {if has_next_page {
                    <Link
                        key="next"
                        to={BASE_PATH + "/page/" + str(current_page + 1)}
                        className="rounded-lg border border-primary px-2 py-2 text-dark"
                    >
                        <span className="sr-only">Next</span>
                        <svg
                            className="mt-1 h-5 w-5"
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                            aria-hidden="true"
                        >
                            <path
                                fillRule="evenodd"
                                d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                clipRule="evenodd"
                            />
                        </svg>
                    </Link>
                } else {
                    <span key="next" className="rounded-lg border border-primary px-2 py-2 text-dark">
                        <span className="sr-only">Next</span>
                        <svg
                            className="mt-1 h-5 w-5"
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                            aria-hidden="true"
                        >
                            <path
                                fillRule="evenodd"
                                d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                clipRule="evenodd"
                            />
                        </svg>
                    </span>
                }}
            </nav>
        }}
    </>;
}
