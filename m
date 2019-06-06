Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1637D5A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFFTkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 15:40:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35591 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFFTkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2019 15:40:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id y6so2470888oix.2;
        Thu, 06 Jun 2019 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUkpswYzIybLr5sewhlaPDFxgSAlH6oiLrNe/6Vj/Y4=;
        b=Dn/N9iUbulCQu6csNUyC/Sd/Q29OclRWcXGVVn3cvkGqxy1QpmzlykuZHEjEi8u/uF
         +E4mfLmAHZ18SJIuP0l6fGggXy5CKBy5e4YzrQlQ6Ql10zvTaQB4GUAKyWtlXeGGC8al
         TnOW7ehroBj5alYfyLG9gcN5o9OAcjhniAeVtgtgIH70N31ekJSzdH50GMD67+Erpnb7
         kWJYF4iQ3TZxIeDwiGVB293rQjYRE9ehnt6GclZTuUfHEz7ucBLPAoUuICvmexCqhaTY
         ohjuvIvSywWGwU7sybu6KvamaVWNU+WXKOEzkAzJr6XPx4UNf7VaKVF2kzWt6tGp3/EI
         3b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUkpswYzIybLr5sewhlaPDFxgSAlH6oiLrNe/6Vj/Y4=;
        b=JM7En98byk569cfeu2BSIVF+1hVi9GEvlS9ITwyEzVKwU+CyLdQUlpm6vDElTTe2qb
         /VPipv+fHQdXmIgGv7JNHgMr+GvO3Upu8TY99Y4F/cnC3/E/+Y5zK7C4ji3L0dB6quyk
         JE6+5VCJnVlMXLrHLqpbJkQ4dPmJR/wFsnHu0Rcr+gFbWTABnkGpEmRi0jgBf0M4KOp6
         vlp7yFWhpuSnkAnVPbniDg1J+pg5dxXAAuHPnzZAF/77snYqs/fzpgHhz8q2Wta6RWxy
         GouUShLsxBnL4MVC7nLZBLUS1esC8Qu1/qgFUTryIXT750YqXlK+o//uBcBWlooA3K5D
         Exnw==
X-Gm-Message-State: APjAAAXWl3b1yKazbBobgMVa1UUjdF4tJZwlcym650aBKxZNqPJvAmmz
        sdSTQxFf+pkqMPuxWLwwxQ3DGHkt1NSjYwBqhUY=
X-Google-Smtp-Source: APXvYqyBhaSoqBuYAPh0SFHkSREbhkUVa6SoyYMKtyObf/ml8cV/SVJ90QjUl5BNaiCLFwiz0/zojjZKJq8zC9p6aKY=
X-Received: by 2002:aca:f144:: with SMTP id p65mr1253677oih.47.1559850041022;
 Thu, 06 Jun 2019 12:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190604144714.2009-1-glaroque@baylibre.com> <20190604144714.2009-4-glaroque@baylibre.com>
In-Reply-To: <20190604144714.2009-4-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:40:29 +0200
Message-ID: <CAFBinCAecHbXURFMO5z+TuwFMk_h=QMGqWxTou73Vv0q3011fw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: temperature: add a driver for the temperature
 sensor found in Amlogic Meson G12 SoCs
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     jic23@kernel.org, khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guillaume,

below are my initial impressions. I will have a closer look once
there's a decision whether this belongs to the IIO or thermal
framework.

On Tue, Jun 4, 2019 at 4:48 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> The code is based on Amlogic source code. No public datasheet for this.
the public S922X datasheet from Hardkernel [0] has some documentation
(starting at page 1106).

[...]
> +config MESON_TSENSOR
> +       tristate "Amlogic Meson temperature sensor Support"
> +       default ARCH_MESON
> +       depends on OF && ARCH_MESON
depends on OF && (ARCH_MESON || COMPILE_TEST)
so all the nice auto-builders / testing tools will speak up if someone
tries to break your driver

> +       help
> +         If you say yess here you get support for Meson Temperature sensor
s/yess/yes/

> +         for G12 SoC Family.
G12 (which I assume includes G12A and G12B) or G12A?

