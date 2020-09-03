Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8E25C440
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgICPFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgICN6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 09:58:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D6C061A1C;
        Thu,  3 Sep 2020 06:47:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so1900791qtj.7;
        Thu, 03 Sep 2020 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1zUgRbLsFEeGpq6qPl8QkF9aFlbywUVunqjqh+DadA=;
        b=NS2xjIIrgMfG6fHEkZ2tKgZsiB5c5jufyPfDsrWkkwsQN3aGPVImUNFhAU5pGZLCVW
         QzqhTd5yZ4gU172X0vyk+/QuRFMGBiRgtOiKi5CY015MLf69W+BClpzrzmeAUF5WVSB1
         PDCjSM9xIe1N0/IcaukeQuoG3ka1as/5AFZpDwj+Q9Ut492IVbHApZOeotauloT5kpjB
         GZyPBAtm19+QrckGNRl2zp/5ubJ1GShk8D6BL+zdizaZ+7F12WAcnSf/ATrUMhvn6lzu
         wvSHNpwhoUk1yAZHZ1wIo3Wswjp71n2q3t3FedngCX5szlU4oQEsQAszBcaUzkrcyY+M
         j7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1zUgRbLsFEeGpq6qPl8QkF9aFlbywUVunqjqh+DadA=;
        b=MsPVV0rGp96ja4orVwyE4mvdVbiLBDpqH6xAF/4AeYHV7Ja+cKSV/FTyFCROj6P3uy
         LHfeLLf6QURteSWphRpMb0X51MSKjjzl2Kcu+Dq2mIy34iprxIdajlX5Mwn9Oj6+sim4
         5kwMn9Rb64+ep8lRH1zkgm6P57VTHbhr48h/sfp0SJ0wgnX+EXtziZztjGkjI83pb7uo
         xFASIQjCiO1u7Kni1paRm6yw/LIR7AjsnBQm2FOdRe2vik4Q26/DyENJYa9zD0UHydos
         hdTyKb0wjxiAWqfBFEdbtyRw2FAk2UAY4tZSNiaxwfB6TJu6xANcn5VMGtCFfwkLntUZ
         +4ng==
X-Gm-Message-State: AOAM533+VyRVBppJa8UvvgtRXNMNcanE3QAGRSuDzGHhYrZYcUmhgTis
        wwtUthJ52gy/2cnrm1IDX/Ee8PhXElA4dZjHxsI=
X-Google-Smtp-Source: ABdhPJwoqGp8Nybiy91lZwd8lFz0++lRfOZmaGZN+trRIggnRVcc6FYSxM1ILF1U+GxJLSEoRDvmszFmunBsMrdB7uE=
X-Received: by 2002:aed:26c4:: with SMTP id q62mr3567362qtd.64.1599140820713;
 Thu, 03 Sep 2020 06:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
 <20200903130950.6274-2-nish.malpani25@gmail.com> <CAHp75Vc4hgvgoHrPaxDikqmAoqjpfOwPFTM-AvNvR3Ep=dQEfg@mail.gmail.com>
In-Reply-To: <CAHp75Vc4hgvgoHrPaxDikqmAoqjpfOwPFTM-AvNvR3Ep=dQEfg@mail.gmail.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Date:   Thu, 3 Sep 2020 19:16:48 +0530
Message-ID: <CAEtfd9YioLi=Nr0tMjombhdhyLy_65XUok_viH9_9CPKTz5+5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: gyro: adxrs290: Add triggered buffer support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Thanks for the review, Andy.

...

