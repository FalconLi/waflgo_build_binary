FROM xfalconghost/walfgo_fix:v6

LABEL about="AFLplusplus docker image"
LABEL maintainer="afl++ team <afl@aflplus.plus>"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV NO_ARCH_OPT=1
ENV LLVM_CONFIG=llvm-config-12
ENV AFL_SKIP_CPUFREQ=1
ENV AFL_TRY_AFFINITY=1
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
ENV IS_DOCKER=1

WORKDIR /AFLplusplus

CMD ["/bin/bash"]
