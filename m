Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87BD3F37E9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Aug 2021 03:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhHUBd4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 21:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhHUBdz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 21:33:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A54C061575;
        Fri, 20 Aug 2021 18:33:17 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t190so12792566qke.7;
        Fri, 20 Aug 2021 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=B4298Vbahy2JXlz0xdPNcw6YwLJivhPPsoL7ofiBcYE=;
        b=DzqAnbvJBrxk/6qkkGeTdcLFMYfuyvYXzoNoNzNnNyVcXa60gRE6YdGYNfkZWRtelQ
         LReB+W7R6Pu1ZUrIBO2jEnvqRqwonHenD7eIeRaCRQ7LAVAxZ+QWVO3TgpFTR2J/FGSt
         9eK9X8MYs09Fft35vIo8/tRi+ZuoUT7jM7oTZ/q2+Q0xMANsw7m7HcxyV7cbiF6PdE1V
         uOXslJrMgr11az3OS368w6vLBcjpDWaiuPgJ4tWNDZ7PqV21vuZRSjcFfpH1fnht6FJp
         JFlF1ZhaQzMOjXAic+qLcasQWUG47lgCqQXeJxX9WtmEvxLQElh18zJnmaqOox794jkJ
         57WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=B4298Vbahy2JXlz0xdPNcw6YwLJivhPPsoL7ofiBcYE=;
        b=USMyQwK45sqb9y+WyQ293W6H3pN0z1dq70hez2SOusY1smdZA+QymTcOsXiSjH4m56
         1BXDELa8yGX2kjP/RqVXUoZOrDO54KZuQ+995SYhU6VGeGMWNTTjH2fOojeV8YXwNHC3
         juO5H9Ith/xLRel8fB/hEtKXcsDeRw6o3fuJ5BPkdALcrtXwpnJ2gLmhyZcT1hVhsw90
         S0qym/OP4UT3k3gYS267wr6B6qFMgPKXPv0r7URGNITB8GsTlygnq6geUU7P73RzDHjw
         5wkhCPZWFaQg7oikJ7VZ1GLIEoOuafmQRKAg1dNQjeSqgOOwwd7YqXg4QasBI4/WWJ0d
         bZDQ==
X-Gm-Message-State: AOAM530v9POxejy6sljJ0sguVo8UXqSh7+RqIzcOOQ6FitaiurFfdjtV
        1hl4qL5IZrdf6OciKfJOa7s=
X-Google-Smtp-Source: ABdhPJw/5KudlBWYhiP2GC/wSVSvdztTerKSC4GpfPxJWKD7oMBrSNVgz63msjH618Nrzl7dChtSYA==
X-Received: by 2002:a05:620a:228a:: with SMTP id o10mr11723057qkh.342.1629509594983;
        Fri, 20 Aug 2021 18:33:14 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id d7sm3389019qth.70.2021.08.20.18.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 18:33:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 Aug 2021 21:33:13 -0400
Message-Id: <CDOSXWS42V5H.4Q06IYCLIBTG@shaak>
Cc:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "kernel test robot" <lkp@intel.com>, <peda@axentia.se>,
        <jic23@kernel.org>, <lars@metafoo.de>
References: <20210820191714.69898-10-liambeguin@gmail.com>
 <202108210716.pxy9O6XW-lkp@intel.com>
In-Reply-To: <202108210716.pxy9O6XW-lkp@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Aug 20, 2021 at 7:37 PM EDT, kernel test robot wrote:
> Hi Liam,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78]
>
> url:
> https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperat=
ure-rescaling-support/20210821-032112
> base: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
> config: nds32-buildonly-randconfig-r005-20210821 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
> wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
> chmod +x ~/bin/make.cross
> #
> https://github.com/0day-ci/linux/commit/e5c2e1505fa3f8cf9fe6d3a21f3a5c585=
efc6dce
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review
> Liam-Beguin/iio-afe-add-temperature-rescaling-support/20210821-032112
> git checkout e5c2e1505fa3f8cf9fe6d3a21f3a5c585efc6dce
> # save the attached .config to linux build tree
> mkdir build_dir
> COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross
> O=3Dbuild_dir ARCH=3Dnds32 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> nds32le-linux-ld: drivers/iio/afe/iio-rescale.o: in function
> `rescale_process_scale':
> >> iio-rescale.c:(.text+0x5f4): undefined reference to `__divdi3'
> >> nds32le-linux-ld: iio-rescale.c:(.text+0x5f8): undefined reference to =
`__divdi3'

My mistake, I'll replace the division by a div64_s64().

--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -53,7 +53,7 @@ int rescale_process_scale(struct rescale *rescale, int sc=
ale_type,
 		else
 			tmp =3D 1 << *val2;
=20
-		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
+		 if (abs(rem) > 10000000 && abs(div64_s64(*val, tmp)) < 100) {
 			*val =3D div_s64_rem(*val, tmp, &rem2);
=20
 			*val2 =3D div_s64(rem, tmp);


The if statement is also misaligned here. I'll fix that too.

Thanks,
Liam

>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

