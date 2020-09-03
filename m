Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E6625C2B4
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgICOc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbgICOcH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 10:32:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A18C061244;
        Thu,  3 Sep 2020 06:20:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u128so2318381pfb.6;
        Thu, 03 Sep 2020 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAstEE7xW6ixGXMVKxjeyJUh3HVzf2XVOU1fodROD9k=;
        b=sp5V/JNxeuZwW41J3Nt/ItaHN+ymHSD1609wWjH35AIvOnMn3Q8XyuVjRXF/qWZHVc
         Bf7sNg7i0ZlTYb2w8bzz8kq6c17Y8EaLnxvitxVeibBQpYuBybZyI1u1NtbYFCMuSr6A
         dWYBMdpRR9jkLQGMsKFOC34Q1F/Ga8JtdKqAHOcwhHWZbnLO1PWhI/zzKfOEH/39UKCW
         YEuVE+M+fl1hk9KbNh5pIuqrx385OMMdoETaHbg460CYMaf0ruom85rn+CF1t+jKtV3I
         NLYh0uTVIXDPBXoNSDTBPE8ZtwewdFaBNY8TxbTDmDlUCMhlvkiHA5z9xz4IQTvuQm4A
         9Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAstEE7xW6ixGXMVKxjeyJUh3HVzf2XVOU1fodROD9k=;
        b=S+XHPbtgOb78Y7f3syZrq5eHaqAyMXiBBY138nwRo0q/k2LHcImF3hEHAlkFnrySHi
         M38qyKIRoMpUf/IRo3FSRxYO9VJh05pPvKFwSYs2EXM4JtR3b97Chr2grFKh25C3aDyC
         Y+RhRzXQZUjXCQ+p7oWzrj+qiH0KiM8EJrNl/FDfuS0T0pTRsD9kHMrRPSz1n9VxxIp9
         QDV/tP6Z08UKLbmi+hpcLsc1bKcpwtgNy6JUqzHuN8I8KQTHC2qrcDW4z0Joj5Du4LA6
         v9AqVfFOlthe11UBFQxaLbygYH8GTOOoQsnFJ419UBP9UkWD0UtMepW2uwlpJnSW5R7c
         6MFA==
X-Gm-Message-State: AOAM5339uWcwevlh5sdCggm5p9b+fHBaVr/vgTQ9XPpWZEe9pVZmBClN
        cekRyAu1RElzsHHx2qGf1t6LOiYKReAbGkJMORs=
X-Google-Smtp-Source: ABdhPJxvCqZfPwguDJuOSLvVm0bhXx1T/QU/L/L588R/Ui4F94yMIF1O6k3OR5G7YZqzuWcFAitepuvit4LisR6/978=
X-Received: by 2002:aa7:942a:: with SMTP id y10mr2786604pfo.68.1599139221898;
 Thu, 03 Sep 2020 06:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200903130950.6274-1-nish.malpani25@gmail.com> <20200903130950.6274-2-nish.malpani25@gmail.com>
In-Reply-To: <20200903130950.6274-2-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 16:20:04 +0300
Message-ID: <CAHp75Vc4hgvgoHrPaxDikqmAoqjpfOwPFTM-AvNvR3Ep=dQEfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: gyro: adxrs290: Add triggered buffer support
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 4:10 PM Nishant Malpani <nish.malpani25@gmail.com> wrote:
>
> Provide a way for continuous data capture by setting up buffer support. The
> data ready signal exposed at the SYNC pin of the ADXRS290 is exploited as
> a hardware interrupt which triggers to fill the buffer.
>
> Triggered buffer setup was tested with both hardware trigger (DATA_RDY) and
> software triggers (sysfs-trig & hrtimer).

...

> +static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
> +{
> +       struct adxrs290_state *st = iio_priv(indio_dev);
> +       int val, ret;
> +
> +       if (st->mode == mode) {

> +               ret = 0;
> +               goto done;

Unlocking the not locked mutex is not good. Have you followed the
Submitting Patches Checklist? It in particular suggests few debug
options, like LOCKDEP, to be enabled.

> +       }
> +
> +       mutex_lock(&st->lock);
> +
> +       ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
> +       if (ret < 0)
> +               goto done;
> +
> +       val = ret;
> +
> +       switch (mode) {
> +       case ADXRS290_MODE_STANDBY:
> +               val &= ~ADXRS290_MEASUREMENT;
> +               break;
> +       case ADXRS290_MODE_MEASUREMENT:
> +               val |= ADXRS290_MEASUREMENT;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               goto done;
> +       }
> +
> +       ret = adxrs290_spi_write_reg(st->spi,
> +                                    ADXRS290_REG_POWER_CTL,
> +                                    val);
> +       if (ret < 0) {
> +               dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
> +               goto done;
> +       }
> +
> +       /* update cached mode */
> +       st->mode = mode;
> +

> +done:

Much better to call it out_unlock. It will help eliminate the mistakes
like above.

> +       mutex_unlock(&st->lock);
> +       return ret;
> +}

...


What about

  ret = -EINVAL;

>         switch (mask) {
>         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>                 lpf_idx = adxrs290_find_match(adxrs290_lpf_3db_freq_hz_table,
>                                               ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table),
>                                               val, val2);
> -               if (lpf_idx < 0)
> -                       return -EINVAL;

> +               if (lpf_idx < 0) {

> +                       ret = -EINVAL;
> +                       break;
> +               }

Simple
  break;

and so on?

> +
>                 /* caching the updated state of the low-pass filter */
>                 st->lpf_3db_freq_idx = lpf_idx;
>                 /* retrieving the current state of the high-pass filter */
>                 hpf_idx = st->hpf_3db_freq_idx;
> -               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> +               ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> +               break;
> +
>         case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>                 hpf_idx = adxrs290_find_match(adxrs290_hpf_3db_freq_hz_table,
>                                               ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table),
>                                               val, val2);
> -               if (hpf_idx < 0)
> -                       return -EINVAL;
> +               if (hpf_idx < 0) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
>                 /* caching the updated state of the high-pass filter */
>                 st->hpf_3db_freq_idx = hpf_idx;
>                 /* retrieving the current state of the low-pass filter */
>                 lpf_idx = st->lpf_3db_freq_idx;
> -               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> +               ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
>         }
>
> -       return -EINVAL;
> +       iio_device_release_direct_mode(indio_dev);
> +       return ret;
>  }

...

> +static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
> +{

> +       /* exercise a bulk data capture starting from reg DATAX0... */
> +       ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
> +                                 sizeof(st->buffer.channels));
> +       if (ret < 0)
> +               goto done;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> +                                          pf->timestamp);
> +
> +done:

out_unlock_notify:

> +       mutex_unlock(&st->lock);
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

...

> +static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
> +{
> +       struct adxrs290_state *st = iio_priv(indio_dev);
> +       int ret;

> +       if (!st->spi->irq) {
> +               dev_info(&st->spi->dev, "no irq, using polling\n");
> +               return 0;
> +       }

Wouldn't it be better to have this check outside of the function?
And taking this into account...

> +}

...

> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &adxrs290_trigger_handler, NULL);
> +       if (ret < 0)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "iio triggered buffer setup failed\n");

...do you really have to set up a trigger buffer w/o trigger being probed?

> +       ret = adxrs290_probe_trigger(indio_dev);
> +       if (ret < 0)
> +               return ret;

-- 
With Best Regards,
Andy Shevchenko
