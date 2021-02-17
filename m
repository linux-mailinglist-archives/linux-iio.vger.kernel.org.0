Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDD31D5AD
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 08:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBQHS7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 02:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhBQHS4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 02:18:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE9C061574;
        Tue, 16 Feb 2021 23:18:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id a7so1575630iok.12;
        Tue, 16 Feb 2021 23:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WwSO388j03PlPPhd+5an/8/hstwWVN+5P7BM1bL1FwU=;
        b=pzk0vqDQz+RiO9YEWBvf21g9o5dCwUx2WFodeaGnrnY8EopO6XX4knxqTJE6Xz3tK/
         UvHuL19hVCHrFW0Vu7C+5BPWQFa8ClBwJiKc6Gt24VUfy058xhTLOoqSQtdZGYT0hbT6
         J9oSUE85wTiRce8peuKVz7tl6yFWfo0wO++A3VjqZ0HDTJ/F1cLzdNQrLKvn2HLVRY+d
         PwL1RD37ItTYyxb9Y3J70/9trA1MvcW0CVHoM7vvvZ/U0/RoCYQsDF0JjGrnGI/jjNB8
         PyLdYfU1HeCaPS5rzLcGutQto/Eraq5NUtp3u+/0Hcp8RKeioGirU3JIl6a4W44EGIZE
         EUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WwSO388j03PlPPhd+5an/8/hstwWVN+5P7BM1bL1FwU=;
        b=YwY6xyu59ahBRK1PVb/MzxFDbm0bHreUj/j94p9xVKFM7aHGWQMyQ7FRLJCEgX6pvf
         CISftA2OlseYWqhZK9AtrBPnT5Xzd1NrfJoJIajxduGGl1QReOtD/uexsezy84wSq+PX
         7prcD0QWfaJ0Gda2bQZZXuff6iLETgZ8Bik6mgRFv39b7Bk2+3Ln1Z/RYihtEET9+C7n
         hkAjkqkUWTZmPaLQtYIG7o/rk+meiCP1jcWzii6AIfetGmVK6r6q0Dk5QdhRGPB3d9zc
         ERf5tkwx6EEPAKykp13Q01HKSrI5eT7Oc5pvFSC8+IYlSAdfTJ0q2ckmy1Lk1kjtFC4s
         +bdA==
X-Gm-Message-State: AOAM531E08BJCUS43SHUUonn4qtq+du6BLWP1fyRHAqIneN3BFZ9bMtK
        eP8iQLJcOj7JkgW9KFrAlkhS26/X7XGsFRVQsQk=
X-Google-Smtp-Source: ABdhPJwWsLNpWl9Cd2N5qACv3dNiC061SGj0TT1jCwd0YBd6jFlNmhLr9a5Sfk7CSP+97zoVi/iuDn25mWrlcLFPsFo=
X-Received: by 2002:a02:2944:: with SMTP id p65mr23243403jap.91.1613546295791;
 Tue, 16 Feb 2021 23:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20210215143234.3248-1-alexandru.ardelean@analog.com> <20210216200023.6e4dcde9@archlinux>
In-Reply-To: <20210216200023.6e4dcde9@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 17 Feb 2021 09:18:03 +0200
Message-ID: <CA+U=DspGd=x+iL2Smzoks6g_MN8kCT8dj8iambAWg3A4JwA1YQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] iio: core: Add mmap interface infrastructure
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 16, 2021 at 10:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 15 Feb 2021 16:32:29 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
>
> Hi Alex,
>
> I'm a little nervous about adding the userspace interface used in this
> series, but it seems reasonable and as you say below, is close to what
> Analog have been using for years.
>
> So I've applied it to the togreg branch of iio.git and pushed out as
> testing as normal.   I'm not going to push that out as anything I can't
> rebase for at least a few weeks, so if anyone else wants to take a look
> that would be great.
>

Oops.
I actually was preparing a new version yesterday with a fix for this
and a few tweaks.
This issue seems to appear on 64 bit only.

Will send it.


