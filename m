Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5B22896C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgGUTqw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGUTqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:46:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED36C061794;
        Tue, 21 Jul 2020 12:46:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so2063279pje.0;
        Tue, 21 Jul 2020 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emtnkyfOV2ggh6E9ksv03j+Pmvd7gDdXsJiz8QGxybQ=;
        b=XKWF4kx/DVWVpxqZriz8KsdyBtxx91kmjf/0wDrR39GLSuESkMcXD93n6ddXS9Ry0y
         pYsq4HKU6Bqs/AIfOVJl3erdchvuBtdboCxV4NkgLwXClu+01KLE+EqUA4w1XT4R7UXj
         hXQG5JIjYVo8Z5Qlwy5AAthQ4cqZzV7a12c9vywO9QtQ5Ll3Ba+HJxxxsk/RQ18d6GRp
         4Ryh9t9ur7qmsKwajeSb4UDYBPpXfYJUkWvSrw/KgGcfW5Jqo/ut5+08GQ0MeO/1WvIC
         7uqZEL6/Cl6nWzuwR6ARnxMaZ51BLbmYJ6rfwi5+ca8LFrjnM8Cts79gumpua/ieUy7b
         jjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emtnkyfOV2ggh6E9ksv03j+Pmvd7gDdXsJiz8QGxybQ=;
        b=jUbVSitNUg72AGeuPzZOc5NZD+VCRVvh7EDUWj7QuMYQW2tcX7sUzayKBugwcKAZXW
         nVPWYR0eiykRuymguD8XlOYerRGH/2ik6IO+5L5cvr0yGSQnh1Z/ymSkJBeEpLuwtW5w
         Ta9w/LJaXcaTFztZXxGlEhvgiOXYaQRlS9HsFdm+1G8tWsEdvvUTA9t3WcD0fPGjajT2
         prjBdzqM9ZlCM/8hHP22i/UwdXEHwYKBfjXu4IH8mvObfIpYEieHHGO7X9e1OuhEvkmJ
         1OMHHTOV4l0BRZI7RPNHY7UYX3vE9Mi2FUCaWXObg051Gdek7vY8pZDdIn4lNxI39uir
         4bvA==
X-Gm-Message-State: AOAM533fcA8FPZnlQwwcKX9VEtmA1JbOm9nkD3veU+sOKClfDWQS9lgN
        hlaFvRZXdTamvT+Ul/gXXfYrBfb47Fws7I9YWV0=
X-Google-Smtp-Source: ABdhPJxo31nBPjhkEE/1gV96iiqviUyTXpLJxQpU+mCt242thfkFWOSS6yGkbTtx0DUKOPYzPRIwlQVbysujE59HzTk=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr6589336pjp.228.1595360811110;
 Tue, 21 Jul 2020 12:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200721181926.27046-1-nish.malpani25@gmail.com>
In-Reply-To: <20200721181926.27046-1-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 22:46:34 +0300
Message-ID: <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: gyro: Add driver support for ADXRS290
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 9:20 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
>
> ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
> angular rate sensor (gyroscope) designed for use in stabilization
> applications. It also features an internal temperature sensor and
> programmable high-pass and low-pass filters.
>
> Add support for ADXRS290 in direct-access mode for now.

> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf

Drop that 'Link:' part and followed blank line, so get something like

Datasheet: https://...
Signed-off-by: ...

> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

...

> +config ADXRS290
> +       tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
> +       depends on SPI
> +       help
> +         Say yes here to build support for Analog Devices ADXRS290 programmable
> +         digital output gyroscope.
> +
> +         This driver can also be built as a module. If so, the module will be
> +         called adxrs290.


> +enum adxrs290_mode {
> +       STANDBY,
> +       MEASUREMENT,
> +};

> +struct adxrs290_state {
> +       struct spi_device       *spi;
> +       /* Serialize reads and their subsequent processing */
> +       struct mutex            lock;
> +       enum adxrs290_mode      mode;
> +       unsigned int            lpf_3db_freq_idx;
> +       unsigned int            hpf_3db_freq_idx;
> +};

...

> +/*
> + * Available cut-off frequencies of the low pass filter in Hz.
> + * The integer part and fractional part are represented separately.
> + */

> +static const int adxrs290_lpf_3db_freq_tbl[][2] = {

What about adxrs290_lpf_3db_freq_hz_table ?

> +};
> +
> +/*
> + * Available cut-off frequencies of the high pass filter in Hz.
> + * The integer part and fractional part are represented separately.
> + */
> +static const int adxrs290_hpf_3db_freq_tbl[][2] = {

Ditto.

> +};

...

> +static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd,
> +                                 unsigned int *val)
> +{
> +       struct adxrs290_state *st = iio_priv(indio_dev);

> +       int ret = 0;

Purpose of this?

> +       u16 temp;
> +
> +       mutex_lock(&st->lock);
> +       temp = spi_w8r16(st->spi, cmd);

> +       if (temp < 0) {

How can this ever happen?

> +               ret = temp;
> +               goto err_unlock;
> +       }
> +
> +       *val = temp;
> +
> +err_unlock:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}

Ditto for the rest of the similar cases.

...

> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_ANGL_VEL:
> +                       *val = 0;


> +                       *val2 = 87266;

Magic!

> +                       return IIO_VAL_INT_PLUS_NANO;
> +               case IIO_TEMP:

> +                       *val = 100;

Magic!

> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }

...

> +               *vals = (const int *)adxrs290_lpf_3db_freq_tbl;

Why casting?

...

> +               *vals = (const int *)adxrs290_hpf_3db_freq_tbl;

Ditto.

...


> +       struct iio_dev *indio_dev;
> +       struct adxrs290_state *st;

> +       int ret;
> +       u8 val, val2;

Swap them to have in reversed spruce tree order.

...

> +       indio_dev->dev.parent = &spi->dev;

Do you need this?

> +       /* max transition time to measurement mode */
> +       msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);

I'm not sure what the point of interruptible variant here?

...

> +static const struct of_device_id adxrs290_of_match[] = {
> +       { .compatible = "adi,adxrs290" },

> +       { },

No comma here!

> +};

-- 
With Best Regards,
Andy Shevchenko
