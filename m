Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E936456E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 15:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhDSN4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbhDSN4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 09:56:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF444C061760;
        Mon, 19 Apr 2021 06:55:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g16so886514plq.3;
        Mon, 19 Apr 2021 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6yu+Pr8j6CmUPfAOl20hpdd+dcUNMLZ0wSKOzuThNo=;
        b=UomtuHtQQP5neGGQA6cOPDBRXqcCaG4BO2XKhit1HQ5EqvdZhaDx7B0p6U9eHsGT1F
         jZD9wnQvv3Kh3a/DBadXdiW8sBtNP6nnIt0yQIh4ThoxyIKogDrqwlqtHFxhIFq/dl9J
         uTnHbFHLb4MUg9hxvij9pCe3D6hUcD45uxBkv+nzwoi6xXrfeKaoafRZrDQfpEDeOtqo
         +9u7MMuHCOaZ6/ZHb5PjoK3lcnEXfnm0AYa9FoFym+fzuLm6+uGyZay4RhIR0AJlLCKe
         AWfqnzTaIrt+5+3CsDHNGdIVIULrfKbzJ1ufoOJPGjuB/6YSUi2Gwa+K+yKx7whSMu9U
         q1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6yu+Pr8j6CmUPfAOl20hpdd+dcUNMLZ0wSKOzuThNo=;
        b=nU7O+dqeMCVp9EuJv/dqLo57VlozoPMXxIARKprrFH10wgqilhRh0IhY11JFMiQww3
         /hVDvko7trh0RCtBhSXSiUIlo9dWDa5GdPArTFWuSN9OnA9KE+pRkmOlCYhKEiE0KRXZ
         ITQha3CUG1aMR+dedHhSTjyhcqF88XVap4vabMd9fwlMEZIhrXrUJ7OsHIjZL9qZot8t
         iIIqIVULNw5G+oVG4/xd3BcL4Qb/4k3CPcshTYvJ+gq8MyYjVZBhVA7yD+PrR2prWETA
         xcwhGiDtv+eMI9OQ1xl75Qzv9/ojqIkI2W0WpijiSaQ3mLrYa/ohKkIHl1QoU1sWC0uX
         9c3w==
X-Gm-Message-State: AOAM531chOqzKzQK7dNbjldBXkikgEs+Xb3ugEaPn9mqX6pJttv45PIR
        26df8kUrUP1YTMD1ElTc1rrQiyw66yaFnGT+QFJTuaA5h00=
X-Google-Smtp-Source: ABdhPJyUp8qQPpiII3NAf3R9g3lixO6K3PNK3Uc79tE85s6uZyIVtNHvDxKUi4X4kTcYavaAyfeLe76Gf5lKa7fksbs=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr6236736pjr.181.1618840532302;
 Mon, 19 Apr 2021 06:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210419132159.4450-1-tomas.melin@vaisala.com> <20210419132159.4450-3-tomas.melin@vaisala.com>
In-Reply-To: <20210419132159.4450-3-tomas.melin@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Apr 2021 16:55:16 +0300
Message-ID: <CAHp75VdApCk_Ydt2W_WWJ_wme4d1ocrrnvo+TjZcQ62RG6uOUA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 19, 2021 at 4:26 PM Tomas Melin <tomas.melin@vaisala.com> wrote:

Thanks for an update, it's getting better! My comments below.

> Add initial support for Murata SCA3300 3-axis industrial
> accelerometer with digital SPI interface. This device also
> provides a temperature measurement.

First of all, you forgot Cc reviewer(s).

> Datasheet: https://www.murata.com/en-global/products/sensor/accel/sca3300

>

No blank line in the tag block.

> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>


...

> +/*
> + * Copyright (c) 2021 Vaisala Oyj. All rights reserved.
> + */

One line.

...

> +#define SCA3300_MASK_STATUS    GENMASK(8, 0)
> +#define SCA3300_MASK_RS_STATUS GENMASK(1, 0)

This feels like an orphan. Shouldn't you move it closer to the group
of corresponding register / etc definition?

> +#define SCA3300_REG_MODE       0xd
> +#define SCA3300_REG_SELBANK    0x1f
> +#define SCA3300_REG_STATUS     0x6
> +#define SCA3300_REG_WHOAMI     0x10
> +
> +#define SCA3300_VALUE_DEVICE_ID        0x51
> +#define SCA3300_VALUE_RS_ERROR 0x3
> +#define SCA3300_VALUE_SW_RESET 0x20

As above it doesn't shed a light for the relationship between
registers and these fields (?). I.o.w the names w/o properly grouped
(and probably commented) are confusing.

...

> +/**
> + * struct sca3300_data - device data
> + * @spi: SPI device structure
> + * @lock: Data buffer lock

> + * @txbuf: Transmit buffer
> + * @rxbuf: Receive buffer

Are the buffers subject to DMA? Shouldn't they have the proper alignment?

> + * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
> + */
> +struct sca3300_data {
> +       struct spi_device *spi;
> +       struct mutex lock;
> +       u8 txbuf[4];
> +       u8 rxbuf[4];
> +       struct {
> +               s16 channels[4];
> +               s64 ts __aligned(sizeof(s64));
> +       } scan;
> +};

...

> +       struct spi_delay delay = {.value = 10, .unit = SPI_DELAY_UNIT_USECS};

Missed space.

...

> +       sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);

Seems you ignored my comment. What is this 0x0? What is the meaning of it?
Same for all the rest magic numbers in the code.

> +       /*
> +        * return status error is cleared after reading status register once,
> +        * expect EINVAL here

/*
 * Fix the style of all your multi-line comments.
 * You may follow this example.
 */

> +        */
> +       if (ret != -EINVAL) {
> +               dev_err(&sca_data->spi->dev,
> +                       "error reading device status: %d\n", ret);
> +               return ret;
> +       }
> +
> +       dev_err(&sca_data->spi->dev, "device status: 0x%lx\n",
> +               (val & SCA3300_MASK_STATUS));

Too many parentheses.

> +       return 0;
> +}

...

> +static irqreturn_t sca3300_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct sca3300_data *data = iio_priv(indio_dev);
> +       int bit, ret, val, i = 0;
> +
> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {
> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> +                                      &val);
> +               if (ret) {
> +                       dev_err(&data->spi->dev,
> +                               "failed to read register, error: %d\n", ret);

> +                       goto out;

Does it mean interrupt is handled in this case?
Perhaps a comment why it's okay to consider so?

> +               }
> +               data->scan.channels[i++] = val;
> +       }
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +                                          iio_get_time_ns(indio_dev));
> +out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

...

> +       /*
> +        * wait 1ms after SW-reset command
> +        * wait 15ms for settling of signal paths
> +        */
> +       usleep_range(16e3, 50e3);

+ blank line

> +       ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
> +       if (ret)
> +               return ret;

> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret) {
> +               dev_err(&spi->dev, "iio device register failed, error: %d\n",
> +                       ret);

> +               return ret;
> +       }
> +
> +       return ret;

Deduplicate it.

Simply leave the latter one.

> +}

...

> +

No need for this blank line.

> +       .probe  = sca3300_probe,
> +};

> +

Ditto.

> +module_spi_driver(sca3300_driver);

-- 
With Best Regards,
Andy Shevchenko
