Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC79445034
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKDI1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhKDI1X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:23 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456E6C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:46 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w15so5406412ill.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIJ9AAJ47RyvBvD7ZKBLJRkF3X/651jXOevVXJKGzAA=;
        b=Nx7aNJNZxXXTZztADuXLHwjPMtQD8AgZxFvTt3JutgdMX9v32bmAu1wVYF3O9MmIjG
         0t66kgWFA34WngNPpT9wwuyjR/zny9xsosSwbqk20/BMvvGqJex0ge17raZqt993tKmD
         /Ok9Egk6bArU+ethTnTujsk4kiE8gYeSEt+YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIJ9AAJ47RyvBvD7ZKBLJRkF3X/651jXOevVXJKGzAA=;
        b=H7MYCgQhCJBITm6YdZPQwKqgCfO+kRg5ACEKiwb8avCpvt27pJcCNq0utmtMkFT19f
         JPz/CeJKBCiOpNqGR/zN/RLddhcq39ll/0YkAxmFMb4fM6CI6H9zwj+Vs+z0TBq+g2Ky
         n4OFYfJwX6tGthrvBQPXmF0RXPCTq37tRkeu+dtLsczDTfrP3gAd2zOgM6ivmKM5CoLc
         HzYiJi06l9qKHEAcAEH6alBRJekzWvsjkkmDlK4J9fHrJgnKaUaRgB3KX30EDhP1siej
         qMs6Ndc5kzySyVdSRwvqHQbjxFaGfcgJZoXOaOdRTUd20A2D4Wxg+vHa0hrMUgxvdYLj
         P1TA==
X-Gm-Message-State: AOAM5318qzVafG/iUYwwroEKOYqvFE0KXRmtGoUJWhsTeTRZ9arocDyC
        RBwy8/P3m5jyK19VNbvbqzRdCNePw4tQqTNBducrhA==
X-Google-Smtp-Source: ABdhPJw1KHMfyJfpP72PDFe3MpK1bMIOq4K/lNVAT3TyEP/V0CkaJKyfBqjcWunBG/SJEw2Z3C4K+YzYDIbhfQW507w=
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr32271292ils.289.1636014285594;
 Thu, 04 Nov 2021 01:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211101071822.522178-1-gwendal@chromium.org> <20211101071822.522178-2-gwendal@chromium.org>
 <20211103184225.1706aa59@jic23-huawei>
In-Reply-To: <20211103184225.1706aa59@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 4 Nov 2021 01:24:32 -0700
Message-ID: <CAPUE2uuXzuCMgR+VjPG2W0OsU2HR91zZRRHVcE5SOoO25XLbLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: Use scan_type shift and realbits when processing
 raw data
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 3, 2021 at 11:37 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon,  1 Nov 2021 00:18:19 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > When user space application read iio buffer though libiio, data is
> > converted (see iio_channel_convert()) using the _type sysfs parameter.
> > In particular, scan_type.shift and scan_type.realbits are used to shift
> > and tell on how many bits signed elements are encoded on.
> >
> > When reading elements directly using the raw sysfs attributes, the same
> > rules for shifting and signing should apply.
> >
> > Use channel definition as root of trust and replace constant with
> > them for the simple cases.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Hmm. I'd have been tempted to do this as a long series, at least
> partly so it would let me pick up the ones I'm happy with + also
> we may create some history that needs backporting at some stage
> and that's a mess if we have code touching lots of drivers in one patch.
I will split this patch, one per driver so that you can pick only the
safe changes only.
There are many more drivers that would benefit from using scan_type,
but they require more restructuring.

>
> Ludovic, Eugen,  This change raised a question about the current
> code in at91-sama5d2_adc.c
>
> > ---
> >  drivers/iio/accel/bma220_spi.c     | 3 ++-
> >  drivers/iio/accel/kxcjk-1013.c     | 3 ++-
> >  drivers/iio/accel/mma7455_core.c   | 3 ++-
> >  drivers/iio/accel/sca3000.c        | 5 +++--
> >  drivers/iio/accel/stk8312.c        | 2 +-
> >  drivers/iio/accel/stk8ba50.c       | 3 ++-
> >  drivers/iio/adc/ad7266.c           | 3 ++-
> >  drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
> >  drivers/iio/adc/ti-adc12138.c      | 3 ++-
> >  drivers/iio/magnetometer/mag3110.c | 6 ++++--
> >  10 files changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> > index bc4c626e454d3..812d6749b24a7 100644
> > --- a/drivers/iio/accel/bma220_spi.c
> > +++ b/drivers/iio/accel/bma220_spi.c
> > @@ -125,7 +125,8 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
> >               ret = bma220_read_reg(data->spi_device, chan->address);
> >               if (ret < 0)
> >                       return -EINVAL;
> > -             *val = sign_extend32(ret >> BMA220_DATA_SHIFT, 5);
> > +             *val = sign_extend32(ret >> chan->scan_type.shift,
> > +                                  chan->scan_type.realbits - 1);
>
> The BMA220_DATA_SHIFT define is now only used as the value for .shift, so
> could you move the value inline to there and get rid of the define.
>
> That will be match what is done for all the other parts of scan_type.
Done.
>
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_SCALE:
> >               ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
>
>
> > diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> > index c6b75308148aa..938eb6bda73b3 100644
> > --- a/drivers/iio/accel/sca3000.c
> > +++ b/drivers/iio/accel/sca3000.c
> > @@ -730,8 +730,9 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
> >                               mutex_unlock(&st->lock);
> >                               return ret;
> >                       }
> > -                     *val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> > -                     *val = sign_extend32(*val, 12);
> > +                     *val = (be16_to_cpup((__be16 *)st->rx) >>
> > +                                     chan->scan_type.shift) & 0x1FFF;
>
> While here, GENMASK(12, 0) for the mask might be a nice to have..
Actually, it may not be needed at all: we push a 16bit field 3 bits to
the left, so 13 bits remain anyway.
>
> > +                     *val = sign_extend32(*val, chan->scan_type.realbits - 1);
> >               } else {
> >                       /* get the temperature when available */
> >                       ret = sca3000_read_data_short(st,
> The code following this is exciting as well... and would benefit from
> being rewritten as be16_to_cpup() with a shift and mask but that's a job for
> a different patch, or you could add the scan_type to the temperature channel and
> add it to this series using that... It's unsigned unlike the above, so
> it probably doesn't make sense to have a single path.
Done
>
>
>
>
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index 4c922ef634f8e..92a57cf10fba4 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -1586,7 +1586,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
> >               *val = st->conversion_value;
> >               ret = at91_adc_adjust_val_osr(st, val);
> >               if (chan->scan_type.sign == 's')
> > -                     *val = sign_extend32(*val, 11);
> > +                     *val = sign_extend32(*val,
> > +                                          chan->scan_type.realbits - 1);
> >               st->conversion_done = false;
> Hmm. This is exciting.  I'm not sure if the current code is correct.
> There is a comment that says it's a voltage channel if we are in this path
> a few lines earlier, yet the only signed voltage channel is from the
> macro AT91_SAMA5D2_CHAN_DIFF() which sets realbits = 14, not 12.
From https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf,
the ADC is natively 12 bits, but can be configured to oversample to
reach 14 bits resolution.
|realbit| may actually be a function of
IIO_CHAN_INFO_OVERSAMPLING_RATIO [aka "oversampling_ratio"] value.
>
>
> >       }
> >
>
> The other changes all looked good to me.
Thanks,
Gwendal.
>
> Jonathan
>
