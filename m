Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9F351274
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhDAJhg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhDAJhJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 05:37:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50451C0613E6;
        Thu,  1 Apr 2021 02:37:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4456479pjb.0;
        Thu, 01 Apr 2021 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRsyfN5Ras+hHwkeeBXTNewhBhlVp4my6jL5NaeELlI=;
        b=Lej32Bpor3H3GqOFCSPbJjhT7vpL+8wPDuSRWvaQ3bCsoETVVjOt0BXas1XVdQ6YY9
         7/ybmE6RFsdZPFWDEtdrdMbS3yy4snajjI1c9W05NZhy7hLk8Gl7T2R5UYMTmce7Pgo3
         xz7A16Ep0J468eGtyYU6ilvZN9DZMrD7ixoc1R7q7Wds+S72t1lfmNKyWadTRwCN20l5
         UzhrQxdvaqsbIinbMCRxcrrKvjFUrPXAoUiiFJuQ/RdkEFymnh8S0YqDLj/kEn0zd/K+
         A1nXOC8YV1g2cILkwZSjrykm2G7uofrusMGLbU9zM9RXSdjOeiIUN271T+p/zepH66tp
         XpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRsyfN5Ras+hHwkeeBXTNewhBhlVp4my6jL5NaeELlI=;
        b=kn21SBrsFCuMQ6q+99stx4CrkEDreeE0csLXD1N6dYahaHp3Ij8AwKykmtx4oiyJ4b
         skYwH+rdGx+6D7LuHVZIC9g4Pb4OT44Ilc55iQbtt3QfnIX9SqrPlW3FkzJZlhTVYih1
         RznIBN+W5ogz9/aEJ899ciJH71caUZpCyDCxd84lWXRtDSFZZQjlcIdRNC2c3sTF4goT
         O0AHjyQv7J3fXgJQD0HzvcKXE2yh9oVS7nqdqHJD6DLpoVH6lRps+GGxbU1AQ+n5q24Y
         CSr+UiIkWs/nh7wkyYOqShEVZNX4Abk23Tljz/ADifyWBxdnljtX8UImimDLp6b3xJ3H
         HnPQ==
X-Gm-Message-State: AOAM5303PdxcsC3+fNrKRNRiGBlH393eleeO/oFzw/UjIAmMulKIuxoC
        o45nwC0iQ4NiLtNP8/Xd0DgU8XR6XEBHxvjQBRo=
X-Google-Smtp-Source: ABdhPJwgdTa9XvTPSPeUfTdQbPvjJLiU9q9OJasaD6mMJ1YMQ4z46ylE1+dsa/mIPrQbnXgjYrHD4Uup5I4GZ3+WmaQ=
X-Received: by 2002:a17:902:7883:b029:e7:32bd:6b97 with SMTP id
 q3-20020a1709027883b02900e732bd6b97mr7298169pll.0.1617269828761; Thu, 01 Apr
 2021 02:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210401091648.87421-1-puranjay12@gmail.com> <20210401091648.87421-3-puranjay12@gmail.com>
In-Reply-To: <20210401091648.87421-3-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 12:36:51 +0300
Message-ID: <CAHp75Vcmyvi4V2D0cnmobTGHCS_ci2FC=cBF8tEoG9v51o8RmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 1, 2021 at 12:19 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> TMP117 is a Digital temperature sensor with integrated NV memory.
>
> Add support for tmp117 driver in iio subsystem.

+ blank line

> Datasheet:-https://www.ti.com/lit/gpn/tmp117

Make it a tag, i.e. remove the following blank line and use a space after colon.

>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

...

> +/*
> + * tmp117.c - Digital temperature sensor with integrated NV memory

It's useless and provokes an unneeded churn when having a file name
inside the file.
Please, drop it for good.

> + *
> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
> + *
> + * Driver for the Texas Instruments TMP117 Temperature Sensor

> + *

Redundant blank line.

> + * (7-bit I2C slave address (0x48 - 0x4B), changeable via ADD pins)
> + *
> + * Note: This driver assumes that the sensor has been calibrated beforehand.
> + */

...

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>

Missed:
  bitops.h //sign_extend32()
  types.h // s32


> +
> +#include <linux/iio/iio.h>

...

> +struct tmp117_data {
> +       struct i2c_client *client;
> +};

Doesn't make any sense to have a separate structure for just one
pointer member. Use that pointer directly.

...

> +       case IIO_CHAN_INFO_CALIBBIAS:
> +               ret = i2c_smbus_read_word_swapped(data->client,
> +                                       TMP117_REG_TEMP_OFFSET);
> +               if (ret < 0)
> +                       return ret;
> +               *val = ((int16_t)ret * (int32_t)TMP117_RESOLUTION_10UC)
> +                                                               / 10000;

One line

> +               *val2 = ((int16_t)ret * (int32_t)TMP117_RESOLUTION_10UC)
> +                                                               % 10000;

One line.

I'll be honest, I do not like these explicit castings at all. Can you
revisit and try to refactor that you won't need them?
For example, I can't understand how ret can be higher than 16 bit
since we checked on negative values beforehand.

> +               return IIO_VAL_INT_PLUS_MICRO;
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               /* Conversion from 10s of uC to mC
> +                * as IIO reports temperature in mC
> +                */
> +               *val = TMP117_RESOLUTION_10UC / 10000;
> +               *val2 = (TMP117_RESOLUTION_10UC % 10000) * 100;
> +               return IIO_VAL_INT_PLUS_MICRO;

You use 10000 many times, can you give it an appropriate name (via #define)?

...

> +       s16 off;

> +       case IIO_CHAN_INFO_CALIBBIAS:

> +               off = (s16)val;

Redundant explicit casting.

> +               return i2c_smbus_write_word_swapped(data->client,
> +                                               TMP117_REG_TEMP_OFFSET, off);

...

> +static const struct of_device_id tmp117_of_match[] = {
> +       { .compatible = "ti,tmp117", },

> +       { },

No need to comma in terminator line(s).

> +};

-- 
With Best Regards,
Andy Shevchenko
