Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303D03A2BDB
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJMra (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFJMr3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:47:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C754FC061574;
        Thu, 10 Jun 2021 05:45:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k15so1527644pfp.6;
        Thu, 10 Jun 2021 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZFgjRNcsYwqR6zZ5ZdCuPdhjx4CcGH8bsJJ09OPifc=;
        b=HaEPnAYNNlpDSrNP4PY0me8e8qR05e3qyIuWtOkAyZZujQXuOIofm83/kW/Pe+eN19
         hxG8hrcuQOcTOgE/+zYHdJ44XBxloh5C+6szsqA5Ur1g3DyFGyRrAGxFflU8AA17HwVr
         an8/iAYetQ2GG9IkNlBkcl81QbxLY4pU2SKbM+GdUow5QfLtPjg+P0IOfAioEa0KEVIT
         1brlpwpx+k2DpN3PNGYlZYdHE+je82VESS4U6NeclqIRG+oQr9MIyyY3iMmR46D4TlLN
         r6DwTJBEANE45B1QQt4Sxk2GMjyT6FLQFznOo/19cKguIzUxyxBhS2PBjAJU+mp1z6H6
         fkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZFgjRNcsYwqR6zZ5ZdCuPdhjx4CcGH8bsJJ09OPifc=;
        b=m7+Ts/LY1p45zncmrcQ+Zh9Ur+kAc/qlMyX+J1vURMlChmZ559YBav8P3z3zgQwS2r
         lM5j5ju8EJy+h/F00o2Ynd2O9S6yfB7YYondQh+E6pDwd2uAu8Eh4Iiokgs8csGut8wz
         HAR5HTj7rDHsEsnVZSCi931xBUmYnSGuwHK2b8RziHBghdZE/ZFQuH+aylGJ+3VTDYwN
         mV05jQcX1T/Ky35NSWImhMyLwQGAz3MGfvKXQKGeIUarER2SksWZH0QemDiKy57iQDvp
         +s2RNLUGAk1lw5V8/F9IzJaRftl6jkKcXMNTgRQAUtOQANCH3XfuX7VgBUIUJ8Eachir
         FjvQ==
X-Gm-Message-State: AOAM532PnwGCIcOTJURBnBe2vuZvstHKrBgBEyiNZjZ/yeZvsZA6/se8
        QyfgJEGNe82iiV1qhJjNnyOBETiwbDmf7MB20+Q=
X-Google-Smtp-Source: ABdhPJziZr55ewTQf+XDVxKZLMLDQP8ruVAgdXFyyAOWErFy1EM1izvsdPhZVYz4uuEcs/hRCr/a9Atj71l9jPi3pGY=
X-Received: by 2002:a63:b507:: with SMTP id y7mr4856830pge.74.1623329133286;
 Thu, 10 Jun 2021 05:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210610122126.50504-1-stephan@gerhold.net> <20210610122126.50504-4-stephan@gerhold.net>
In-Reply-To: <20210610122126.50504-4-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 15:45:17 +0300
Message-ID: <CAHp75VcLWK=b3fn3c2m-2ZgapxrcNxJdQx7ODfZG2mRK5z+rQQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] iio: accel: bmc150: Drop duplicated documentation
 of supported chips
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:24 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> The chips supported by the bmc150-accel driver are clearly documented
> in Kconfig, in the bmc150_accel_chip_info_tbl as well as in all the
> device ID tables in the I2C/SPI drivers. It's easy to forget to update
> the lists in the file header. Drop those entirely to reduce the amount
> of changes required to add new chip variants.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> New patch in v2. Originally I tried to reorder those too but then it
> caused conflicts in all my following patches so I'm not convinced
> it's worth to try and keep those up to date.

It's not user-visible, so I'm fine, but users should have a
possibility to know about supported chips in the Kconfig option.

Assuming above is done deal,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 10 +---------
>  drivers/iio/accel/bmc150-accel-i2c.c  | 10 +---------
>  2 files changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index a0df704730ee..6fb025b4228f 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1,14 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> - *  - BMC150
> - *  - BMI055
> - *  - BMA255
> - *  - BMA250E
> - *  - BMA222
> - *  - BMA222E
> - *  - BMA280
> - *
> + * 3-axis accelerometer driver supporting many Bosch-Sensortec chips
>   * Copyright (c) 2014, Intel Corporation.
>   */
>
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index b8bda0dfb495..a0e2782580b7 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -1,14 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * 3-axis accelerometer driver supporting following I2C Bosch-Sensortec chips:
> - *  - BMC150
> - *  - BMI055
> - *  - BMA255
> - *  - BMA250E
> - *  - BMA222
> - *  - BMA222E
> - *  - BMA280
> - *
> + * 3-axis accelerometer driver supporting many I2C Bosch-Sensortec chips
>   * Copyright (c) 2014, Intel Corporation.
>   */
>
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
