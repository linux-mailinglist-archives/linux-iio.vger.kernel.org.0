Return-Path: <linux-iio+bounces-315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6A7F726D
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD4B21226
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E111A733;
	Fri, 24 Nov 2023 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="na0eC/ia"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D0D67
	for <linux-iio@vger.kernel.org>; Fri, 24 Nov 2023 03:08:24 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d64c1155a8so1105827a34.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Nov 2023 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700824104; x=1701428904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NWJZ8vONLcSAJ3G4cErxj72gCXIFVoONPFfM9X+giv8=;
        b=na0eC/iaUKU6ncjSwD5Qu0J73gZoIjedeL2pFrn0uQq0pS/V9fdZvOMiZDJRINntlB
         770GxVmKjIhGnW551A7tdO/C2ZQWXJeiiggZ4Q/01l510TN6EdhQUtPQK4w7DwrcYlBA
         EY0+VzHhpNxb8LIjcOa03qhXjnyzLmJJJ1G3Ing/yVMzLSQZp/0Hp29SxixJQ1d9h2is
         qqu/VYIhwutdZoY/CXZt3bZn38ZhauOWdm021tJdoHDgYKgZaaXq8N6r2Pe6ZUZvTN4S
         Tz6hfj/6ZlWYoE/JaJFLlFoY+d1Zy4fNHLoxiJatoe6JQMIw8RJGmrSvrmCT4s5PoTG/
         LH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824104; x=1701428904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWJZ8vONLcSAJ3G4cErxj72gCXIFVoONPFfM9X+giv8=;
        b=TD+6xAYRCFHrI1l4zi2KYWrivTHHIpkos9FX9d9elGkyBH0pByx4vW/UorCrNtSUmx
         xrpBnDATgf/astAMJrOYQqzlLS4vXjaC6Loo7/G3AGwDhSwsayoykko5OdLbmkx7cLG+
         HqeXQhW596Ixk7UPCP+JDPoSuv8aPo1oIkzWXKThov/5l5BDVYugSteHtDNnNEk08IuL
         T098XGK40fQZKizIdZAlnkHotDkfoGlL8csXcnq/XgWxeNG6h/VfhwZ3KzVGXNl4/KR6
         URf27/3aWK02po+OF7I81z+Q62aWHduP2xP+OWgipdC4MODGU3f6nmF5p3ZifOLX6ZWC
         2aZw==
X-Gm-Message-State: AOJu0YwHjsM5SK6yn8R/LeF90D+7N9MLjkWJRMuf6uOAp052zFYHv1EZ
	AlW561s5PKQ4kN2TlQgqwYYV+qatWKw0o57bIu8E/A==
X-Google-Smtp-Source: AGHT+IGtDqJ8WmNg2weOU2NYFLICDF2tpOxqSCwpYNUOyngyl0wOFncI2eFNajZioTs0xDKrsG4mgcONeZpdX2IheCc=
X-Received: by 2002:a05:6871:7292:b0:1fa:cbf:88a3 with SMTP id
 mm18-20020a056871729200b001fa0cbf88a3mr355910oac.26.1700824103535; Fri, 24
 Nov 2023 03:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124105116.5764-1-kimseer.paller@analog.com> <20231124105116.5764-2-kimseer.paller@analog.com>
In-Reply-To: <20231124105116.5764-2-kimseer.paller@analog.com>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 24 Nov 2023 12:07:47 +0100
Message-ID: <CAKv63us8-R4ezWQMCobOshhDepsMRs-59th2ohkTdt2jcAaZBw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: frequency: admfm2000: New driver
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Acked-by: Crt Mori<cmo@melexis.com>

