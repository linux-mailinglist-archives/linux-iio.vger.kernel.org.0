Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0F42AAD2
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhJLRdN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhJLRdM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 13:33:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A55C061570;
        Tue, 12 Oct 2021 10:31:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p13so2636256edw.0;
        Tue, 12 Oct 2021 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZKICKNAnObTFzQ9F7XWOBA0XUwHyYbLFkyZit+1d5g=;
        b=Ij+FsFfZI5UX+Y/qkuz4aFB9eaxY2aKki5FdBkthomTCgMX1mQXlOVxw3evBC01YDZ
         xMDPplfMwa2CmCZCuSqA6OwINWKNLc8ejrwqjrzfjZX6QG6qAuD/ZR4kVbqogI8Ff1oh
         7VR/hcT8+jfkazh8KwcsB47YQCA2JsfDP4CFRdFCKFaWx4qajvK5mLlIHmxIaIJUI5of
         LRgDTgsSfdR6Lak0/s2lRiozOhvK83+wXhOiPUWaM/UbXeqKZoxX4TcNh5s63iggw2Rr
         RBUN6DQbW5sIXPc+6gAiGTdA/iFMfkHQBOV1wXjKcXe+oiOXc0rIACrOroatr7YvE3zE
         jqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZKICKNAnObTFzQ9F7XWOBA0XUwHyYbLFkyZit+1d5g=;
        b=LZG7gpYy1e95DLd0UeKyAPjuqSxRcqqxZumcz9lV94yCTWymxkMVlveTEBNxrJRXC7
         R2vC6tenIkYIDTUBncIpg9yQQHzXnEuwstctNZSuTRBiSiWJidapttc5cTKF2du6kyiT
         7QEIl/a7ThBZIt9yHCdXL1lqbS4a449a4jAu5MGlNjcrpFS2hKZ3MRkCraRTWlMUmlfI
         nxcQd6VTbAey35iqMUTHVgENe9upI8f72bPx1IE17RNRWISp5gRN/SBEEwkVPwebSNlD
         gExFjAYX88TlcO5VI0SXDtz0N3si4SDNbkdxYQPK8LA9G8hnOTnKIv/Ktq1wwIyrISaJ
         MD2A==
X-Gm-Message-State: AOAM530vsO/K7VwoQAYpHl8KPrkUeoDDCWFWAktbc5VtoGnFo3uZiNkK
        13mDLo56WhGxX0zAfLefPyw11Fhl9WO2g+EYGBvhzQZoRswAjKiLvT0=
X-Google-Smtp-Source: ABdhPJxUpf3EhpB0tH7DgeGGmHNZCg+Wq/mbXsuyXD56sW+wkENYhth1plSN6eRMJO4lB8aPJJ90OZldwIXimnPwlcI=
X-Received: by 2002:a17:906:eb86:: with SMTP id mh6mr34846778ejb.141.1634059868894;
 Tue, 12 Oct 2021 10:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211012092513.1349295-1-yangyingliang@huawei.com> <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
In-Reply-To: <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 23:30:21 +0300
Message-ID: <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
> >
> > When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
> > set to 'i - 1' to prevent double-free when cleanup resources.
> >
> > BUG: KASAN: double-free or invalid-free in __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
> > Call Trace:
> >  kfree+0x117/0x4c0
> >  __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
> >  iio_buffers_alloc_sysfs_and_mask+0x60d/0x1570 [industrialio]
> >  __iio_device_register+0x483/0x1a30 [industrialio]
> >  ina2xx_probe+0x625/0x980 [ina2xx_adc]
> >
>
> Makes sense.
> Thanks for the catch.
>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

...

> >                 ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
> >                 if (ret) {
> > -                       unwind_idx = i;
> > +                       unwind_idx = i - 1;
> >                         goto error_unwind_sysfs_and_mask;

I prefer to see

- for (; unwind_idx >= 0; unwind_idx--) {
+ while (unwind_idx--)

instead.

> >                 }
> >         }

-- 
With Best Regards,
Andy Shevchenko
