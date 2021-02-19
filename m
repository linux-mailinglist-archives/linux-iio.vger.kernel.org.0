Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83531F568
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBSHnv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 02:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSHnt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 02:43:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A17C061788
        for <linux-iio@vger.kernel.org>; Thu, 18 Feb 2021 23:43:08 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u8so4687682ior.13
        for <linux-iio@vger.kernel.org>; Thu, 18 Feb 2021 23:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3R+dhzpYGkmgjeok4oqGNlL7AiI2NJ/NrT/AIhJYy2M=;
        b=V8XKtNzTbR4ZiO9QNqgtG87qFhCsCLhiBy7bZNk7xXMox3FeBLsUZXmbUlPtCRR5bB
         V36R2dfZoCvRFaRBRJcVDx9+XjWYGiLF0H0Nbg7TGH/59E0gCjQrOFtnyMwGZ4KzqiAN
         cLKZdLTVfpCd2aTlGw86X550ZFEOWYRGWGtM8cTTB57XDoTVxsnDjgQO0YeSAfWYcu1x
         f40s90H/GhgyjADbX21bZXLXDJ6SD0ZKAj0wT6Q3OI3jLUYY1yNEs2ZVf/wRwRIXvdbJ
         qApGZW7KD8/VsyHliJUI/cItpFghtgNjzSc0JDcyO2Ztct8JQjWlbKYnU243n3BdlgBW
         5OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3R+dhzpYGkmgjeok4oqGNlL7AiI2NJ/NrT/AIhJYy2M=;
        b=a9H4L46lvR5ubUQlfALIe4tS+ztVpyAaYM1xaDdU/dPvUNpWFJYrer8fX+3OpqcywR
         RFs8fkP3iOQdjBVSE0QmQwyOcPiYyHJ2bBErTC2S9TozBFW8fvfj3TwGsIBl9kH5diDs
         j4uE0LCb68LEKjO5Vd8zzE4OwwfmXHSLDyjohp2xn5gCLcg3TqePFfOx6Hi7QB1diTiP
         hKRdx0qDhEVqrm3kkdwKV44UCBwvLEwYCfp2PdCVitQR4jREFv3r687sF82vOPpXOg46
         f1iH3JyF7TLBS+gG8PvHi8VMP5mIOHurNJyq1wQWOohHCzP6vk33Vv/RPtsDgHQQEpu8
         1IBA==
X-Gm-Message-State: AOAM531HGVC1fT7kVnlu8MTm0uoFenPmWBtmqKn4Kp63UAr7IZBO/DGD
        b+vsDDglvVVbLaSh+xycHc6Okg2GjT2wdJ6paZU=
X-Google-Smtp-Source: ABdhPJzi8FpSD0ln3IVKhnq0P7ddic56St+QHfiD9u2O4P8KX65PMEiM2yVqzGvd392MqGS6EuD22tO0BgQB6+m/VaQ=
X-Received: by 2002:a02:9425:: with SMTP id a34mr8402794jai.79.1613720587853;
 Thu, 18 Feb 2021 23:43:07 -0800 (PST)
MIME-Version: 1.0
References: <202102172355.IQoU3jH8-lkp@intel.com> <MN2PR03MB51995BFEE1DA0E625D33D40BF9849@MN2PR03MB5199.namprd03.prod.outlook.com>
In-Reply-To: <MN2PR03MB51995BFEE1DA0E625D33D40BF9849@MN2PR03MB5199.namprd03.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 19 Feb 2021 09:42:56 +0200
Message-ID: <CA+U=Dsoo=oggDiNgFxU-_RffekHhEa3Amu6SpPLtPqjbyu1ATA@mail.gmail.com>
Subject: Re: [iio:testing 44/53] ./usr/include/linux/iio/buffer.h:16:2: error:
 unknown type name '__u32'
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     kernel test robot <lkp@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 19, 2021 at 9:39 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: kernel test robot <lkp@intel.com>
> > Sent: Wednesday, February 17, 2021 5:31 PM
> > To: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: kbuild-all@lists.01.org; Jonathan Cameron
> > <Jonathan.Cameron@huawei.com>; Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com>
> > Subject: [iio:testing 44/53] ./usr/include/linux/iio/buffer.h:16:2: error: unknown
> > type name '__u32'
> >
> > [External]
> >
>
> I already fixed this before the lkp bot.

I forgot to mention.
Fix was:
https://patchwork.kernel.org/project/linux-iio/patch/20210217073638.21681-2-alexandru.ardelean@analog.com/

to include <linux/types.h>

It's funny, because this only showed up when I tried a make allmodconfig.

>
> > tree:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/jic
> > 23/iio.git__;!!A3Ni8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7KOLcO
> > J5ELyL-IHFus7OaIGGn4pRWiSFk665kw$  testing
> > head:   0fd146b288591a8139220fec417dfc5652820480
> > commit: 861a03649026b4c4ace807af241ba719976b90e4 [44/53] iio: core: Add
> > mmap interface infrastructure
> > config: x86_64-randconfig-c002-20210216 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > reproduce (this is a W=1 build):
> >         #
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/jic
> > 23/iio.git/commit/?id=861a03649026b4c4ace807af241ba719976b90e4__;!!A3N
> > i8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7KOLcOJ5ELyL-
> > IHFus7OaIGGn4pRWiS371BwdQ$
> >         git remote add iio
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/jic
> > 23/iio.git__;!!A3Ni8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7KOLcO
> > J5ELyL-IHFus7OaIGGn4pRWiSFk665kw$
> >         git fetch --no-tags iio testing
> >         git checkout 861a03649026b4c4ace807af241ba719976b90e4
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from <command-line>:32:
> > >> ./usr/include/linux/iio/buffer.h:16:2: error: unknown type name '__u32'
> >       16 |  __u32 type;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:17:2: error: unknown type name '__u32'
> >       17 |  __u32 size;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:18:2: error: unknown type name '__u32'
> >       18 |  __u32 count;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:19:2: error: unknown type name '__u32'
> >       19 |  __u32 id;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:36:2: error: unknown type name '__u32'
> >       36 |  __u32 id;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:37:2: error: unknown type name '__u32'
> >       37 |  __u32 size;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:38:2: error: unknown type name '__u32'
> >       38 |  __u32 bytes_used;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:39:2: error: unknown type name '__u32'
> >       39 |  __u32 type;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:40:2: error: unknown type name '__u32'
> >       40 |  __u32 flags;
> >          |  ^~~~~
> >    ./usr/include/linux/iio/buffer.h:42:3: error: unknown type name '__u32'
> >       42 |   __u32 offset;
> >          |   ^~~~~
> > >> ./usr/include/linux/iio/buffer.h:44:2: error: unknown type name '__u64'
> >       44 |  __u64 timestamp;
> >          |  ^~~~~
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://urldefense.com/v3/__https://lists.01.org/hyperkitty/list/kbuild-
> > all@lists.01.org__;!!A3Ni8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7
> > KOLcOJ5ELyL-IHFus7OaIGGn4pRWiQdYNMyhA$
