Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C574468B92
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhLEPGR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhLEPGR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:06:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E3C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:02:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v1so32597688edx.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DzSB9xRAJwdNPAMvbUXTrPmZ2VQ/aN6QgRN9j1i6rE=;
        b=T0v4QL/nnOsVoCzcwKyjXMLqxkT52yWOM3uA+nyLW9RG6h5Unp/2RR+DCGzmzlMz+J
         ydHN07vH/yGWPTEJyqZ+2fDqf9YANmmJ0nEOXcldg7Iv3FcUZxg4h0iiv4PVSudUNdD1
         9YVi8J0GcKnvn78FMrVzBmrOcmDzNL0k3yRptVWFNpftbxcD3f+wVk/YOTUsU27+22N/
         AbMi831NModnS+Enk/8Dgjc0/vLvFaraq3aQ3Y10WX+Fp1QjHmMqjj/os/gDhRfSErkA
         nAQtis8QY/PCbkRFxwMiBDk1b8VXIbPakKZfeuiHFHGp/wgBUbpObTlSrCwy7usiEb13
         V3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DzSB9xRAJwdNPAMvbUXTrPmZ2VQ/aN6QgRN9j1i6rE=;
        b=2fju/qbtRA+8dmbXvTYx5t148r4OM1ThMRL5oQol5RdATe+oqNvA12YyPlhOz8dZzl
         kvJvlYz3EwnKKhl5it3MzxD4JovtwnKRrwL5cg2WES6jOJGvCa8C9l1vDEO4IYh5OmtH
         YkkNklwSNAUR6xGmLTrVqnmtdZxE/oZMux0BeupFJU3s2ogLkqt9wAqOrLaNpV5WXZWf
         3c+H53zriPEdlYfWFWPrlap2DzgquKSquT/yNjAhWihekOSD8VqhA0Kj6PPcB4H/08Ij
         j9gBSItzzA+tED/4+yKO0LT0SOHeno6cIHiLEjz0yrXpTiEY+3jc9U0k4qFGLqNNyOVH
         yfXw==
X-Gm-Message-State: AOAM530U2ZO6ZDtCS53AUye3cwJRzybVL40DEY5KBAphezNXczwJ7TnU
        OroFvQ8X3DenlDbPsqsYCMrd3l3BgBed5J4pPer+H8ouWG3ExKaE
X-Google-Smtp-Source: ABdhPJxHZlNlphcJxaflhFPRiupRVjEpBp88vkp8XrDUQDMfvWevAvNTOVqtC7CYDze2GkslBNAs72YOONEowtpjWwg=
X-Received: by 2002:a50:d741:: with SMTP id i1mr45947363edj.37.1638716568533;
 Sun, 05 Dec 2021 07:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <20211204171237.2769210-2-jic23@kernel.org>
In-Reply-To: <20211204171237.2769210-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:02:12 +0200
Message-ID: <CAHp75Vd7vPfNMMBwDYuFSNtSZryyeGEDp9P6wcWCuJrz5B2OqA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] iio:dac:ad5755: Switch to generic firmware
 properties and drop pdata
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Lars pointed out that platform data can also be supported via the
> generic properties interface, so there is no point in continuing to
> support it separately.  Hence squish the linux/platform_data/ad5755.h
> header into the c file and drop accessing the platform data directly.
>
> Done by inspection only.  Mostly completely mechanical with the
> exception of a few places where default value handling is
> cleaner done by first setting the value, then calling the
> firmware reading function but and not checking the return value,
> as opposed to reading firmware then setting the default if an error
> occurs.
>
> Part of general attempt to move all of IIO over to generic
> device properties, both to enable other firmware types and
> to remove drivers that can be the source of of_ specific
> behaviour in new drivers.

...

>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/delay.h>
> -#include <linux/of.h>
> +#include <linux/property.h>

I would also add a blank line here.

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/platform_data/ad5755.h>

...


> +       const struct ad5755_platform_data *pdata = NULL;
>         struct iio_dev *indio_dev;
>         struct ad5755_state *st;
>         int ret;


> -       if (spi->dev.of_node)
> -               pdata = ad5755_parse_dt(&spi->dev);
> -       else
> -               pdata = spi->dev.platform_data;
> +       if (dev_fwnode(&spi->dev))
> +               pdata = ad5755_parse_fw(&spi->dev);
>
>         if (!pdata) {
> -               dev_warn(&spi->dev, "no platform data? using default\n");
> +               dev_warn(&spi->dev,
> +                        "no firmware provided parameters? using default\n");

It's fine to have it on one line (and not related to the 80 vs 100
case, it's about string literal as the last argument).

>                 pdata = &ad5755_default_pdata;
>         }


Perhaps

    const struct ad5755_platform_data *pdata;
    ...
    if (dev_fwnode(...))
      pdata = ...
    else
      pdata = &_default;
    if (pdata == &_default)
      dev_warn(...);

?

-- 
With Best Regards,
Andy Shevchenko
