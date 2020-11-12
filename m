Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DC2B0296
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 11:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLKPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 05:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLKPI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 05:15:08 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F0C0613D1;
        Thu, 12 Nov 2020 02:15:06 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c80so5795875oib.2;
        Thu, 12 Nov 2020 02:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CyQ0uQ0w9dS+uyDjnnUPPq2ywGCJWQupqJd0QKx2Jk=;
        b=T3Yf8CTM/8OJgdJBdFg9/QHXAhF/LvM5Ds2Ek/AlhyesdxE5q9+/Vh7EqQ8jAYn7oS
         i9q+JMykbW2WrP9L64e16OkdpU2cs/Utpg6tjrnB18EpAWYQeWz/BmOGy0KPdOG0NTAT
         TGZyWkzXmT/8Dyc+NvDTCI4RsKCrTCEnGqrMP5Y+gF42fIZ5h8TW23ITvMTkM0jB1jaC
         VgBKYRKq608sI5Q5wjFgpNvlN1U4sauWxXDmiOmRrSnUVS1POaG0s/hUS3u404qjI/PO
         xtf+HdfXDnlFc2JKfBC4QSYVCB6poYa4gjEFGiD74s3Ow3ckzYZ0djptMOuKqkoMnryh
         52yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CyQ0uQ0w9dS+uyDjnnUPPq2ywGCJWQupqJd0QKx2Jk=;
        b=dxClFtdhE+G2p8eOH+xS17bHJ/ErFlF/426Hduf6RMxeQxZAzSdiGEHgaM8Cy0+Vlo
         hKJh56JLKoG+jjyBGlStdX9twunvVHOkibspGd621tNyGVMJyuTGudZGf55LJjTPFLqY
         Xb9fw7CmR5cL+HOkfUZXfzU9gAmvY65R5pC7Nm+4Ie1FEIdn39lM/BY0lq94/L+edndq
         HQyhUM08xjHkdr90cizeupkLKePWKDJz2QR29AWpaxuVg1Vqm5xYV0a8pMxMESk9MTfW
         6urIa9Bucco6Nuh0QZ+hlnp9yBNZDYe7k386jAv+dr1ZfMu1H5hCp96V2lqINEggcmJ2
         vyBw==
X-Gm-Message-State: AOAM531kaSY2wV2D7C/ZCWYPPokSPGH4Ja5/pfTygtHrIRpBBXCtqQMX
        l7bVd4ivk321X4yPg2lMdLiy6o8RkVnpWPS14MU=
X-Google-Smtp-Source: ABdhPJzlgOZnF3xFNLuVQ2ptL9JCtEg6M1eZm9ZZzysSxNqz+xdhZT/xW9vT2qpzHglWJzZ4xQm934XTFNBR6OF9eVo=
X-Received: by 2002:aca:420a:: with SMTP id p10mr4804532oia.117.1605176106010;
 Thu, 12 Nov 2020 02:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20201112091050.84991-1-alexandru.ardelean@analog.com> <49aea6de-9084-d5a2-a6be-967196570830@metafoo.de>
In-Reply-To: <49aea6de-9084-d5a2-a6be-967196570830@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 12 Nov 2020 12:14:55 +0200
Message-ID: <CA+U=DspP1NfHm2XyOc-Vqq=bzVea30K5pDoARUjw9H1zvst=Zw@mail.gmail.com>
Subject: Re: [PATCH] iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 12, 2020 at 11:55 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/12/20 10:10 AM, Alexandru Ardelean wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Use a heap allocated memory for the SPI transfer buffer. Using stack memory
> > can corrupt stack memory when using DMA on some systems.
> >
> > This change adds 4 bytes at the end of the current DMA buffer, which will
> > be used by the trigger handler.
> > This is required because the first 4 bytes are reserved for register data.
> >
> > Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >   drivers/iio/adc/ad_sigma_delta.c       | 4 ++--
> >   include/linux/iio/adc/ad_sigma_delta.h | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> > index 86039e9ecaca..33297f26508a 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -395,11 +395,11 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
> >       struct iio_poll_func *pf = p;
> >       struct iio_dev *indio_dev = pf->indio_dev;
> >       struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> > +     uint8_t *data = &sigma_delta->data[4];
> >       unsigned int reg_size;
> >       unsigned int data_reg;
> > -     uint8_t data[16];
> >
> > -     memset(data, 0x00, 16);
> > +     memset(data, 0x00, 4);
>
> Younger me didn't know what he was doing, this is wrong. We need the
> extra space for the padding and timestamp.
>
> We also can't put the beginning of the buffer at an 4 byte offset since
> it needs to be 8 byte aligned for the timestamp.

I'll correct this.
I was re-spinning this out of some old patches and discussions on this
that I have.
So, then this becomes 24 bytes? Or 16?

Something like:
uint8_t                         data[24] ____cacheline_aligned;

uint8_t *data = &sigma_delta->data[8];


>
> >
> >       reg_size = indio_dev->channels[0].scan_type.realbits +
> >                       indio_dev->channels[0].scan_type.shift;
> > diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> > index a3a838dcf8e4..ac4ac4752c62 100644
> > --- a/include/linux/iio/adc/ad_sigma_delta.h
> > +++ b/include/linux/iio/adc/ad_sigma_delta.h
> > @@ -80,7 +80,7 @@ struct ad_sigma_delta {
> >        * DMA (thus cache coherency maintenance) requires the
> >        * transfer buffers to live in their own cache lines.
> >        */
> > -     uint8_t                         data[4] ____cacheline_aligned;
> > +     uint8_t                         data[8] ____cacheline_aligned;
> >   };
> >
> >   static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
>
>
