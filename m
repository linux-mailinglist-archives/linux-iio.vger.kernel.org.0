Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795B4468BE7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhLEPkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhLEPkI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:40:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79CC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:36:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so32828421edu.4
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfyWcia477jRjnaqGLXMSS9piPGRAtZiaT5a/9amCjU=;
        b=RWcLoISuRhrzgkcxOniHPiIJGZj7T58RPma6ekvaVnzwe9pF+iWD8BZLDYhRnMSl1T
         mtFvisCcp1ijOQ5JKyU4GGX6Jtq1rhqE53Rld2J+OFxPTMMaeKh3ZYZ+s3BXWKfcm8tg
         M5rNTZZbo24Yj8OTaX4KWPPDt3Y5+7xrL70E+tMYyM+SAsgIYURfoPp74eJ0yUy9lXIr
         WMfjYb2/ZmJir2N/QSM8C58kuGz3aoFoEmxNImmSvq7Y58IVAHORoOoEwrWQXpjNY7XD
         PZjX/Wgbz9zcTPODqAlCOWrOy0oKGY8iPNw6yxrHEqr4+fUy7UlItlgQWn7IZeiitAEW
         Hugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfyWcia477jRjnaqGLXMSS9piPGRAtZiaT5a/9amCjU=;
        b=E6lAdu+t0UvkcKt/TTphagTRspVj//fit0Q9+E9G65/wdDt18jz9t4zosX88z+NUGg
         dwoLxghXZCvXVhQWfraPU2e08WsKVTC2tYGMeKes7EutbUdXsYF0Fes6ldymhawGLoOW
         1eQyur/FNqM1mF9DsMFiSiYbBVP1QkOU4OEmdVdicUFNMHpcaFbhRDpajLqeqPgoHOLB
         zXRzuBA/Cx7xy9RtbrVHYLNFz3XZlJD2Wn1U0BBBF+8IktgrhCV1NfkO0aX4pYkwdanV
         O2L00dkl2Ri0W0GOIFYEFH1UeC6GXRy5dgB/pNegHLJ4tUBqqt+P0BLttIMNHLg3Dma2
         ajOw==
X-Gm-Message-State: AOAM533ht8goxrnXV4mXGq2105G0+6Q6GN94GVYGfwDsPaWFbo3LUk/6
        TXwt+2aH/Sn21/huxThj9x37D9ZnKHeQtJ2aNZ63eaY//HK302Oy
X-Google-Smtp-Source: ABdhPJwF1V36Z4y9+ayMzjw6hBGlPeSIPAT+BZ0DzyIuhxvEi4iEGRH83LWK6aLsDGz+GHDOMl1NjufHXHQLxjtJYY8=
X-Received: by 2002:a17:906:9b92:: with SMTP id dd18mr10101034ejc.425.1638718599221;
 Sun, 05 Dec 2021 07:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <20211204171237.2769210-2-jic23@kernel.org>
 <CAHp75Vd7vPfNMMBwDYuFSNtSZryyeGEDp9P6wcWCuJrz5B2OqA@mail.gmail.com>
In-Reply-To: <CAHp75Vd7vPfNMMBwDYuFSNtSZryyeGEDp9P6wcWCuJrz5B2OqA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:36:03 +0200
Message-ID: <CAHp75VdB-rV-KxwpWtapG7jhJHcdH8az9FWt+WgKNWCpZpojQg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] iio:dac:ad5755: Switch to generic firmware
 properties and drop pdata
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 5, 2021 at 5:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > +       const struct ad5755_platform_data *pdata = NULL;
> >         struct iio_dev *indio_dev;
> >         struct ad5755_state *st;
> >         int ret;
>
> > -       if (spi->dev.of_node)
> > -               pdata = ad5755_parse_dt(&spi->dev);
> > -       else
> > -               pdata = spi->dev.platform_data;
> > +       if (dev_fwnode(&spi->dev))
> > +               pdata = ad5755_parse_fw(&spi->dev);
> >
> >         if (!pdata) {
> > -               dev_warn(&spi->dev, "no platform data? using default\n");
> > +               dev_warn(&spi->dev,
> > +                        "no firmware provided parameters? using default\n");
>
> It's fine to have it on one line (and not related to the 80 vs 100
> case, it's about string literal as the last argument).
>
> >                 pdata = &ad5755_default_pdata;
> >         }
>
>
> Perhaps
>
>     const struct ad5755_platform_data *pdata;
>     ...
>     if (dev_fwnode(...))
>       pdata = ...
>     else
>       pdata = &_default;
>     if (pdata == &_default)
>       dev_warn(...);
>
> ?

After reading it again, I realized that pdata may be NULL in fwnode
case. So, original code is fine, but I would rather move NULL
assignment closer to the conditional (up to you, I'm fine with either,
i.o.w. you may ignore this comment).

-- 
With Best Regards,
Andy Shevchenko
