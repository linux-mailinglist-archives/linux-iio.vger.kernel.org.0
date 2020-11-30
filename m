Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96B2C8368
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 12:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgK3LnI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 06:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgK3LnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 06:43:08 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64917C0613CF;
        Mon, 30 Nov 2020 03:42:28 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id l1so6338575pld.5;
        Mon, 30 Nov 2020 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ML13+sHIhJ3gxB47mjMKu2d8tomkG6mROIHWgw92D+U=;
        b=pnL+rTMadSAZP/W9ozLc31bAybUqiKLvvhgzf1YpSykvX9IoChh7fON3VOlGlKirlU
         cCAUGR4Xn/D8LR3CvQTX6u1fxvk4gMOiinaKlOd+G3gukiMbLkkMAyUnSgiKXxGsvxiU
         0Ov0QJD79EPCZqeDr2XveOkgbIb7QazEQp7vAu9b26t/FQT6PRcAaugZfYhIqVOfl3lM
         wHSaqLQ5VTspCD4NbEAlFUouTdGUVB+A/yrIQSs0G8nQCdd0WJga03RudlXJFfq058Ld
         cLuxednoCHaFzjsH1bAoWXLgKMxpr26tM7/vErwBnCnQ5Jq4MzmnQvtoPqjk9GSgfwjP
         V73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ML13+sHIhJ3gxB47mjMKu2d8tomkG6mROIHWgw92D+U=;
        b=TW/qUnfWY4gujqKjxISHT58oMWWMthas4T0ziChom8Cj0pFYhOlXbf0j+hgnsx8QkN
         fhv9FGUTS6Z9XsoEBlfvZFXDYkWLzvvgZG5g1kAsg3kdqRcVih1YbtqXyzP9TxyYCqZ1
         IzftTnLKtBk0AKSezfhvMIEdEAfWane9raxvFcAcLovS8GitkPpTutQMt8EqmaI2shBj
         JVrSSrK0n2pEKrI9JYWuaqN3r88j3UBfhir5MZ1lw7u3srUWpwoJrb1XL0ee6QFuOxfT
         46NgiNVUoPHvee+wGp3+hDfFbNSzstVaSLvUEILyeAb6KVTJiVTQLXasODQ7AhQ5K0T2
         wdpA==
X-Gm-Message-State: AOAM533sWrTDY5S1LZoKE2UR3sI+i0f6qzj+46meAE8shVgQeQOmpKQD
        B/3lpnmfWuxh6PkKgVVn1hEPb6rNfTxsBZV/aOBHNy/cltg=
X-Google-Smtp-Source: ABdhPJx8+1smLr8F/nkvnkpIHOhBnKFcNJOMTYhB8VwiHrU6q40rvNh17PR+Q65hEfGda4Pv4ygdpHRF6RnIM61S9wE=
X-Received: by 2002:a17:902:ac93:b029:d8:d2c5:e5b1 with SMTP id
 h19-20020a170902ac93b02900d8d2c5e5b1mr18413020plr.17.1606736547862; Mon, 30
 Nov 2020 03:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20201129215421.1177990-1-linus.walleij@linaro.org> <20201129215421.1177990-2-linus.walleij@linaro.org>
In-Reply-To: <20201129215421.1177990-2-linus.walleij@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Nov 2020 13:43:16 +0200
Message-ID: <CAHp75VcSaZCHjk0GGindq__52NMduCY+oA9gvohMs6ZCuqfe+w@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] iio: magnetometer: Add driver for Yamaha YAS530
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 11:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds an IIO magnetometer driver for the Yamaha
> YAS530 family of magnetometer/compass chips YAS530,
> YAS532 and YAS533.
>
> A quick survey of the source code released by different
> vendors reveal that we have these variants in the family
> with some deployments listed:
>
>  * YAS529 MS-3C (2005 Samsung Aries)
>  * YAS530 MS-3E (2011 Samsung Galaxy S Advance)
>  * YAS532 MS-3R (2011 Samsung Galaxy S4)
>  * YAS533 MS-3F (Vivo 1633, 1707, V3, Y21L)
>  * (YAS534 is a magnetic switch)
>  * YAS535 MS-6C
>  * YAS536 MS-3W
>  * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5)
>  * YAS539 MS-3S (2018 Samsung Galaxy A7 SM-A750FN)
>
> The YAS529 is so significantly different from the
> YAS53x variants that it will require its own driver.
> The YAS537 and YAS539 have slightly different register
> sets but have strong similarities so a common driver
> patching this one will probably be reasonable.
>
> The source code for Samsung Galaxy A7's YAS539 is not
> that significantly different from the YAS530 in the

that is significantly

> Galaxy S Advance, so I believe we will only need this
> one driver with quirks to handle all of them.
>
> The YAS539 is actively announced on Yamaha's devices
> site:
> https://device.yamaha.com/en/lsi/products/e_compass/
>
> This is a driver written from scratch using buffered
> IIO and runtime PM handling regulators and reset.

