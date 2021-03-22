Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F52344610
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 14:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCVNlw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhCVNlj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 09:41:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E288EC061574;
        Mon, 22 Mar 2021 06:41:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y5so10965901pfn.1;
        Mon, 22 Mar 2021 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VQILtipxuqarvUIaD3xJRAgP5hwigQwMayZv46RZ9Y=;
        b=TcFXuGgVyk07+JCYVkDGOqXVqkf3qaD6ptVCDfNRNk4n/J1CN2EEgCLnVe38tlofFJ
         /0oNJDXW9p2IBCOhNe6RXWEGpwz1GQdQ2EGWjCgxQbl/vC9BLz96K+9PctEU5qzGXufG
         3lK0epxM4QdC0frQKJCmBUMC/RMy8dulJHg1SCCF4hF2NYigjvqe07j1aiogVLHOb5zB
         S0cTQ3Xv2e08nXXccE6MSwyR6Hkc/NfL2MrbG6feLG9EHY6Mc9BD4sLG4HG8wuGEPE5Z
         X8fl65bMJSnaCq85niGVxHR9BbrOaq4p6TIcDNLaV72EELY9u69ODesv7geSOKDtwUXq
         ZwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VQILtipxuqarvUIaD3xJRAgP5hwigQwMayZv46RZ9Y=;
        b=cJTd4DQLpPjWHZaXLYGtj5xMMgrYk9zdtijvXjZBCdv7EsvfUhs7qgangZ3PJkZ8nV
         hDjt1XiYMUJJXYuKPbWQtRgguAzXlBGT3fDS3+GPl4IzfFP6nd2MDdAktW8LO+rLJOs7
         hK1/1Azyu9+Ddbxjmokt1QXxpC7AkIYNdxGiV93WwqVC6ddK0zsOIrRLFOlwGWOLvVHx
         QV8FBQugArY/juMvTHBCfjHyko7iqOolTX01cYHrhcTEBbBq/ALk34QQSQvqMkgg4tTx
         bWT040ZnLBPXGcj8oLOr4ijDAzBNKotBkemXEFdBBPCp+Sdlp4tLXyx75d4PXXo95tod
         v+vQ==
X-Gm-Message-State: AOAM532/+D8RsOsFDDc6wV4PxiLtLpSOzpbrkdJN7XvB8PP2OIgR7cLM
        5QevLI1oetADl3nVAh/742oXtCtrDlShGUTrIik=
X-Google-Smtp-Source: ABdhPJwzZjTrwJMymB1Q49xAV3xvOiz2bwI4hU0jJFneP/IuUVHGJ1jQN1uW1U+cdb5gtKf1k4+csgbwW9judtId1PQ=
X-Received: by 2002:a65:4bc5:: with SMTP id p5mr22367563pgr.74.1616420498366;
 Mon, 22 Mar 2021 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
 <20210319144509.7627-4-o.rempel@pengutronix.de> <CAHp75Vcn=g-3NRXAEd5jEu4uxD_fHbybiDg=t9QiY80TNZuTgQ@mail.gmail.com>
 <20210322103034.bd6swzn2udpvm66o@pengutronix.de>
In-Reply-To: <20210322103034.bd6swzn2udpvm66o@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 15:41:22 +0200
Message-ID: <CAHp75VeemLnMJWQOHL8qrqaher2kOn1xTye1tK2OPtpSHhwOcA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046 controller
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 12:30 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> On Fri, Mar 19, 2021 at 07:42:41PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 19, 2021 at 4:45 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

...

