Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8B22917C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 09:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGVHCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 03:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgGVHCR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 03:02:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E74C061794;
        Wed, 22 Jul 2020 00:02:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t198so982209oie.7;
        Wed, 22 Jul 2020 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJC5QEU2OhljyIVb/XYUZ6djTa9zvKcNmndXYSiKYsM=;
        b=jEiYkmjv5TX7ymw7G8gPvzlSMcPDY4xFzMus5jho17WIrARN5ilcou0pBRkOGWyg9z
         JzfESPBJDTayb9fwwC065xNk3FcPTa+1WKc0byGwDRkWQksQ5BMUqpvW55Gz6jXHojHL
         ATRYOHKGuPNgg8ZyApHrEJLpf5nvcMMFzVVuP/8J4FmAuAO3elDk781IHEWeK0wAc7vB
         lTLRllM8sKoo48gIU/9NvyVZamIwyRtIplypKzl9FbRkFlEbOS+jBSzNwI9xZZfKl+F4
         b2lEGoAi+IkADEYy1EP8BAAiPGUhLHtSlTizfYNcrOAVD2HVPeljzGv7xGvHVXlzmllK
         hfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJC5QEU2OhljyIVb/XYUZ6djTa9zvKcNmndXYSiKYsM=;
        b=RgDg+pe8/7V1fBibeRc0Suxu661mXFOzXFNsXrzD+6TTm8yqVBoR9TXFSXww5U4X46
         BlEKcdCxGyTh3vVyMKwh+nRD8keaVlUzD2cpSvph66c9opR+JQ5WKL7dqp2IopITq8Uf
         X909eto2BHwwUgTH+f2NFtmDuyaKB87hq2Qb7GrcVg0CygF9UT3saDnuQj5UYCFKFoCG
         H33ua8e4ht9JpYLu2ugDaO3og3KvcWe7BxQjDTomaqisL/EgGmbcd6r2coHMuBNii1Vy
         LcaAzXAH+penNks/M3LULsw7fll6QbQJ5Hw06yYmAqrS1A09Wz/0X7EeIES2Q1GV9wEr
         hz2g==
X-Gm-Message-State: AOAM531prbEpV1Ypwb00XljUOe7pwYvIRfHH3iagCeWhqcArB2Tzlve+
        1wwfDI+7I3D/FqNUY+2evaKR7i1aGwFSNrIU+eM=
X-Google-Smtp-Source: ABdhPJxUhNmbs9sDXjyToJlT9bArLQEmdAClQkyxp12Wm1VqOOBvyvXhnTpAolKj7WGZtoNgmABHVPCh5b2D+JUh4IE=
X-Received: by 2002:aca:2807:: with SMTP id 7mr6140202oix.140.1595401336832;
 Wed, 22 Jul 2020 00:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200721112409.220536-1-alexandru.ardelean@analog.com> <CAHp75VfY_6pg=6atYwd=JcPd1MZqHZh5Dj_QYdQyS=5ENHL5aQ@mail.gmail.com>
In-Reply-To: <CAHp75VfY_6pg=6atYwd=JcPd1MZqHZh5Dj_QYdQyS=5ENHL5aQ@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 22 Jul 2020 10:02:05 +0300
Message-ID: <CA+U=DsopNdqrEdnjY2r3mfd1bqeTR81PdH1mbtXSGHzUEpbarQ@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad9523: convert rest of driver to device
 managed functions
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 10:34 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 21, 2020 at 2:27 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > The driver pretty much uses device managed functions. The only left-over is
> > the iio_device_register() function, which also requires an action-or-reset
> > hook to disable the regulator on the remove and error path.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> ...
>
>
> > +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> > +       if (ret == 0)
>
> > +               dev_info(&spi->dev, "probed %s\n", indio_dev->name);
> >
> >         return ret;
>
> Please, drop this useless spam (I agree here with Greg KH) and use simply
> return devm_iio_...(...);

I was also a bit undecided whether to keep it.
Will drop.

>
> --
> With Best Regards,
> Andy Shevchenko