> One slight tweak was needed. I forced it with min_t(size_t,...
> as it should always be at least as bit as __u32 so should be fine.
>
>   CHECK   drivers/iio/industrialio-core.c
> In file included from ./include/linux/kernel.h:14,
>                  from ./include/asm-generic/bug.h:20,
>                  from ./arch/x86/include/asm/bug.h:93,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/gfp.h:5,
>                  from ./include/linux/slab.h:15,
>                  from drivers/iio/buffer/industrialio-buffer-dmaengine.c:=
7:
> drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function =E2=80=98=
iio_dmaengine_buffer_submit_block=E2=80=99:
> ./include/linux/minmax.h:18:28: warning: comparison of distinct pointer t=
ypes lacks a cast
>    18 |  (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>       |                            ^~
> ./include/linux/minmax.h:32:4: note: in expansion of macro =E2=80=98__typ=
echeck=E2=80=99
>    32 |   (__typecheck(x, y) && __no_side_effects(x, y))
>       |    ^~~~~~~~~~~
> ./include/linux/minmax.h:42:24: note: in expansion of macro =E2=80=98__sa=
fe_cmp=E2=80=99
>    42 |  __builtin_choose_expr(__safe_cmp(x, y), \
>       |                        ^~~~~~~~~~
> ./include/linux/minmax.h:51:19: note: in expansion of macro =E2=80=98__ca=
reful_cmp=E2=80=99
>    51 | #define min(x, y) __careful_cmp(x, y, <)
>       |                   ^~~~~~~~~~~~~
> drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:28: note: in expans=
ion of macro =E2=80=98min=E2=80=99
>    69 |  block->block.bytes_used =3D min(block->block.size,
>       |                            ^~~
>   CHECK   drivers/iio/buffer/industrialio-buffer-dmaengine.c
>   CHECK   drivers/iio/industrialio-buffer.c
> drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:35: error: incompat=
ible types in comparison expression (different type sizes):
> drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:35:    unsigned int=
 *
> drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:35:    unsigned lon=
g *
>
> Thanks,
>
> Jonathan
>
>
> > Changelog v2 -> v3:
> > * https://lore.kernel.org/linux-iio/20210212101143.18993-1-alexandru.ar=
delean@analog.com/T/#u
> > * added 'Documentation: iio: add doc for high-speed buffer API'
> > * add 'iio: buffer-dma: split iio_dma_buffer_fileio_free() function'
> > * patch 'iio: buffer-dma: Add mmap support'
> >    - unwind free on error path in iio_dma_buffer_alloc_blocks()
> >    - removed double mm.h include
> > * patch 'tools: iio: add example for high-speed buffer support'
> >    - call IIO_BUFFER_BLOCK_FREE_IOCTL on the error path of the
> >      enable_high_speed() function
> >
> > Changelog v1 -> v2:
> > * https://lore.kernel.org/linux-iio/20210211123353.78963-1-alexandru.ar=
delean@analog.com/T/#t
> > * removed IIO_BUFFER_BLOCK_FLAG_CYCLIC flag; will be added in a later
> >   patch
> > * removed extra line in tools/iio/iio_generic_buffer.c
> > * patch 'iio: core: Add mmap interface infrastructure'
> >   added docstrings for new hooks (alloc_blocks, mmap, etc)
> >
> > This is basically Lars' work adapted from branch:
> >   https://github.com/larsclausen/linux/commits/iio-high-speed-5.10
> > [hopefully i got the stuff correctly from that branch]
> >
> > What is different, is that this one is adapted on top of the multibuffe=
r
> > support (currently at v5) discussed here:
> >   https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ar=
delean@analog.com/T/#t
> >
> > Also, adapted an example for high-speed/mmap support in
> > 'tools/iio/iio_generic_buffer.c'
> >
> > The example is adapted from libiio:
> >   https://github.com/analogdevicesinc/libiio/blob/master/local.c#L51
> > but will all the ioctl()s organized after the one that are reserved
> > (hopefully) for IIO
> >
> > Tested that mmap() works.
> > Moved (artifically) valid buffer0 as buffer2 and the operation still
> > works.
> >
> > Alexandru Ardelean (3):
> >   Documentation: iio: add doc for high-speed buffer API
> >   iio: buffer-dma: split iio_dma_buffer_fileio_free() function
> >   tools: iio: add example for high-speed buffer support
> >
> > Lars-Peter Clausen (2):
> >   iio: core: Add mmap interface infrastructure
> >   iio: buffer-dma: Add mmap support
> >
> >  Documentation/iio/iio_high_speed_buffers.rst  | 100 ++++++
> >  Documentation/iio/index.rst                   |   2 +
> >  drivers/iio/buffer/industrialio-buffer-dma.c  | 324 ++++++++++++++++--
> >  .../buffer/industrialio-buffer-dmaengine.c    |  22 +-
> >  drivers/iio/industrialio-buffer.c             | 158 +++++++++
> >  include/linux/iio/buffer-dma.h                |  27 +-
> >  include/linux/iio/buffer_impl.h               |  23 ++
> >  include/uapi/linux/iio/buffer.h               |  49 +++
> >  tools/iio/iio_generic_buffer.c                | 184 +++++++++-
> >  9 files changed, 841 insertions(+), 48 deletions(-)
> >  create mode 100644 Documentation/iio/iio_high_speed_buffers.rst
> >
>