> > > +static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> > > +{
> > > +       /* Last 3 bits on the wire are empty */
> >
> > Last?! You meant Least significant?
>
> ACK. LSB
>
> > Also, don't we lose precision if a new compatible chip appears that
> > does fill those bits?
>
> ACK. All of controllers supported by this driver:
> drivers/input/touchscreen/ads7846.c:
> - ti,tsc2046
> - ti,ads7843
> - ti,ads7845
> - ti,ads7846
> - ti,ads7873 (hm, there is no ti,ads7873, is it actually analog devices AD7873?)
>
> support 8- or 12-bit resolution. Only 12 bit mode is supported by this
> driver. It is possible that some one can produce a resistive touchscreen
> controller based on X > 12bit ADC, but this will probably not increase precision
> of this construction (there is a lot of noise any ways...). With other
> words, it is possible, but not probably that some one will really do it.
>
> > Perhaps define the constant and put a comment why it's like this.

Okay, and what happens here is something like cutting LSBs, but it
sounds strange to me. If you get 16 bit values, the MSBs should not be
used?

So, a good comment is required to explain the logic behind.

> > > +       return get_unaligned_be16(&buf->data) >> 3;
> > > +}

...

> > > +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> > > +                                          unsigned int group,
> > > +                                          unsigned int ch_idx)
> > > +{
> > > +       struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> > > +       struct tsc2046_adc_group_layout *prev, *cur;
> > > +       unsigned int max_count, count_skip;
> > > +       unsigned int offset = 0;
> > > +
> > > +       if (group) {
> > > +               prev = &priv->l[group - 1];
> > > +               offset = prev->offset + prev->count;
> > > +       }
> >
> > I guess you may easily refactor this by supplying a pointer to the
> > current layout + current size.
>
> Sure, but this will not make code more readable and it will not affect
> the performance. Are there any other reason to do it? Just to make one
> line instead of two?

It's still N - 1 unneeded checks and code is slightly harder to read.

> > > +       cur = &priv->l[group];
> >
> > Also, can you move it down closer to the (single?) caller.
> >
> > > +}

...

> > > +               dev_err_ratelimited(dev, "SPI transfer filed: %pe\n",
> > > +                                   ERR_PTR(ret));
> >
> > One line?
>
> it will exceed the 80 char rule

It's fine here.

...

> > > +       spin_lock_irqsave(&priv->trig_lock, flags);
> > > +
> > > +       disable_irq_nosync(priv->spi->irq);
> >
> > > +       atomic_inc(&priv->trig_more_count);
> >
> > You already have a spin lock, do you need to use the atomic API?
>
> I can only pass review comment from my other driver:
> Memory locations that are concurrently accessed needs to be
> marked as such, otherwise the compiler is allowed to funky stuff:
> https://lore.kernel.org/lkml/CAGzjT4ez+gWr3BFQsEr-wma+vs6UZNJ+mRARx_BWoAKEJSsN=w@mail.gmail.com/
>
> And here is one more link:
> https://lwn.net/Articles/793253/#How%20Real%20Is%20All%20This?
>
> Starting with commit 62e8a3258bda atomic API is using READ/WRITE_ONCE,
> so I assume, I do nothing wrong by using it. Correct?

Hmm... What I don't understand here is why you need a second level of
atomicity. spin lock already makes this access atomic (at least I have
checked couple of places and in both the variable is being accessed
under spin lock).

> > > +       iio_trigger_poll(priv->trig);
> > > +
> > > +       spin_unlock_irqrestore(&priv->trig_lock, flags);

...

> > > +       name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> > > +                             TI_TSC2046_NAME, dev_name(dev));
> >
> > No NULL check?
> > Should be added or justified.
>
> name is set not optionally  by the spi_add_device()->spi_dev_set_name()

I didn't get it.
You allocate memory and haven't checked against NULL. Why?

If the name field is optional and having it's NULL is okay (non-fatal
error), put a comment.

...

> > > +       trig->dev.parent = indio_dev->dev.parent;
> >
> > Don't we have this done by core (some recent patches in upstream)?
>
> can you please point to the code which is doing it?

I believe it's this one:

commit 970108185a0be29d1dbb25202d8c12d798e1c3a5
Author: Gwendal Grignou <gwendal@chromium.org>
Date:   Tue Mar 9 11:36:13 2021 -0800

   iio: set default trig->dev.parent

-- 
With Best Regards,
Andy Shevchenko
