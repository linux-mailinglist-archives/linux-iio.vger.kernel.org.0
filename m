Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1C2B8D38
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 09:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgKSIaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 03:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgKSIaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 03:30:17 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA315C0613CF;
        Thu, 19 Nov 2020 00:30:15 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id i9so5128100ioo.2;
        Thu, 19 Nov 2020 00:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4Iz1s1fJTxP7zb4NvtW/FqHShCUWaNlwUSR2sabpVU=;
        b=qxEYb6xiR0jOFA3N26xEwKdBfFHjLchAIWmvRrJVw/eM7tU4v3RH4qhoOW6xy1JLti
         g68ampZF6Kcjzf/70O2nMcPisohdohdLBtj2C8plop4rVpUl41rnxRelhezdEcbArfoU
         HzPq0Sniw8h3F9cQXbYaoNEcP4MkonGyECuwZrjlYZAKoDdNmN8T2Y6m7DF7+usqPj2g
         Elxwby8nGGD2lM+X+/O8ALY5u9yO2rm8lPpqxgOJ7h+ceZqWG1bsr1piUpjDED6hQH+m
         cshA0QB5MpBLTRupWLm/qbPs//ZQy+lO4u7ZEYpwKM69EBdLFz7CHaCXYnqAZ8r7Dp31
         QyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4Iz1s1fJTxP7zb4NvtW/FqHShCUWaNlwUSR2sabpVU=;
        b=XIl4fJH+Hu6NsRaSTP2dwOA+2DrLDyXY+71u9aVFuTZahUKX3EgQ9J71OqpJ9mk0TX
         6/IGEz6+REmQ/K8Wu4zp4v6OBdeicu5Sq0P+/IkjvggJQLuuISg8kIfm471QdImpm6yl
         Bop5YGjsnR4AuGrQSv4JxVh/AUy2Qo54jXWIgCeKUgm/1YjdwXeXeF7qz0j60++CubE8
         sj6T4mi9y0QEBr1BS3mFpMwaShZObMPj6SnxTKgqSq2LP8osip4YEugNPESu5C3U1Meq
         ogY1x8xbiJZqqGF/rO9wftIYZRxwMV0ZkBAkqCMg1TUAmX5K+0GDWuU/AJ6Iyiz+krto
         GoYA==
X-Gm-Message-State: AOAM530V2gxs4+rmR8woFLNXUfRFPZC0inr/INEKH/V90AvM091hc65y
        nGxTYFTFC2O0xKpWZYE7dhL/jKV9fbFgJH0iMcRw9cnPT/E=
X-Google-Smtp-Source: ABdhPJx8TCb81IEibNNxnAybbh0S5BurAvdq3dyZxFVlAQAuadY4n5277AvTM/dP3alxf3T5Bnq6jpmJeICtRhZzZpE=
X-Received: by 2002:a02:208:: with SMTP id 8mr13316809jau.79.1605774615047;
 Thu, 19 Nov 2020 00:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20201112091050.84991-1-alexandru.ardelean@analog.com>
 <20201113094059.152651-1-alexandru.ardelean@analog.com> <20201114162021.3caebdab@archlinux>
In-Reply-To: <20201114162021.3caebdab@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 19 Nov 2020 10:30:02 +0200
Message-ID: <CA+U=DsqYqBGf3VsUqxxuc3M+=DZgU-tt0vhGqXR_AUS5TmJ3mg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: ad_sigma_delta: Don't put SPI transfer buffer on
 the stack
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.tachici@analog.com, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 14, 2020 at 6:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 13 Nov 2020 11:40:59 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Use a heap allocated memory for the SPI transfer buffer. Using stack memory
> > can corrupt stack memory when using DMA on some systems.
> >
> > This change moves the buffer from the stack of the trigger handler call to
> > the heap of the buffer of the state struct. The size increases takes into
> > account the alignment for the timestamp, which is 8 bytes.
> > So the buffer is put at an offset of 8 bytes.
> >
> > Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> There are neater options for solving this problem - see inline.
>
> In particular I don't think you have a problem with setting the
> rx and tx buffers to use the same memory.
>
> > ---
> >
> > Changelog v1 -> v2:
> > * bumped the buffer on state struct to 24 bytes
> > * increased the offset to 8 bytes to account for the timestamp alignment
> >
> >  drivers/iio/adc/ad_sigma_delta.c       | 2 +-
> >  include/linux/iio/adc/ad_sigma_delta.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> > index 86039e9ecaca..9f730c9d6aaa 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -395,9 +395,9 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
> >       struct iio_poll_func *pf = p;
> >       struct iio_dev *indio_dev = pf->indio_dev;
> >       struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> > +     uint8_t *data = &sigma_delta->data[8];
> >       unsigned int reg_size;
> >       unsigned int data_reg;
> > -     uint8_t data[16];
> >
> >       memset(data, 0x00, 16);
> >
> > diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> > index a3a838dcf8e4..8fb74755f873 100644
> > --- a/include/linux/iio/adc/ad_sigma_delta.h
> > +++ b/include/linux/iio/adc/ad_sigma_delta.h
> > @@ -80,7 +80,7 @@ struct ad_sigma_delta {
> >        * DMA (thus cache coherency maintenance) requires the
> >        * transfer buffers to live in their own cache lines.
> >        */
>
> If you do end up with something like this, it needs a clear explanation of 'why'
> the size is 24 bytes.  No good just having it in the patch description.
>
> > -     uint8_t                         data[4] ____cacheline_aligned;
> > +     uint8_t                         data[24] ____cacheline_aligned;
>
> This is downright confusing.  I'd just split the buffer into tx and rx
> parts.   The first (doesn't matter which) needs to be marked __cacheline_aligned.
> If the rx is second mark it __aligned(8) to force that to be appropriate for
> the timestamp.
>
> Or... (I haven't checked thoroughly for this from point of view of how it is used
> in the drivers) use the same buffer for tx and rx.  That is supposed to be safe for
> SPI drivers though wonderfully there is a ? after the statement of that in
> include/linux/spi.h.  I think that is just pointing out that microwire doesn't
> support duplex rather than saying it's invalid in general...

I'm a bit paranoid to use the same buffer for RX & TX [in general].
It sounds like this could hide some bugs in some weird DMA implementations.
The DMA implementations could be fine on their own, but they wouldn't
expect that TX & RX buffers point to the same place.

>
>
>
> >  };
> >
> >  static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
>