[...]
> diff --git a/drivers/iio/temperature/meson_tsensor.c b/drivers/iio/temperature/meson_tsensor.c
> new file mode 100644
> index 000000000000..be0a8d073ba3
> --- /dev/null
> +++ b/drivers/iio/temperature/meson_tsensor.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson Temperature Sensor
> + *
> + * Copyright (C) 2017 Huan Biao <huan.biao@amlogic.com>
> + * Copyright (C) 2019 Guillaume La Roque <glaroque@baylibre.com>
> + *
> + * Register value to celsius temperature formulas:
> + *     Read_Val            m * U
> + * U = ---------, Uptat = ---------
> + *     2^16              1 + n * U
> + *
> + * Temperature = A * ( Uptat + u_efuse / 2^16 )- B
> + *
> + *  A B m n : calibration parameters
> + *  u_efuse : fused calibration value, it's a signed 16 bits value
it's great to have this explained in the docs (instead of having to
look it up in some out of tree driver, as it's not part of the
datasheet) - thank you for this!

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iio/iio.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define TSENSOR_CFG_REG1                       0x4
> +       #define TSENSOR_CFG_REG1_RSET_VBG       BIT(12)
> +       #define TSENSOR_CFG_REG1_RSET_ADC       BIT(11)
> +       #define TSENSOR_CFG_REG1_VCM_EN         BIT(10)
> +       #define TSENSOR_CFG_REG1_VBG_EN         BIT(9)
> +       #define TSENSOR_CFG_REG1_OUT_CTL        BIT(6)
> +       #define TSENSOR_CFG_REG1_FILTER_EN      BIT(5)
> +       #define TSENSOR_CFG_REG1_DEM_EN         BIT(3)
> +       #define TSENSOR_CFG_REG1_CH_SEL         GENMASK(1, 0)
> +       #define TSENSOR_CFG_REG1_ENABLE         \
> +               (TSENSOR_CFG_REG1_FILTER_EN |   \
> +                TSENSOR_CFG_REG1_VCM_EN |      \
> +                TSENSOR_CFG_REG1_VBG_EN |      \
> +                TSENSOR_CFG_REG1_DEM_EN |      \
> +                TSENSOR_CFG_REG1_CH_SEL)
are all of these needed to enabled *and* disable the temperature
sensor? TSENSOR_CFG_REG1_CH_SEL doesn't seem related when disabling
the sensor reading (but I don't know since there's no documentation)

> +#define TSENSOR_CFG_REG2                               0x8
> +       #define TSENSOR_CFG_REG2_HITEMP_EN              BIT(31)
> +       #define TSENSOR_CFG_REG2_REBOOT_ALL_EN          BIT(30)
> +       #define TSENSOR_CFG_REG2_REBOOT_TIME            GENMASK(25, 16)
> +       #define TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE   \
> +               (TSENSOR_CFG_REG2_HITEMP_EN |           \
> +                TSENSOR_CFG_REG2_REBOOT_ALL_EN |       \
> +                TSENSOR_CFG_REG2_REBOOT_TIME)
the name mix between TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE and
TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE_MASK confused me.
personally I would drop the macros which just bit-wise or multiple
other macros together

> +       #define TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE_MASK              \
> +               (GENMASK(31, 30) | GENMASK(25, 4))
> +       #define TSENSOR_CFG_REG2_HITEMP_REBOOT_REG_MASK                 \
> +               GENMASK(15, 4)
> +       #define TSENSOR_CFG_REG2_HITEMP_REG_VAL(_reg_val)               \
> +               (FIELD_PREP(TSENSOR_CFG_REG2_HITEMP_REBOOT_REG_MASK,    \
> +                           _reg_val) |                                 \
> +                TSENSOR_CFG_REG2_HITEMP_REBOOT_ENABLE)
> +
> +#define TSENSOR_CFG_REG3               0xC
I like to use lower-case hex letters
and I also pad them -> 0x0c in this case because we have for example 0x10 below)

