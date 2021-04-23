Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEC36969D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbhDWQHa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWQH3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 12:07:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23157C061574;
        Fri, 23 Apr 2021 09:06:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so1422485pjx.5;
        Fri, 23 Apr 2021 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IogqCPyvEvuM6GWvpXpHl19+M+Wj9F934eJ8mKManQw=;
        b=k2KvuTXUaJRxSWSbxOHfmPWor1BH2QRGJTkOflXnvKePtPb2rFZVAnV+MN3p4+VBYe
         zqL//K4qzi9xpVeQ27cexC+jwQ/ch6vrLSOfCy+5068m/S7jQ/IIBy3F7XHM89stpaQC
         5yJgpQs4Mnr1aEsnzaPEtQ+9jQe/OwsvpEY6Ixpxwro+3+0ouzUJJ0iSK5E6348mTBUX
         VF0LYVKjKY2kxfKpNz0rpjIBGUlLpNDH0nUU4eyxUQVyHAex+/tzHtMY0JJyywMJZbmI
         q9ZMPZIuenE05lKaPeFwyWP+K0Z0oGZjIk1DkSAy1d8b4eZIAkCPxdStzMDoGFREKBA8
         6Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IogqCPyvEvuM6GWvpXpHl19+M+Wj9F934eJ8mKManQw=;
        b=g3HF3dGunErDdOgt/deLUe4+fZybL+7VlA0onvRXnrIly0hJhiYyLkIGWceVP6gN/V
         AFmZw3oTONGf02Fdw6bOadoz8SRAWAEaH1/kb7H37eHVzZxGiILaCGs8fF2d8ownsq+p
         i0UV0BdU/G0e+lTH2UPBK8yDCLND+cX4jG35p2rTAH3tlxDEYrph4ULQmrHh0bGt0XxI
         uZ5hAG5K1aAoqgpNEdFDvz3xpLIaAur0gBnfW+oQpJBrieMIXCuWo4Lt9hgde8XfrCRt
         437gPpoya+DBOSKkDhCqM3XatReKguPSnmFXaJOHUKABuBJZZNZzFfO7TTfcR/AAyl0K
         K9ag==
X-Gm-Message-State: AOAM533CzlOwDzKXuchMp9C51Mx6UFj9BY9Qhu8yM6C8CuPyXdgfZC+D
        w7wskyzU5CYaBvueNZ4EcsKjYD4TOY02UudxNJ0=
X-Google-Smtp-Source: ABdhPJyCF5pfkqJvfI/SycPE59PP6Rrzx1x/SiXt/11eiyE8YcxxM3KPBfePw+OrmXFGq3h+2xVTOOJevU9KJV3Hpic=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr6859715pjr.181.1619194006820;
 Fri, 23 Apr 2021 09:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210420132333.99886-1-tomas.melin@vaisala.com> <20210420132333.99886-3-tomas.melin@vaisala.com>
In-Reply-To: <20210420132333.99886-3-tomas.melin@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 23 Apr 2021 19:06:30 +0300
Message-ID: <CAHp75Ve2AEA8yPw5qN+R=K=ovaO8vX53hYU9=knjY_Z+EHDdww@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 20, 2021 at 4:24 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>
> Add initial support for Murata SCA3300 3-axis industrial
> accelerometer with digital SPI interface. This device also
> provides a temperature measurement.

Thanks for an update, my comments below.

They can be addressed as followups, but I think regmap API can be
considered right now.

...

> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
> +{
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = reg << 2;
> +       ret = sca3300_transfer(sca_data, val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret != -EINVAL)
> +               return ret;
> +
> +       return sca3300_error_handler(sca_data);
> +}
> +
> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
> +{
> +       int reg_val = 0;
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       /* BIT(7) for write operation */
> +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
> +       put_unaligned_be16(val, &sca_data->txbuf[1]);
> +       ret = sca3300_transfer(sca_data, &reg_val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret != -EINVAL)
> +               return ret;
> +
> +       return sca3300_error_handler(sca_data);
> +}

Okay, BIT(7) for write/read is pretty much standard stuff for such
sensors. If you transform your driver to use REGMAP_SPI, you will get
it thru regmap configuration. Also, you will get a locking there, in
case you don't need to have several I/O in a row atomically.

..

> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {

One line?

> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> +                                      &val);
> +               if (ret) {
> +                       dev_err_ratelimited(&data->spi->dev,
> +                               "failed to read register, error: %d\n", ret);
> +                       /* handled, but bailing out due to errors */
> +                       goto out;
> +               }
> +               data->scan.channels[i++] = val;
> +       }

...

> +       int ret;
> +       int value = 0;

Reversed xmas tree ordering?

...

> +       /*
> +        * Wait 1ms after SW-reset command.
> +        * Wait 15ms for settling of signal paths.
> +        */
> +       usleep_range(16e3, 50e3);

Hmm... Perhaps re-use msleep_range()
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx274.c#L601?

...

> +       .debugfs_reg_access = &sca3300_debugfs_reg_access,

Reading of the registers you will get as a bonus when switching over
to regmap SPI API.

-- 
With Best Regards,
Andy Shevchenko
