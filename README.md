# Latest Resume
You can download/view the latest version of my resume here:

https://nebriv.github.io/resume/main-resume.pdf

# Resume Generation
Uses Github actions to automatically build different versions (based off of branches) of my resume. The intention is to have one "main" version (main branch) that can then be pulled from to create more specific resume versions as the need arises.

I wanted to keep tagged versions for each branch and create a release for it, but I also needed a fairly static link that I could use on my website, etc. To resolve this I ended up just leveraging github pages, as a separate branch and then copying the latest version of the resume for each branch, as its built, into that branch and publishing it. It is a little clunky, but it does work well so far.

# Deployment?
The thought is to hopefully push out the generated PDFs to wherever I have my resume listed. I'll probably just start back linking to the "main" latest version for now though as the former will likely require some API shenandigans that I'm not sure are even possible.

# Sauce
Original resume generated via https://resumake.io. It looks like the template was originally sourced from here: https://github.com/dnl-blkv/mcdowell-cv

I chose this template as it most closely resembled my current resume, I've made a few modifications from the original to include some other sections and improve the spacing.
