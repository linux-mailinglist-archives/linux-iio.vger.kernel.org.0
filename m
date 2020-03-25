Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2C192D7B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYPyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 11:54:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33249 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgCYPyG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 11:54:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id jz1so2395405pjb.0;
        Wed, 25 Mar 2020 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2KTzbKyqjKYw4vr9/LcS8DzT4Q8P/nBfhkd8Raxax0=;
        b=J1vLle3i29D1ETVntQbTdDTo7RbhoAw4biGBEDwG+xA9B4DG3sbgqMKgP3pTvAKQT4
         bapLIr0OOYwFQPfPRaIfl7yokOqbx+ItAiIhLj667sdoKkZkf5GekVnBYl4tZ2G6GCcJ
         iRJNaGGoWZ5Yleyvy0DQJLYJUBxfc6sL9KG9zdAN3s3ZX9g33lrIvZhuRddMvSKtX7MC
         wy1hIfDzWHbcAOVE8fi19Da+UBBOV2+LZtRjFvY+itZJJd+tPnEgWkji64tWIK7kXjlP
         ZUBeNugEChi6JH16CzF2ti+g8kUB6s4Lz0lddmdx3bcwrdvXSfmTGGDcLZ+82bZwOfgb
         6Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2KTzbKyqjKYw4vr9/LcS8DzT4Q8P/nBfhkd8Raxax0=;
        b=AOifu5JN5pkSuDXtL2AkhEeDtsTRkZHxarGCDNz1E2snZ9NUtQtldqOJ+2l1D3WIjw
         iElxBn5iz0mqTr5U8ngei4WQlVMTUIP+uG6ZKqNtxe+cbNsdCF931dUOFEUtxHOtcu6T
         NCdOo/fbbmMjFVlty7Np189uYjg53//vgkap51b4BBKkDdEGZE/xJ8nK9yRWQRClPrrD
         gIvWSNYhG9on/rUPBvC7rGt7ZKrhQyIcn9Af+Ng8hEb0br77xu3PntnD5pUSNferTOvv
         f/MBfC1/PGYZqYUW/1J7Wa5sdo1fOWPwyA6CBbf61i2hTDbHg7ELGpX02RAsZhF5Absj
         X3Qw==
X-Gm-Message-State: ANhLgQ00oaPdqAMAhEC6PZGNb3telphfF8miBms/dtCULvMYHwI6UahT
        TIpvBpv9WrTRQC6VZQZdSXzhADg1Dd7p96AOhY0=
X-Google-Smtp-Source: ADFU+vs1t1sRby5FeNyrAmPWma3Y7Ur7v+64WoOhzdYpplXZSsXcLF5yer3YjgSOIvPcvdhBWolXsHmRB3zEkOiP0sQ=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr4520249pjn.8.1585151644817;
 Wed, 25 Mar 2020 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200325151211.19949-1-i.mikhaylov@yadro.com> <20200325151211.19949-3-i.mikhaylov@yadro.com>
In-Reply-To: <20200325151211.19949-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Mar 2020 17:53:57 +0200
Message-ID: <CAHp75VfjqtAtS-iXS6vz452m-EUtPcNt7EPm1JvQwC4VeX-k1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 25, 2020 at 5:14 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
>
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.

Thank you for an update, my comments below.

...

> +config VCNL3020
> +       tristate "VCNL3020 proximity sensor"

> +       depends on I2C

REGMAP_I2C

...

> +struct vcnl3020_data {
> +       struct regmap *regmap;

> +       struct i2c_client *client;

Since you have switched to regmap I2C API, do you really need client
here, perhaps struct device *dev would be enough?

> +       u8 rev;
> +       struct mutex lock;
> +};

...

> +       rc = regmap_read(data->regmap, VCNL_PROD_REV, &reg);

> +       if (rc < 0) {

I think you may drop all these ' < 0' checks for regmap, otherwise can
you elaborate what positive return code, if any, means?

> +               dev_err(&data->client->dev,
> +                       "Error (%d) reading product revision", rc);
> +               return rc;
> +       }

...

> +       rc = regmap_write(data->regmap, VCNL_LED_CURRENT, led_current);
> +       if (rc < 0) {

...after above change...

> +               dev_err(&data->client->dev, "Error (%d) setting LED current",
> +                       rc);

> +               return rc;
> +       }
> +
> +       return 0;

...simple return rc; here.

...

> +       /* wait for data to become ready */
> +       do {
> +               rc = regmap_read(data->regmap, VCNL_COMMAND, &reg);
> +               if (rc < 0)
> +                       goto err_unlock;
> +               if (reg & VCNL_PS_RDY)
> +                       break;
> +               msleep(20); /* measurement takes up to 100 ms */
> +       } while (--tries);

regmap_read_poll_timeput()

...

> +static const struct iio_chan_spec vcnl3020_channels[] = {
> +       {
> +               .type = IIO_PROXIMITY,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

> +       }

Leave comma here.

> +};

-- 
With Best Regards,
Andy Shevchenko
