Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742522B95D1
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 16:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgKSPII (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 10:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgKSPII (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 10:08:08 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46329C0613CF;
        Thu, 19 Nov 2020 07:08:08 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so4771990pfc.2;
        Thu, 19 Nov 2020 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJr2irAyZ1BAOhSvjpC4BuYUmx85w5ph5rzehiUieBM=;
        b=sQJQx92VUzfOpGZ0j2il2CFX9419U0APdsJScK/rEDTbB52uoXxerZ5OL4JaOirwBI
         fGSAEpuySffSyUXtK3LShgGS/aOLu8710guEz1cOHAvIJxcjvnhze6PZeKFRF5Bp591W
         Q8seiDsg1cs+qSJ5sQaM1nlsGeALbYn7O8N5iobKNn6zZ43kC0eZc/GFyZ/dXDakT6tU
         nWk1/SziD9+z8nkjmQqdT82r7UBmBYu14MwDibf6meck+SGgrLbmuJOP8TuerL0tWvTQ
         dKyva6r7iFVpnazWC5+XjTPy5Fmk/SNET4mp2RAkfo9lcu65T9pMJNGB3CWek7UFbiBk
         K0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJr2irAyZ1BAOhSvjpC4BuYUmx85w5ph5rzehiUieBM=;
        b=GcVKkXjikdMPxZmOh+hcshDMnoiD+Hxt24D2wgD6IxJ03fe0sljv712zFxb0ZOn+FF
         wifD1k1UfqjX+fx/mi5X3UaUXpnahVy31Hyqtd2cXceRHkIqX7Kln5nByn3OuNwMFr0O
         C/Xfpy+xJfyjuHHtcDcstcOpxs9+ZAJwAHyK/wFxeY/SLltuY1QO18avPd+/gE521N4p
         +eET9sQ1V+lx04tnV323Ymo2pPLN5pVRCWp1K9/GE0v8r3QVZMzWu27zPga4/r42aP5t
         lIQY4tZMPIIeUGIypcpB6Cu5/KoAEstWIJ4+odyKY2tp9zQ1Y/xi9RXeWYFRJqO46Egc
         pmeA==
X-Gm-Message-State: AOAM533fdOsuFbDWCRBS7M3QqUO4Ab2kZ1E6gGwdo6K3AuZ+TF/LavmT
        dvRw+liyiU7U3XrbOmPpOECIoMvs0S5SlMB2QpOkMBStGVM=
X-Google-Smtp-Source: ABdhPJxuSFR4cYa7NCo4ZvgyfmmS6rNJrSbJ7ucYHnAWBFsGMz8fK6alqBLRObqpJA9IdqKKkdMlya7P5WKkD84Q0ZM=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr9418242pfc.7.1605798487722; Thu, 19 Nov
 2020 07:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20201119100748.57689-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201119100748.57689-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Nov 2020 17:08:56 +0200
Message-ID: <CAHp75Vex498GcOpFxfze5VdK4Rhb6pvBvgf1OXLY=L5vj4Uodg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7887: convert dual-channel mode to DT/ACPI
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 19, 2020 at 12:02 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This change converts the configuration of the dual-channel mode from the
> old platform-data, to the device_property_present() function, which
> supports both device-tree and ACPI configuration setups.
>
> With this change the old platform_data include of the driver can be
> removed.

I mostly like the part of getting rid of legacy platform data.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(for patches 1-3 only)

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> I'm wondering if this changeset is what was in mind here:
>  https://lore.kernel.org/linux-iio/CA+U=DsqF5tu8Be9KXeyCWD2uHvV688Nc3n=z_Xi2J6H6DFJPRQ@mail.gmail.com/T/#mbe72e4da3acea3899d0d35402ea81e52a9bc34e6
> This driver could have been simplified/reduced a whole lot more, but I'm
> not sure about it. It's a bit of patch-noise, and later
>
> Changelog v1 -> v2:
> * dropped patch 'iio: adc: ad7887: convert driver to full DT probing'
>   not adding the device_get_match_data() logic anymore
> * added patch 'iio: adc: ad7887: remove matching code from driver'
>   hooking the chip info directly to AD7887
> * added patch 'iio: adc: ad7887: add OF match table'
>   this just adds an OF table for DT and ACPI
>
>  drivers/iio/adc/ad7887.c             | 10 +++++-----
>  include/linux/platform_data/ad7887.h | 21 ---------------------
>  2 files changed, 5 insertions(+), 26 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad7887.h
>
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 4f6f0e0e03ee..06f684c053a0 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -23,8 +23,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>
> -#include <linux/platform_data/ad7887.h>
> -
>  #define AD7887_REF_DIS         BIT(5)  /* on-chip reference disable */
>  #define AD7887_DUAL            BIT(4)  /* dual-channel mode */
>  #define AD7887_CH_AIN1         BIT(3)  /* convert on channel 1, DUAL=1 */
> @@ -241,9 +239,9 @@ static void ad7887_reg_disable(void *data)
>
>  static int ad7887_probe(struct spi_device *spi)
>  {
> -       struct ad7887_platform_data *pdata = spi->dev.platform_data;
>         struct ad7887_state *st;
>         struct iio_dev *indio_dev;
> +       bool dual_mode;
>         uint8_t mode;
>         int ret;
>
> @@ -286,7 +284,9 @@ static int ad7887_probe(struct spi_device *spi)
>         mode = AD7887_PM_MODE4;
>         if (!st->reg)
>                 mode |= AD7887_REF_DIS;
> -       if (pdata && pdata->en_dual)
> +
> +       dual_mode = device_property_present(&spi->dev, "adi,dual-channel-mode");
> +       if (dual_mode)
>                 mode |= AD7887_DUAL;
>
>         st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
> @@ -298,7 +298,7 @@ static int ad7887_probe(struct spi_device *spi)
>         spi_message_init(&st->msg[AD7887_CH0]);
>         spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
>
> -       if (pdata && pdata->en_dual) {
> +       if (dual_mode) {
>                 st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
>
>                 st->xfer[1].rx_buf = &st->data[0];
> diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
> deleted file mode 100644
> index 9b4dca6ae70b..000000000000
> --- a/include/linux/platform_data/ad7887.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * AD7887 SPI ADC driver
> - *
> - * Copyright 2010 Analog Devices Inc.
> - */
> -#ifndef IIO_ADC_AD7887_H_
> -#define IIO_ADC_AD7887_H_
> -
> -/**
> - * struct ad7887_platform_data - AD7887 ADC driver platform data
> - * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
> - *     second input channel, and Vref is internally connected to Vdd. If set to
> - *     false the device is used in single channel mode and AIN1/Vref is used as
> - *     VREF input.
> - */
> -struct ad7887_platform_data {
> -       bool en_dual;
> -};
> -
> -#endif /* IIO_ADC_AD7887_H_ */
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