On Thu, Sep 3, 2020 at 6:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 4:10 PM Nishant Malpani <nish.malpani25@gmail.com> wrote:
> >
> > Provide a way for continuous data capture by setting up buffer support. The
> > data ready signal exposed at the SYNC pin of the ADXRS290 is exploited as
> > a hardware interrupt which triggers to fill the buffer.
> >
> > Triggered buffer setup was tested with both hardware trigger (DATA_RDY) and
> > software triggers (sysfs-trig & hrtimer).
>
> ...
>
> > +static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
> > +{
> > +       struct adxrs290_state *st = iio_priv(indio_dev);
> > +       int val, ret;
> > +
> > +       if (st->mode == mode) {
>
> > +               ret = 0;
> > +               goto done;
>
> Unlocking the not locked mutex is not good. Have you followed the
> Submitting Patches Checklist? It in particular suggests few debug
> options, like LOCKDEP, to be enabled.
>

Yikes, silly me. Thanks for the suggestion. Will fix this in v3.

> > +       }
> > +
> > +       mutex_lock(&st->lock);
> > +
> > +       ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
> > +       if (ret < 0)
> > +               goto done;
> > +
> > +       val = ret;
> > +
> > +       switch (mode) {
> > +       case ADXRS290_MODE_STANDBY:
> > +               val &= ~ADXRS290_MEASUREMENT;
> > +               break;
> > +       case ADXRS290_MODE_MEASUREMENT:
> > +               val |= ADXRS290_MEASUREMENT;
> > +               break;
> > +       default:
> > +               ret = -EINVAL;
> > +               goto done;
> > +       }
> > +
> > +       ret = adxrs290_spi_write_reg(st->spi,
> > +                                    ADXRS290_REG_POWER_CTL,
> > +                                    val);
> > +       if (ret < 0) {
> > +               dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
> > +               goto done;
> > +       }
> > +
> > +       /* update cached mode */
> > +       st->mode = mode;
> > +
>
> > +done:
>
> Much better to call it out_unlock. It will help eliminate the mistakes
> like above.
>

Yes, makes sense.

> > +       mutex_unlock(&st->lock);
> > +       return ret;
> > +}
>
> ...
>
>
> What about
>
>   ret = -EINVAL;
>
> >         switch (mask) {
> >         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >                 lpf_idx = adxrs290_find_match(adxrs290_lpf_3db_freq_hz_table,
> >                                               ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table),
> >                                               val, val2);
> > -               if (lpf_idx < 0)
> > -                       return -EINVAL;
>
> > +               if (lpf_idx < 0) {
>
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
>
> Simple
>   break;
>
> and so on?
>

Umm, sure would save us a few lines but it seems to me like we are
trading off readability here. If no one agrees, will change it the way
you pointed out.

> > +
> >                 /* caching the updated state of the low-pass filter */
> >                 st->lpf_3db_freq_idx = lpf_idx;
> >                 /* retrieving the current state of the high-pass filter */
> >                 hpf_idx = st->hpf_3db_freq_idx;
> > -               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +               ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +               break;
> > +
> >         case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> >                 hpf_idx = adxrs290_find_match(adxrs290_hpf_3db_freq_hz_table,
> >                                               ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table),
> >                                               val, val2);
> > -               if (hpf_idx < 0)
> > -                       return -EINVAL;
> > +               if (hpf_idx < 0) {
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +
> >                 /* caching the updated state of the high-pass filter */
> >                 st->hpf_3db_freq_idx = hpf_idx;
> >                 /* retrieving the current state of the low-pass filter */
> >                 lpf_idx = st->lpf_3db_freq_idx;
> > -               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +               ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +               break;
> > +
> > +       default:
> > +               ret = -EINVAL;
> > +               break;
> >         }
> >
> > -       return -EINVAL;
> > +       iio_device_release_direct_mode(indio_dev);
> > +       return ret;
> >  }
>
> ...
>
> > +static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
> > +{
>
> > +       /* exercise a bulk data capture starting from reg DATAX0... */
> > +       ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
> > +                                 sizeof(st->buffer.channels));
> > +       if (ret < 0)
> > +               goto done;
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> > +                                          pf->timestamp);
> > +
> > +done:
>
> out_unlock_notify:
>

Okay.

> > +       mutex_unlock(&st->lock);
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
> > +}
>
> ...
>
> > +static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
> > +{
> > +       struct adxrs290_state *st = iio_priv(indio_dev);
> > +       int ret;
>
> > +       if (!st->spi->irq) {
> > +               dev_info(&st->spi->dev, "no irq, using polling\n");
> > +               return 0;
> > +       }
>
> Wouldn't it be better to have this check outside of the function?

I think this function making an early exit makes more sense. The
CHIP_probe() looks less "noisy" that way.

> And taking this into account...
>
> > +}
>
> ...
>
> > +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > +                                             &iio_pollfunc_store_time,
> > +                                             &adxrs290_trigger_handler, NULL);
> > +       if (ret < 0)
> > +               return dev_err_probe(&spi->dev, ret,
> > +                                    "iio triggered buffer setup failed\n");
>
> ...do you really have to set up a trigger buffer w/o trigger being probed?
>

I suppose one can use software triggers like hrtimer and sysfs-trig...

With regards,
Nishant Malpani

> > +       ret = adxrs290_probe_trigger(indio_dev);
> > +       if (ret < 0)
> > +               return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
