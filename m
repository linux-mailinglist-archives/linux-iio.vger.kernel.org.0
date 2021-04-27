Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA136C108
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhD0IfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhD0IfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:35:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB906C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:34:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so6708194pjj.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ak7s2qFoFa0+7LG7NW9Df5TuS9EY4i8D09ozQkOFaU4=;
        b=DxDoJlYwN3IB6ZnXBg8RStOGhfOxNxfb4MAsHLxCHu2J2VgVujmLgBoy5YrEUVbet+
         RYfUQ46ZuKTut3XsIL+OWsgJ37zb2iJd2WBjR/JFwiiPRAhP5N1jh5lWHHWWRvEkJZY6
         NVv+kRSPQ7RFa/eVgA+gv+vuwxYsyAz9VPnv1xO/a3oGBJH4pJgYuQNFSjp5xWmt487m
         AxAKP5/J8AGAnHycR+R5c0ltgaxQx3vu1ybXPxFoPbVL+g6qA8UQVaEaAaWH/j9qhBEv
         OTxAsbvNct4+xnrH65ErBylEj/4V/B+cnJfE0h0AF5EysZ1bPNrQCBd59VrpYAL570qH
         LpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak7s2qFoFa0+7LG7NW9Df5TuS9EY4i8D09ozQkOFaU4=;
        b=TZekopjH6syRXtpmsUkeukwTP/AMXjothY+hT0j6RFZwe6UkWRgJOL015xN9Kjte8m
         Srn9GqeyeRT7SsCfnB5Xf0/kX0YfLe2qmnSYwrDuqrV8pUMizdfupWEFQzBMOgrStr5k
         KmYtX1CYoQQ2qZacpvEmYTr7scMbzwNTAlloZPuSuzHWKkdF6usYZ2MwTqBH4FCrQgt9
         rq6KEsfT4+BWWTZaaMUzEquv7xckrmpEiy5eGSlYU+C+jgT7UY4/1oK9yylMIyWSTGqH
         Frc9Dh3t3Bk7bfR7aCYGPZ8QJT6mYikF1sNbZQnZOjaoA+IH6/UOrpvYZScIGETGpiqX
         iKlw==
X-Gm-Message-State: AOAM533mf0RNFFkVmBw4v/CNUZHuBzaSvmxN2UZxInFbdXDG4wzORc6N
        1qCDMRSKnzVXYMyxyCKQDxKy5hALC6hnYkR6eKg=
X-Google-Smtp-Source: ABdhPJxlNrBSnQlOjZIRJrbca69UYA45aUF6wf61CPcNa+iCfl4RGg2b28OnZUIeiLStInEEOVCFGiItE4j7GPeCg3k=
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr19524587pjq.181.1619512460233;
 Tue, 27 Apr 2021 01:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <202103162301.oomY9NwI-lkp@intel.com> <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
 <8d72be21988d46c2ac8ad0de15689452@huawei.com>
In-Reply-To: <8d72be21988d46c2ac8ad0de15689452@huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:34:09 +0300
Message-ID: <CA+U=DsppGq0CyWY+Y0ob-j+FuyPqd9hpb46wmYy9u9CJ6X4gKA@mail.gmail.com>
Subject: Re: FW: ingenic-adc.c:undefined reference to `clk_get_parent'
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 11:43 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
>

The .config would help to reproduce this.
I don't see it attached.

>
> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: 26 April 2021 06:44
> To: kernel test robot <lkp@intel.com>; Jonathan Cameron <jonathan.cameron@huawei.com>; linux-clk@vger.kernel.org
> Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Andy Shevchenko <andy.shevchenko@gmail.com>; Stephen Boyd <sboyd@kernel.org>; Michael Turquette <mturquette@baylibre.com>
> Subject: Re: ingenic-adc.c:undefined reference to `clk_get_parent'
>
> [add linux-clk + maintainers]
>
> On 3/16/21 8:54 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
> > commit: a07a4fe5ff460e99293c0d682421920d54e31d7f iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
> > date:   8 months ago
> > config: mips-randconfig-p001-20210316 (attached as .config)
> > compiler: mips-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a07a4fe5ff460e99293c0d682421920d54e31d7f
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout a07a4fe5ff460e99293c0d682421920d54e31d7f
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
> > ARCH=mips
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> >>> ingenic-adc.c:(.text+0x8c): undefined reference to `clk_get_parent'
> >    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> >    ingenic-adc.c:(.text+0x164): undefined reference to `clk_get_parent'
>
> Hi,
>
> My guess (analysis) suggests that this problem is due to a difference in when clk_get_parent() is available between <linux/clk.h> where it depends on CONFIG_HAVE_CLK and drivers/clk/clk.c, which is built iff CONFIG_COMMON_CLK.
>
> Any comments/suggestions?
>
> thanks.
> --
> ~Randy
>