May I comment? :-) Okay my (mostly minor)  comments below.

...

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/bitops.h>
> +#include <linux/random.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned/be_byteshift.h>
> +#include <linux/bitfield.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/pm_runtime.h>

Perhaps sorted?

> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Ditto?

...

> +#define YAS5XX_OFFSET_X                        0x85 /* +/-31 */
> +#define YAS5XX_OFFSET_Y1               0x86 /* +/-31 */
> +#define YAS5XX_OFFSET_Y2               0x87 /* +/-31 */

What comments mean? Range of valid values? Perhaps [-31..31]
I explain why I'm commenting on this. My confusion becomes from my
first thought was that this is about register offsets. But then I have
read the name and assumed above. And still not sure that it is a right
assumption.

...

> +#define YAS530_DATA_CENTER             2048
> +#define YAS530_DATA_OVERFLOW           4095

Here...

> +#define YAS532_DATA_CENTER             4096
> +#define YAS532_DATA_OVERFLOW           8191

...and here sound like values are depend to the register bits, so, I
would perhaps right them in a such way (or make a comment)

...

> +/* Turn off device regulators etc after 5 seconds of inactivity */
> +#define YAS5XX_AUTOSUSPEND_DELAY       5000

_MS

...

> +
> +

One blank line is usually enough.

...

> +       val = get_unaligned_be16(&data[0]);

> +       val = get_unaligned_be16(&data[0]);

Briefly looking I don't see other calls, but here no need to use
get_unaligned_*(), rather be16_to_cpu{p}/cpu_to_be16{p}.

...

> +static int yas5xx_busy_wait(struct yas5xx *yas5xx)
> +{
> +       int maxloops = 1000;
> +       unsigned int val;
> +       int ret;
> +
> +       while (maxloops) {
> +               ret = regmap_read(yas5xx->map, YAS5XX_MEASURE_DATA, &val);
> +               if (ret)
> +                       return ret;
> +
> +               if (!(val & YAS5XX_MEASURE_DATA_BUSY))
> +                       return 0;
> +
> +               maxloops--;
> +       }
> +
> +       return -ETIMEDOUT;
> +}

Reimplementation of regmap_read_poll_timeout() ?

...

> +static const struct iio_chan_spec_ext_info yas5xx_ext_info[] = {
> +       IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, yas5xx_get_mount_matrix),

> +       { },

No need for comma.

> +};

...

> +#define YAS5XX_AXIS_CHANNEL(axis, index)                               \
> +       {                                                               \
> +               .type = IIO_MAGN,                                       \
> +               .modified = 1,                                          \
> +               .channel2 = IIO_MOD_##axis,                             \
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +                       BIT(IIO_CHAN_INFO_SCALE),                       \
> +               .ext_info = yas5xx_ext_info,                            \
> +               .address = index,                                       \
> +               .scan_index = index,                                    \
> +               .scan_type = {                                          \
> +                       .sign = 's',                                    \
> +                       .realbits = 32,                                 \
> +                       .storagebits = 32,                              \

> +                       .endianness = IIO_CPU                           \

...but here I would rather leave it.

> +               },                                                      \
> +       }

...

> +                       .endianness = IIO_CPU

Ditto.

...

> +static const unsigned long yas5xx_scan_masks[] = { 0xf, 0 };

GENMASK()? Or is it plain value?

...

> +static const struct regmap_config yas5xx_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = 0xff,
> +       .volatile_reg = yas5xx_volatile_reg,
> +};

You have mutex in the code and another lock by regmap core. Do you need both?

...

> +       /* Sanity check */
> +       for (i = 0; i < 13; i++) {
> +               if (data[i] != 0)
> +                       break;
> +       }

memchr_inv()

...

> +       if (i == 13 && !(data[13] & BIT(7)))
> +               dev_err(yas5xx->dev, "calibration is blank!\n");

And we continue... Shouldn't we bail out or decrease level to warning?

...

> +       yas5xx->version = data[13] & 0x01;

BIT(0) ?

...

> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*yas5xx));
> +       if (indio_dev == NULL)

!indio_dev ?

> +               return -ENOMEM;

...

> +       if (yas5xx->reset)

If it's optional we don't need this check, otherwise we don't need it
either. Or I missed something?

> +               gpiod_set_value_cansleep(yas5xx->reset, 1);

...

> +       if (yas5xx->reset)

Ditto.

> +               gpiod_set_value_cansleep(yas5xx->reset, 1);

...

> +       if (yas5xx->reset)
> +               gpiod_set_value_cansleep(yas5xx->reset, 0);

Ditto.

...

> +       if (yas5xx->reset)
> +               gpiod_set_value_cansleep(yas5xx->reset, 1);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