On Fri, 24 Nov 2023 at 11:51, Kim Seer Paller <kimseer.paller@analog.com> wrote:
>
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
>           declarations in probe function.
> V1 -> V4: No changes.
>
>  MAINTAINERS                       |   1 +
>  drivers/iio/frequency/Kconfig     |  10 +
>  drivers/iio/frequency/Makefile    |   1 +
>  drivers/iio/frequency/admfm2000.c | 310 ++++++++++++++++++++++++++++++
>  4 files changed, 322 insertions(+)
>  create mode 100644 drivers/iio/frequency/admfm2000.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1692ec68..d8630e490 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1253,6 +1253,7 @@ L:        linux-iio@vger.kernel.org
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
>  F:     Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> +F:     drivers/iio/frequency/admfm2000.c
>
>  ANALOG DEVICES INC ADMV1013 DRIVER
>  M:     Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 9e85dfa58..c455be7d4 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -60,6 +60,16 @@ config ADF4377
>           To compile this driver as a module, choose M here: the
>           module will be called adf4377.
>
> +config ADMFM2000
> +       tristate "Analog Devices ADMFM2000 Dual Microwave Down Converter"
> +       depends on GPIOLIB
> +       help
> +         Say yes here to build support for Analog Devices ADMFM2000 Dual
> +         Microwave Down Converter.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called admfm2000.
> +
>  config ADMV1013
>         tristate "Analog Devices ADMV1013 Microwave Upconverter"
>         depends on SPI && COMMON_CLK
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index b616c29b4..70d0e0b70 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
>  obj-$(CONFIG_ADF4377) += adf4377.o
> +obj-$(CONFIG_ADMFM2000) += admfm2000.o
>  obj-$(CONFIG_ADMV1013) += admv1013.o
>  obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADMV4420) += admv4420.o
> diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
> new file mode 100644
> index 000000000..351fb9044
> --- /dev/null
> +++ b/drivers/iio/frequency/admfm2000.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADMFM2000 Dual Microwave Down Converter
> + *
> + * Copyright 2023 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define ADMFM2000_MIXER_MODE           0
> +#define ADMFM2000_DIRECT_IF_MODE       1
> +#define ADMF20000_DSA_GPIOS            5
> +#define ADMF20000_MODE_GPIOS           2
> +#define ADMF20000_MAX_GAIN             0
> +#define ADMF20000_MIN_GAIN             -31000
> +#define ADMF20000_DEFAULT_GAIN         -0x20
> +
> +struct admfm2000_state {
> +       struct mutex                    lock; /* protect sensor state */
> +       struct gpio_descs               *sw_ch[2];
> +       struct gpio_descs               *dsa_gpios[2];
> +       u32                             gain[2];
> +};
> +
> +static int admfm2000_mode(struct iio_dev *indio_dev, u32 reg, u32 mode)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       DECLARE_BITMAP(values, 2);
> +
> +       switch (mode) {
> +       case ADMFM2000_MIXER_MODE:
> +               values[0] = (reg == 0) ? 1 : 2;
> +               gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
> +                                              st->sw_ch[reg]->desc,
> +                                              NULL, values);
> +               break;
> +       case ADMFM2000_DIRECT_IF_MODE:
> +               values[0] = (reg == 0) ? 2 : 1;
> +               gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
> +                                              st->sw_ch[reg]->desc,
> +                                              NULL, values);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_attenuation(struct iio_dev *indio_dev, u32 chan,
> +                                u32 value)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +
> +       values[0] = value;
> +
> +       gpiod_set_array_value_cansleep(st->dsa_gpios[chan]->ndescs,
> +                                      st->dsa_gpios[chan]->desc,
> +                                      NULL, values);
> +       return 0;
> +}
> +
> +static int admfm2000_read_raw(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan, int *val,
> +                             int *val2, long mask)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       int gain;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               mutex_lock(&st->lock);
> +               gain = ~(st->gain[chan->channel]) * -1000;
> +               *val = gain / 1000;
> +               *val2 = (gain % 1000) * 1000;
> +               mutex_unlock(&st->lock);
> +
> +               return  IIO_VAL_INT_PLUS_MICRO_DB;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int admfm2000_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan, int val,
> +                            int val2, long mask)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       int gain, ret;
> +
> +       if (val < 0)
> +               gain = (val * 1000) - (val2 / 1000);
> +       else
> +               gain = (val * 1000) + (val2 / 1000);
> +
> +       if (gain > ADMF20000_MAX_GAIN || gain < ADMF20000_MIN_GAIN)
> +               return -EINVAL;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               mutex_lock(&st->lock);
> +               st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
> +
> +               ret = admfm2000_attenuation(indio_dev, chan->channel,
> +                                           st->gain[chan->channel]);
> +
> +               mutex_unlock(&st->lock);
> +               if (ret)
> +                       return ret;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                      struct iio_chan_spec const *chan,
> +                                      long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               return IIO_VAL_INT_PLUS_MICRO_DB;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info admfm2000_info = {
> +       .read_raw = &admfm2000_read_raw,
> +       .write_raw = &admfm2000_write_raw,
> +       .write_raw_get_fmt = &admfm2000_write_raw_get_fmt,
> +};
> +
> +#define ADMFM2000_CHAN(_channel) {                                     \
> +       .type = IIO_VOLTAGE,                                            \
> +       .output = 1,                                                    \
> +       .indexed = 1,                                                   \
> +       .channel = _channel,                                            \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),          \
> +}
> +
> +static const struct iio_chan_spec admfm2000_channels[] = {
> +       ADMFM2000_CHAN(0),
> +       ADMFM2000_CHAN(1),
> +};
> +
> +static int admfm2000_channel_config(struct admfm2000_state *st,
> +                                   struct iio_dev *indio_dev)
> +{
> +       struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +       struct device *dev = &pdev->dev;
> +       struct fwnode_handle *child;
> +       u32 reg, mode;
> +       int ret;
> +
> +       device_for_each_child_node(dev, child) {
> +               ret = fwnode_property_read_u32(child, "reg", &reg);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to get reg property\n");
> +               }
> +
> +               if (reg >= indio_dev->num_channels) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
> +                                            indio_dev->num_channels);
> +               }
> +
> +               ret = fwnode_property_read_u32(child, "adi,mode", &mode);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to get mode property\n");
> +               }
> +
> +               if (mode >= 2) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, -EINVAL, "mode bigger than: 1\n");
> +               }
> +
> +               ret = admfm2000_mode(indio_dev, reg, mode);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_setup(struct admfm2000_state *st,
> +                          struct iio_dev *indio_dev)
> +{
> +       struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +       struct device *dev = &pdev->dev;
> +
> +       st->sw_ch[0] = devm_gpiod_get_array(dev, "switch1", GPIOD_OUT_LOW);
> +       if (IS_ERR(st->sw_ch[0]))
> +               return dev_err_probe(dev, PTR_ERR(st->sw_ch[0]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->sw_ch[0]->ndescs != ADMF20000_MODE_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_MODE_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       st->sw_ch[1] = devm_gpiod_get_array(dev, "switch2", GPIOD_OUT_LOW);
> +       if (IS_ERR(st->sw_ch[1]))
> +               return dev_err_probe(dev, PTR_ERR(st->sw_ch[1]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->sw_ch[1]->ndescs != ADMF20000_MODE_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_MODE_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       st->dsa_gpios[0] = devm_gpiod_get_array(dev, "attenuation1",
> +                                               GPIOD_OUT_LOW);
> +       if (IS_ERR(st->dsa_gpios[0]))
> +               return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[0]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->dsa_gpios[0]->ndescs != ADMF20000_DSA_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_DSA_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       st->dsa_gpios[1] = devm_gpiod_get_array(dev, "attenuation2",
> +                                               GPIOD_OUT_LOW);
> +       if (IS_ERR(st->dsa_gpios[1]))
> +               return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[1]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->dsa_gpios[1]->ndescs != ADMF20000_DSA_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_DSA_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct admfm2000_state *st;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st = iio_priv(indio_dev);
> +
> +       indio_dev->name = "admfm2000";
> +       indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
> +       indio_dev->channels = admfm2000_channels;
> +       indio_dev->info = &admfm2000_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       st->gain[0] = ADMF20000_DEFAULT_GAIN;
> +       st->gain[1] = ADMF20000_DEFAULT_GAIN;
> +
> +       mutex_init(&st->lock);
> +
> +       ret = admfm2000_setup(st, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = admfm2000_channel_config(st, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id admfm2000_of_match[] = {
> +       { .compatible = "adi,admfm2000" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, admfm2000_of_match);
> +
> +static struct platform_driver admfm2000_driver = {
> +       .driver = {
> +               .name = "admfm2000",
> +               .of_match_table = admfm2000_of_match,
> +       },
> +       .probe = admfm2000_probe,
> +};
> +module_platform_driver(admfm2000_driver);
> +
> +MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
> +MODULE_DESCRIPTION("ADMFM2000 Dual Microwave Down Converter");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

