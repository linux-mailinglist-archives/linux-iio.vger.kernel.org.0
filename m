Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2D25346D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHZQK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHZQKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 12:10:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C5C061574;
        Wed, 26 Aug 2020 09:10:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so1099750pjb.4;
        Wed, 26 Aug 2020 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzkKMaEYRSqK3qJ/7RKMF0nr0rmaw4l1yJHr2LcyJrQ=;
        b=GUM4b+AKt4DXs9Czm1/g7FEUizlZoYNy2a13HKf6jY4MB/UtxnZis4YdlNbgnv0gng
         VLgyepIPIP+r3HqOxtcXfRJOT8V7yK3/geJJFC4lH9ZkeKrvKSRo5tgNGS1jFwqbuW4w
         mIYO6h8SNnsvEq+7tnBZVzNICRpRqO4mKjRfclvaEicY3IT/MBm3Z25ahf5To6Qy9Dmj
         ZXGlgdmZQb9uwS8VglWPRo+Do6XZl7+U0fqkBKz93N3/oH+S5dRF8ZiefspOZswDrGuS
         Mc0OEGPL7xKO0zfmXYaD3yZoZ6uzDWFsuFt4Wq1bCmA6r0pmVK6yEsL7oNTZ5wWtIr+R
         NFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzkKMaEYRSqK3qJ/7RKMF0nr0rmaw4l1yJHr2LcyJrQ=;
        b=VnYecQZjoyBVoCq5b3vJP0ay4g+m/hMjpLpZgnyJDGc0GVI6vfglsIUIKibhjBVPm+
         HiOxAsM9k7DA699NNnOEGyMo5wsRt8/9wJvHztIsVbHDARhl+d9ENaI5TEsn66xjrohl
         R7ATO2rHPoxgDmRGhfc78GKRihIbqsINY6yYLJw+OdtxdK/0sMnXC8AZK2ZL3T7TADKw
         SayIMgUZS28o9tuB+IOb1c1H1Xpu+IgcYxvRta77l6Q7Qj4XVjngHbzrT2FG4wIZ/JwI
         uG2atwhEQG1F+0XbyFcrakHUd4rbPLYOou+8lxdpNUrNcpCtEgoftRYBArF+4GogjG9Q
         VIkQ==
X-Gm-Message-State: AOAM532S9DQOmPWmlewJTC2Ye/JS/LpbxmXURcuJJbySLHRIri72jaUD
        NUYsUjM/0Gh+2JcuO97eKbAdh8BBAHV0bl+SuhA=
X-Google-Smtp-Source: ABdhPJxjUO7auQGz1uE0L/pbKqExRjpwrx9ZKnA6VZu1uXt4iuNvtzNdZeMz+Ss+KiwIbV4Sfv0XzdnBKKO4+yfbwcQ=
X-Received: by 2002:a17:902:407:: with SMTP id 7mr12502214ple.167.1598458219927;
 Wed, 26 Aug 2020 09:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200825124711.11455-1-nish.malpani25@gmail.com> <20200825124711.11455-2-nish.malpani25@gmail.com>
In-Reply-To: <20200825124711.11455-2-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 19:10:03 +0300
Message-ID: <CAHp75VfHFo41S=Bhs2MB6Te6VAn+yCteys6XcYgciNZu9VppJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: gyro: adxrs290: Add triggered buffer support
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

On Tue, Aug 25, 2020 at 4:11 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
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
> +       mutex_lock(&st->lock);
> +
> +       if (st->mode == mode) {

> +               ret = 0;

Can be done outside of mutex.

> +               goto done;
> +       }
> +

> +       val = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
> +       if (val < 0) {
> +               ret = val;
> +               goto done;
> +       }

Consider other way around
 ret = ...
 ...
 val = ret;

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
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}

...

> +                               goto err_release;
>
> -                       return IIO_VAL_INT;
> +                       ret = IIO_VAL_INT;
> +                       break;
>                 default:
> -                       return -EINVAL;
> +                       ret = -EINVAL;
> +                       break;
>                 }

> +err_release:

I didn't get the purpose of this. Wasn't the break statement enough?

> +               iio_device_release_direct_mode(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_SCALE:
>                 switch (chan->type) {
>                 case IIO_ANGL_VEL:

...

> +                       goto err_release;

Ditto.

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
> +err_release:
> +       iio_device_release_direct_mode(indio_dev);
> +       return ret;
>  }

...

> +       val = (state ? ADXRS290_SYNC(ADXRS290_DATA_RDY_OUT) : 0);

Purpose of outer parentheses?

...

> +static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
> +{
> +       struct adxrs290_state *st = iio_priv(indio_dev);
> +       int ret;
> +
> +       if (!st->spi->irq) {
> +               dev_info(&st->spi->dev, "no irq, using polling\n");
> +               return 0;
> +       }
> +
> +       st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
> +                                                "%s-dev%d",
> +                                                indio_dev->name,
> +                                                indio_dev->id);
> +       if (!st->dready_trig)
> +               return -ENOMEM;
> +
> +       st->dready_trig->dev.parent = &st->spi->dev;
> +       st->dready_trig->ops = &adxrs290_trigger_ops;
> +       iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +
> +       ret = devm_request_irq(&st->spi->dev, st->spi->irq,
> +                              &iio_trigger_generic_data_rdy_poll,
> +                              IRQF_ONESHOT,
> +                              "adxrs290_irq", st->dready_trig);
> +       if (ret < 0) {

> +               dev_err(&st->spi->dev, "request irq %d failed\n", st->spi->irq);
> +               return ret;

return dev_err_probe(...);

> +       }
> +
> +       ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
> +       if (ret) {

> +               dev_err(&st->spi->dev, "iio trigger register failed\n");
> +               return ret;

return dev_err_probe(...);

> +       }
> +
> +       indio_dev->trig = iio_trigger_get(st->dready_trig);
> +
> +       return 0;
> +}

...

> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &adxrs290_trigger_handler, NULL);
> +       if (ret < 0) {

> +               dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +               return ret;

return dev_err_probe(...);

> +       }

-- 
With Best Regards,
Andy Shevchenko
