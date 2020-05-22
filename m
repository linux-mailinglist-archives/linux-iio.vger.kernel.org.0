Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDF1DE26A
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgEVIuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 04:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVIuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 04:50:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9DEC061A0E
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2020 01:50:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y198so4932039pfb.4
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2020 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayJW7EKR4q+HUt114gAioP8x67VenjQE2Awsf9EygYQ=;
        b=gQu0JTELqHfltcHgxtlAJF4q8D2Ya5SrsLLNOakQCtKhiz/IFPQ+kA2N6ayhK0XQao
         QIwJEevsP4ESI29PpSQFOeqf2xlinmg7I7VrKAVpPXxke9NK5pExKwd+5retpOPxSU/i
         vyCflTeGHqUetSvTDOJbNmgIe4EeZ1m4HK5nxcu1cZfBFnIsMbqiDCfJR5oEdXWHQx3O
         g03H0+jb1DPnBG2ws7U5i+//iw2GKZeJTcrX3INk7S8UnsOqXU38eJ3qCcwCFtbyQh9R
         H+AQlcAEgE3wQCtjphMXxolUG/ef4zZbYKzdMTTXJwJ6KTALKWAznbEGEMPLx+066npS
         VRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayJW7EKR4q+HUt114gAioP8x67VenjQE2Awsf9EygYQ=;
        b=jZOg5JfQRSdJ4zuN8EJ7h1PDCrZ0KzkFiSvOOjTtr/E9s3KGn9Kbd8E6InkaIw/ZcQ
         LfOjPejpnX94B8ZwtFOUU6Ww19PzULxCgCbhnKPLQS+42GEoNop8/Db8M9Yi8sYVBD13
         4YJ91OAPa7wpxrbuyjG2S2JjMEfaE1zjJ8P9y8wW3WSJRz26f+gldNHHo0KMIYM0j/pD
         cl6Ynygl5Pz4rIwmesUhn974FZPZvDW9DvHiufazFT3mRDWnZnfr/A2enZ1m5wiJta3C
         eB5wJy55j3omPQZ18dC6cxggnpDfWW/QxugaIJkhws8u/4zG/5+E6wPuhHJ8jwwM7IG1
         IwZw==
X-Gm-Message-State: AOAM5302dQVwIWot87u5k3mqXzRVH2+QlS/8ru9XjrAPU000WxI5lw/r
        AQgJ4/UtTcjQVE3XJSSmMWTol67wqCJNxyID9Hc=
X-Google-Smtp-Source: ABdhPJyOCbZx/MpcAvHesHzLOnw04BsfK4OCzq4WNzjbylcgkUJFh9cuWCvOnU0qW8okDwE1v3wrZKBfvq7VGHwN1cE=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr13010244pgb.203.1590137454290;
 Fri, 22 May 2020 01:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200522014634.28505-1-dan@dlrobertson.com> <20200522014634.28505-2-dan@dlrobertson.com>
In-Reply-To: <20200522014634.28505-2-dan@dlrobertson.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 11:50:37 +0300
Message-ID: <CAHp75Ve-ub+CAo2Q3XEAL1diph+7EVh=3L-wdnst-WJ8aM6Yxg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: accel: bma400: add support for bma400 spi
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 4:48 AM Dan Robertson <dan@dlrobertson.com> wrote:
>
> Add basic support for the Bosch Sensortec BMA400 3-axes ultra-low power
> accelerometer when configured to use SPI.

...

>         tristate "Bosch BMA400 3-Axis Accelerometer Driver"
>         select REGMAP
>         select BMA400_I2C if I2C

> +       select BMA400_SPI if I2C

This is not right.

...

> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

What's the point of dups (see below)?

> +#include <linux/spi/spi.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

Keep them ordered?

...

> +#define BMA400_SPI_READ_BUFFER_SIZE (BMA400_MAX_SPI_READ + 1)

Do wee need separate macro? It seems longer than explicit use.
Do we need the original macro either?

...

> +       /*
> +        * TODO(dlrobertson): What is a reasonable length to cap
> +        * this at.
> +        */

Either drop this or fulfill. There is no way to leave such in the
non-staging code.

...

> +       .read_flag_mask = BIT(7),

#include <linux/bits.h>

...

> +static struct spi_driver bma400_spi_driver = {
> +       .driver = {
> +               .name = "bma400",
> +               .of_match_table = bma400_of_spi_match,
> +       },
> +       .probe    = bma400_spi_probe,
> +       .remove   = bma400_spi_remove,
> +       .id_table = bma400_spi_ids,
> +};

> +

This blank line is not needed.

> +module_spi_driver(bma400_spi_driver);

-- 
With Best Regards,
Andy Shevchenko