> +#define TSENSOR_CFG_REG4               0x10
> +#define TSENSOR_CFG_REG5               0x14
> +#define TSENSOR_CFG_REG6               0x18
> +#define TSENSOR_CFG_REG7               0x1C
> +#define TSENSOR_CFG_REG8               0x20
> +
> +#define TSENSOR_STAT0                  0x40
> +
> +#define TSENSOR_STAT9                  0x64
> +
> +#define TSENSOR_READ_TEMP_MASK         GENMASK(15, 0)
TSENSOR_STAT0_FILTER_OUT would match the naming from the datasheet

> +#define TSENSOR_TEMP_MASK              GENMASK(11, 0)
>
> +#define TSENSOR_TRIM_SIGN_MASK         BIT(15)
> +#define TSENSOR_TRIM_TEMP_MASK         GENMASK(14, 0)
> +#define TSENSOR_TRIM_VERSION_MASK      GENMASK(31, 24)
> +
> +#define TSENSOR_TRIM_VERSION(_version)         \
> +       FIELD_GET(TSENSOR_TRIM_VERSION_MASK, _version)
I would drop this and use the FIELD_GET directly where needed (it's
only one occurrence anyways)

[...]
> +static int meson_tsensor_enable(struct iio_dev *indio_dev)
> +{
> +       struct meson_tsensor *priv = iio_priv(indio_dev);
> +
> +       clk_prepare_enable(priv->clk);
may return an error which you're discarding here

> +       regmap_update_bits(priv->regmap, TSENSOR_CFG_REG1,
> +                          TSENSOR_CFG_REG1_ENABLE, TSENSOR_CFG_REG1_ENABLE);
> +
> +       return 0;
> +}
> +
> +static int meson_tsensor_disable(struct iio_dev *indio_dev)
> +{
> +       struct meson_tsensor *priv = iio_priv(indio_dev);
> +
> +       regmap_update_bits(priv->regmap, TSENSOR_CFG_REG1,
> +                          TSENSOR_CFG_REG1_ENABLE, 0);
> +       clk_disable(priv->clk);
clk_disable_unprepare as you're calling clk_prepare_enable above?

> +
> +       return 0;
make it a void function instead?

> +static const struct regmap_config meson_tsensor_regmap_config_g12a = {
> +       .reg_bits = 8,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = TSENSOR_STAT9,
.fast_io = true
if you ever need to ACK interrupts from the IRQ handler
(IIRC fast_io will use a spinlock instead of mutex)

[...]
> +static const struct of_device_id meson_tsensor_of_match[] = {
> +       {
> +               .compatible = "amlogic,meson-g12a-ddr-tsensor",
> +               .data = &meson_tsensor_g12a_ddr_param,
> +       },
> +       {
> +               .compatible = "amlogic,meson-g12a-cpu-tsensor",
> +               .data = &meson_tsensor_g12a_cpu_param,
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, meson_tsensor_of_match);
I would move the of_device_id table above the platform_driver definition below
of_device_get_match_data doesn't need the of_device_id as parameter
(compared to it's predecessor)

> +static int meson_tsensor_probe(struct platform_device *pdev)
> +{
> +       struct meson_tsensor *priv;
> +       struct iio_dev *indio_dev;
> +       struct resource *res;
> +
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +       if (!indio_dev) {
> +               dev_err(&pdev->dev, "failed allocating iio device\n");
> +               return -ENOMEM;
> +       }
> +
> +       priv = iio_priv(indio_dev);
> +       priv->data = of_device_get_match_data(&pdev->dev);
> +       if (!priv->data) {
> +               dev_err(&pdev->dev, "failed to get match data\n");
> +               return -ENODEV;
> +       }
> +
> +       indio_dev->channels = temperature_channel;
> +       indio_dev->num_channels = ARRAY_SIZE(temperature_channel);
> +       indio_dev->name = dev_name(&pdev->dev);
> +       indio_dev->dev.parent = &pdev->dev;
> +       indio_dev->dev.of_node = pdev->dev.of_node;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->info = &meson_tsensor_iio_info;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->base = devm_ioremap_resource(&pdev->dev, res);
you're only using priv->base in this function. consider dropping it
from struct meson_tsensor


[0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
