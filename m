Return-Path: <linux-iio+bounces-6679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9CF91274B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A41F27495
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DFD134BC;
	Fri, 21 Jun 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZhofnbQl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBD46A4
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978990; cv=none; b=ug8yuhA4PFsrNuFPoyL0wMnD4fHGqxZtmTlfe/zi+fvD7PhB5+KzEkiok2qUbvAmmW+yjWqoJmZDLdWaeLwZ76lMSLgA1WnizXt8Ex30v9HO2klIr7WSJ4+EuQs2CqFrjQcMc6QQHlghzEbNCZY25ST7GEZIx89gNNEdFoOMOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978990; c=relaxed/simple;
	bh=dprXvWP7UUfIhEMu5+eE+9HI2cGd4h05Y8OsDcaXrRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt2rX+oiSAiWhSYcpZiPzLgx8pKRhq7PBKBHB7uv1K3imqWGWXSwyimpOYceLAMtv0TlFPcih1DZZjuP+/f0Sge2boW3AUZ3zI5tygL+tJNA93kwVYsARFfoZwySXOBHD6MulhbQONMSb/WEI5EtrUcNTJJUqr5FADu5nBD4NOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZhofnbQl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ed2faa05bso14819966b.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718978985; x=1719583785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLSbUBjAXIkuFS4ygbMCJA2lQku95vBKwTl1ia0EJs4=;
        b=ZhofnbQl8xPTydUTHKwTgeCErDFTYMNBscs2bAJ5fpVYvGA1WV1tXv7TakRFGJSUhC
         L3ifSfOjXYkVFW+8Xl8km1bP4+A1UmEDEqmrYMs93ltuOp5bL4fk1bsGEcxpi6+r+Io6
         Gd1vFeS6zj/DqK2LYAV8luS4EMcjMjbT1BAKUOTlTK4MUbnZTzP5MZAd85BBDj+Lmr3T
         c5atCy5nH/K/fdEV7LpPKX5S86T0blVLQdVn78gR0K1rgo2kb9Uh6tritRgQdmuTlVQ/
         ffnbrds6N40WxSaVAaBKfIYEi9+cp+61f4cB/oBzbUs0366aQ7ku2e2CL03XmBXprm40
         0tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978985; x=1719583785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLSbUBjAXIkuFS4ygbMCJA2lQku95vBKwTl1ia0EJs4=;
        b=B+vLWUAlJURmLExCqB1uDM1jDdwfL1TunwZO+ByD7xHIjqVkX3Vj54612vROw0sG7J
         9P4mDGWBSSjyOMegGDYQjktpXgkn9j9pWnIHqFjJy7toO3X78HIAXSjF1gqqh4OQb1zT
         R5MWJ4cKvshWJraYH2Kal4piNAkzQGxaBMDIFtvjBu93H3/l5hGkV0BJri+UkPrA2yIx
         18vj53Ru0a2sMdxbRGipVvmcV6jPtjFNePJ2zOx5XbzoXXsYJ9cXboUcC6vtCu6Tginm
         GBcKV42Nw8eu9qi2x51OniF9NpngW/Vzz9VQqTIYFKldn58io7Hm/MdtJZczNv+tWzUk
         ymSg==
X-Forwarded-Encrypted: i=1; AJvYcCVdVFSK64jhVwHUwxdzBQGBK91ts7iKy30PqEaczyd+5Dcguv+jMjL145IIzgJOgp+TXsHAlk0GgM3rMy8wVCK7skZ85jW70jTK
X-Gm-Message-State: AOJu0YyWg7XJZJZYI+wjphPRu6H0RFHtXoguNysSqOw5pFVG8jl3XWJm
	MdUdc3eA6Dawq7g9GwoNVw5PiH26GGxekKqHP9cZFAFRc+Qv/fG96ajHeHU4yLPp7Z5TMpYg/S2
	zD2eTfyn5hqeJyuKUfZVuQXIpaBDX4XiJyKomZw==
X-Google-Smtp-Source: AGHT+IHPWHoFqLrPWUZkzEghb4N0cuBu//04cXttegfI+X16Sl4hCeyu7Zxy2u1hIaG/8SbyomcaFn6xMFoQ7yI0cnA=
X-Received: by 2002:a17:906:a3d7:b0:a6f:b97c:ba8b with SMTP id
 a640c23a62f3a-a6fb97cc303mr382317166b.0.1718978984828; Fri, 21 Jun 2024
 07:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-3-65196a9020f1@gmail.com>
In-Reply-To: <20240621-add-tyhx-hx9023s-sensor-driver-v6-3-65196a9020f1@gmail.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Fri, 21 Jun 2024 17:09:32 +0300
Message-ID: <CA+GgBR8ojL-TT89y_=SvaidfFawW-A3JsvHYmYzZe9uKQA7QrA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:44=E2=80=AFAM Yasin Lee <yasin.lee.x@gmail.com> =
wrote:
>
> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>
> The device has the following entry points:
>
> Usual frequency:
> - sampling_frequency
>
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/
>

Hello :)

> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  drivers/iio/proximity/Kconfig   |   14 +
>  drivers/iio/proximity/Makefile  |    1 +
>  drivers/iio/proximity/hx9023s.c | 1150 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1165 insertions(+)
>
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfi=
g
> index 2ca3b0bc5eba..0694f625b432 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -32,6 +32,20 @@ config CROS_EC_MKBP_PROXIMITY
>           To compile this driver as a module, choose M here: the
>           module will be called cros_ec_mkbp_proximity.
>
> +config HX9023S
> +       tristate "TYHX HX9023S SAR sensor"
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       select REGMAP_I2C
> +       depends on I2C
> +       help
> +         Say Y here to build a driver for TYHX HX9023S capacitive SAR se=
nsor.
> +         This driver supports the TYHX HX9023S capacitive
> +         SAR sensors. This sensors is used for proximity detection appli=
cations.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called hx9023s.
> +
>  config IRSD200
>         tristate "Murata IRS-D200 PIR sensor"
>         select IIO_BUFFER
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makef=
ile
> index f36598380446..ab381cd27dbb 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AS3935)           +=3D as3935.o
>  obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) +=3D cros_ec_mkbp_proximity.o
> +obj-$(CONFIG_HX9023S)          +=3D hx9023s.o
>  obj-$(CONFIG_IRSD200)          +=3D irsd200.o
>  obj-$(CONFIG_ISL29501)         +=3D isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)    +=3D pulsedlight-lidar-lite-v2.o
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx90=
23s.c
> new file mode 100644
> index 000000000000..1d8cb9a05d8a
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -0,0 +1,1150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
> + * http://www.tianyihexin.com
> + *
> + * Driver for NanjingTianyihexin HX9023S Cap Sensor.
> + * Datasheet available at:
> + * http://www.tianyihexin.com/ueditor/php/upload/file/20240614/171833630=
3992081.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <asm/byteorder.h>
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/types.h>

A first question is: are all these headers required?
Looks like some of them could be removed.

> +
> +#define HX9023S_CHIP_ID 0x1D
> +#define HX9023S_CH_NUM 5
> +#define HX9023S_2BYTES 2
> +#define HX9023S_3BYTES 3
> +#define HX9023S_BYTES_MAX HX9023S_3BYTES
> +#define HX9023S_POS 0x03
> +#define HX9023S_NEG 0x02
> +#define HX9023S_NOT_CONNECTED 16
> +
> +#define HX9023S_GLOBAL_CTRL0                   0x00
> +#define HX9023S_PRF_CFG                        0x02
> +#define HX9023S_CH0_CFG_7_0                    0x03
> +#define HX9023S_CH4_CFG_9_8                    0x0C
> +#define HX9023S_RANGE_7_0                      0x0D
> +#define HX9023S_RANGE_9_8                      0x0E
> +#define HX9023S_RANGE_18_16                    0x0F
> +#define HX9023S_AVG0_NOSR0_CFG                 0x10
> +#define HX9023S_NOSR12_CFG                     0x11
> +#define HX9023S_NOSR34_CFG                     0x12
> +#define HX9023S_AVG12_CFG                      0x13
> +#define HX9023S_AVG34_CFG                      0x14
> +#define HX9023S_OFFSET_DAC0_7_0                0x15
> +#define HX9023S_OFFSET_DAC4_9_8                0x1E
> +#define HX9023S_SAMPLE_NUM_7_0                 0x1F
> +#define HX9023S_INTEGRATION_NUM_7_0            0x21
> +#define HX9023S_CH_NUM_CFG                     0x24
> +#define HX9023S_LP_ALP_4_CFG                   0x29
> +#define HX9023S_LP_ALP_1_0_CFG                 0x2A
> +#define HX9023S_LP_ALP_3_2_CFG                 0x2B
> +#define HX9023S_UP_ALP_1_0_CFG                 0x2C
> +#define HX9023S_UP_ALP_3_2_CFG                 0x2D
> +#define HX9023S_DN_UP_ALP_0_4_CFG              0x2E
> +#define HX9023S_DN_ALP_2_1_CFG                 0x2F
> +#define HX9023S_DN_ALP_4_3_CFG                 0x30
> +#define HX9023S_RAW_BL_RD_CFG                  0x38
> +#define HX9023S_INTERRUPT_CFG                  0x39
> +#define HX9023S_INTERRUPT_CFG1                 0x3A
> +#define HX9023S_CALI_DIFF_CFG                  0x3B
> +#define HX9023S_DITHER_CFG                     0x3C
> +#define HX9023S_DEVICE_ID                      0x60
> +#define HX9023S_PROX_STATUS                    0x6B
> +#define HX9023S_PROX_INT_HIGH_CFG              0x6C
> +#define HX9023S_PROX_INT_LOW_CFG               0x6D
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH0_0       0x80
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH0_0        0x88
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH3_1        0x8F
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH4_0        0xA2
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH4_1        0xA3
> +#define HX9023S_CAP_INI_CH4_0                  0xB3
> +#define HX9023S_LP_DIFF_CH4_2                  0xBA
> +#define HX9023S_RAW_BL_CH4_0                   0xB5
> +#define HX9023S_LP_DIFF_CH4_0                  0xB8
> +#define HX9023S_DSP_CONFIG_CTRL1               0xC8
> +#define HX9023S_CAP_INI_CH0_0                  0xE0
> +#define HX9023S_RAW_BL_CH0_0                   0xE8
> +#define HX9023S_LP_DIFF_CH0_0                  0xF4
> +#define HX9023S_LP_DIFF_CH3_2                  0xFF
> +
> +#define HX9023S_DATA_LOCK_MASK BIT(4)
> +#define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
> +#define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
> +
> +struct hx9023s_addr_val_pair {
> +       u8 addr;
> +       u8 val;
> +};

This looks like:

struct reg_sequence {
        unsigned int reg;
        unsigned int def;
        unsigned int delay_us;
};

This is defined in   include/linux/regmap.h

> +
> +struct hx9023s_ch_data {
> +       int raw; /* Raw Data*/
> +       int lp; /* Low Pass Filter Data*/
> +       int bl; /* Base Line Data */
> +       int diff; /* difference of Low Pass Data and Base Line Data */
> +
> +       struct {
> +               unsigned int near;
> +               unsigned int far;
> +       } thres;
> +
> +       u16 dac;
> +       u8 channel_positive;
> +       u8 channel_negative;
> +       bool sel_bl;
> +       bool sel_raw;
> +       bool sel_diff;
> +       bool sel_lp;
> +       bool enable;
> +};
> +
> +struct hx9023s_data {
> +       struct iio_trigger *trig;
> +       struct regmap *regmap;
> +       unsigned long chan_prox_stat;
> +       unsigned long chan_read;
> +       unsigned long chan_event;
> +       unsigned long ch_en_stat;
> +       unsigned long chan_in_use;
> +       unsigned int prox_state_reg;
> +       bool trigger_enabled;
> +
> +       struct {
> +               __le16 channels[HX9023S_CH_NUM];
> +               s64 ts __aligned(8);
> +       } buffer;
> +
> +       struct mutex mutex;
> +       struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
> +};
> +
> +static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] =3D {

Globals like this should be `static const`
Also, it would be a good idea to define this as `static const struct
reg_sequence `

Then the `regmap_multi_reg_write()` function could be used.

> +       /* scan period */
> +       { HX9023S_PRF_CFG,                    0x17 },
> +
> +       /* full scale of conversion phase of each channel */
> +       { HX9023S_RANGE_7_0,                  0x11 },
> +       { HX9023S_RANGE_9_8,                  0x02 },
> +       { HX9023S_RANGE_18_16,                0x00 },
> +
> +       /* ADC average number and OSR number of each channel */
> +       { HX9023S_AVG0_NOSR0_CFG,             0x71 },
> +       { HX9023S_NOSR12_CFG,                 0x44 },
> +       { HX9023S_NOSR34_CFG,                 0x00 },
> +       { HX9023S_AVG12_CFG,                  0x33 },
> +       { HX9023S_AVG34_CFG,                  0x00 },
> +
> +       /* sample & integration frequency of the ADC */
> +       { HX9023S_SAMPLE_NUM_7_0,             0x65 },
> +       { HX9023S_INTEGRATION_NUM_7_0,        0x65 },
> +
> +       /* coefficient of the first order low pass filter during each cha=
nnel */
> +       { HX9023S_LP_ALP_1_0_CFG,             0x22 },
> +       { HX9023S_LP_ALP_3_2_CFG,             0x22 },
> +       { HX9023S_LP_ALP_4_CFG,               0x02 },
> +
> +       /* up coefficient of the first order low pass filter during each =
channel */
> +       { HX9023S_UP_ALP_1_0_CFG,             0x88 },
> +       { HX9023S_UP_ALP_3_2_CFG,             0x88 },
> +       { HX9023S_DN_UP_ALP_0_4_CFG,          0x18 },
> +
> +       /* down coefficient of the first order low pass filter during eac=
h channel */
> +       { HX9023S_DN_ALP_2_1_CFG,             0x11 },
> +       { HX9023S_DN_ALP_4_3_CFG,             0x11 },
> +
> +       /* selection of data for the Data Mux Register to output data */
> +       { HX9023S_RAW_BL_RD_CFG,              0xF0 },
> +
> +       /* enable the interrupt function */
> +       { HX9023S_INTERRUPT_CFG,              0xFF },
> +       { HX9023S_INTERRUPT_CFG1,             0x3B },
> +       { HX9023S_DITHER_CFG,                 0x21 },
> +
> +       /* threshold of the offset compensation */
> +       { HX9023S_CALI_DIFF_CFG,              0x07 },
> +
> +       /* proximity persistency number(near & far) */
> +       { HX9023S_PROX_INT_HIGH_CFG,          0x01 },
> +       { HX9023S_PROX_INT_LOW_CFG,           0x01 },
> +
> +       /* disable the data lock */
> +       { HX9023S_DSP_CONFIG_CTRL1,           0x00 },
> +};
> +
> +static const struct iio_event_spec hx9023s_events[] =3D {
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_RISING,
> +               .mask_shared_by_all =3D BIT(IIO_EV_INFO_PERIOD),
> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +       },
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_FALLING,
> +               .mask_shared_by_all =3D BIT(IIO_EV_INFO_PERIOD),
> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +
> +       },
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_EITHER,
> +               .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +       },
> +};
> +
> +#define HX9023S_CHANNEL(idx)                                   \
> +{                                                              \
> +       .type =3D IIO_PROXIMITY,                                  \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),           \
> +       .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +       .indexed =3D 1,                                           \
> +       .channel =3D idx,                                         \
> +       .address =3D 0,                                           \
> +       .event_spec =3D hx9023s_events,                           \
> +       .num_event_specs =3D ARRAY_SIZE(hx9023s_events),          \
> +       .scan_index =3D idx,                                      \
> +       .scan_type =3D {                                          \
> +               .sign =3D 's',                                    \
> +               .realbits =3D 16,                                 \
> +               .storagebits =3D 16,                              \
> +               .endianness =3D IIO_BE,                           \
> +       },                                                      \
> +}
> +
> +static const struct iio_chan_spec hx9023s_channels[] =3D {
> +       HX9023S_CHANNEL(0),
> +       HX9023S_CHANNEL(1),
> +       HX9023S_CHANNEL(2),
> +       HX9023S_CHANNEL(3),
> +       HX9023S_CHANNEL(4),
> +       IIO_CHAN_SOFT_TIMESTAMP(5),
> +};
> +
> +static const unsigned int hx9023s_samp_freq_table[] =3D {
> +       2, 2, 4, 6, 8, 10, 14, 18, 22, 26,
> +       30, 34, 38, 42, 46, 50, 56, 62, 68, 74,
> +       80, 90, 100, 200, 300, 400, 600, 800, 1000, 2000,
> +       3000, 4000,
> +};
> +
> +static const struct regmap_range hx9023s_rd_reg_ranges[] =3D {
> +       regmap_reg_range(HX9023S_GLOBAL_CTRL0, HX9023S_LP_DIFF_CH3_2),
> +};
> +
> +static const struct regmap_range hx9023s_wr_reg_ranges[] =3D {
> +       regmap_reg_range(HX9023S_GLOBAL_CTRL0, HX9023S_LP_DIFF_CH3_2),
> +};
> +
> +static const struct regmap_range hx9023s_volatile_reg_ranges[] =3D {
> +       regmap_reg_range(HX9023S_CAP_INI_CH4_0, HX9023S_LP_DIFF_CH4_2),
> +       regmap_reg_range(HX9023S_CAP_INI_CH0_0, HX9023S_LP_DIFF_CH3_2),
> +       regmap_reg_range(HX9023S_PROX_STATUS, HX9023S_PROX_STATUS),
> +};
> +
> +static const struct regmap_access_table hx9023s_rd_regs =3D {
> +       .yes_ranges =3D hx9023s_rd_reg_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(hx9023s_rd_reg_ranges),
> +};
> +
> +static const struct regmap_access_table hx9023s_wr_regs =3D {
> +       .yes_ranges =3D hx9023s_wr_reg_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(hx9023s_wr_reg_ranges),
> +};
> +
> +static const struct regmap_access_table hx9023s_volatile_regs =3D {
> +       .yes_ranges =3D hx9023s_volatile_reg_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(hx9023s_volatile_reg_ranges),
> +};
> +
> +static const struct regmap_config hx9023s_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .cache_type =3D REGCACHE_MAPLE,
> +       .rd_table =3D &hx9023s_rd_regs,
> +       .wr_table =3D &hx9023s_wr_regs,
> +       .volatile_table =3D &hx9023s_volatile_regs,
> +};
> +
> +static int hx9023s_interrupt_enable(struct hx9023s_data *data)
> +{
> +       return regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
> +                               HX9023S_INTERRUPT_MASK, HX9023S_INTERRUPT=
_MASK);
> +}
> +
> +static int hx9023s_interrupt_disable(struct hx9023s_data *data)
> +{
> +       return regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
> +                               HX9023S_INTERRUPT_MASK, 0x00);
> +}
> +
> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
> +{
> +       if (locked)
> +               return regmap_update_bits(data->regmap, HX9023S_DSP_CONFI=
G_CTRL1,
> +                                       HX9023S_DATA_LOCK_MASK, HX9023S_D=
ATA_LOCK_MASK);
> +       else
> +               return regmap_update_bits(data->regmap, HX9023S_DSP_CONFI=
G_CTRL1,
> +                                       HX9023S_DATA_LOCK_MASK, 0);
> +}
> +
> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
> +{
> +       unsigned int i;
> +       u16 reg;
> +       u8 reg_list[HX9023S_CH_NUM * 2];
> +       u8 ch_pos[HX9023S_CH_NUM];
> +       u8 ch_neg[HX9023S_CH_NUM];
> +       /* Bit positions corresponding to input pin connections */
> +       u8 conn_cs[HX9023S_CH_NUM] =3D {0, 2, 4, 6, 8};
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {

See comment [1]

> +               ch_pos[i] =3D data->ch_data[i].channel_positive =3D=3D HX=
9023S_NOT_CONNECTED ?
> +                       HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].=
channel_positive];
> +               ch_neg[i] =3D data->ch_data[i].channel_negative =3D=3D HX=
9023S_NOT_CONNECTED ?
> +                       HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].=
channel_negative];
> +
> +               reg =3D (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_n=
eg[i]);
> +               put_unaligned_le16(reg, &reg_list[i * 2]);
> +       }
> +
> +       return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_l=
ist, HX9023S_CH_NUM * 2);
> +}
> +
> +static int hx9023s_reg_init(struct hx9023s_data *data)
> +{
> +       unsigned int i =3D 0;
> +       int ret;
> +
> +       for (i =3D 0; i < (int)ARRAY_SIZE(hx9023s_reg_init_list); i++) {
> +               ret =3D regmap_write(data->regmap, hx9023s_reg_init_list[=
i].addr,
> +                                       hx9023s_reg_init_list[i].val);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val=
)
> +{
> +       guard(mutex)(&data->mutex);
> +       return regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
> +                               HX9023S_PROX_DEBOUNCE_MASK,
> +                               FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val=
));
> +}
> +
> +static int hx9023s_write_near_debounce(struct hx9023s_data *data, int va=
l)
> +{
> +       guard(mutex)(&data->mutex);
> +       return regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG=
,
> +                               HX9023S_PROX_DEBOUNCE_MASK,
> +                               FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val=
));
> +}
> +
> +static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val=
)
> +{
> +       int ret;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_PROX_INT_LOW_CFG, val);
> +       if (ret)
> +               return ret;
> +
> +       *val =3D FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int hx9023s_read_near_debounce(struct hx9023s_data *data, int *va=
l)
> +{
> +       int ret;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_PROX_INT_HIGH_CFG, val)=
;
> +       if (ret)
> +               return ret;
> +
> +       *val =3D FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int =
*val)
> +{
> +       int ret;
> +       u8 buf[2];
> +       unsigned int reg, tmp;
> +
> +       reg =3D (ch =3D=3D 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
> +               HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
> +
> +       ret =3D regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
> +       if (ret)
> +               return ret;
> +
> +       tmp =3D (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
> +       data->ch_data[ch].thres.near =3D tmp;
> +       *val =3D tmp;
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *=
val)
> +{
> +       int ret;
> +       u8 buf[2];
> +       unsigned int reg, tmp;
> +
> +       reg =3D (ch =3D=3D 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
> +               HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
> +
> +       ret =3D regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
> +       if (ret)
> +               return ret;
> +
> +       tmp =3D (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
> +       data->ch_data[ch].thres.far =3D tmp;
> +       *val =3D tmp;
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int =
val)
> +{
> +       __le16 val_le16 =3D cpu_to_le16((val / 32) & GENMASK(9, 0));
> +       unsigned int reg;
> +
> +       data->ch_data[ch].thres.near =3D ((val / 32) & GENMASK(9, 0)) * 3=
2;
> +       reg =3D (ch =3D=3D 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
> +               HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
> +
> +       return regmap_bulk_write(data->regmap, reg, &val_le16, sizeof(val=
_le16));
> +}
> +
> +static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int v=
al)
> +{
> +       __le16 val_le16 =3D cpu_to_le16((val / 32) & GENMASK(9, 0));
> +       unsigned int reg;
> +
> +       data->ch_data[ch].thres.far =3D ((val / 32) & GENMASK(9, 0)) * 32=
;
> +       reg =3D (ch =3D=3D 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
> +               HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
> +
> +       return regmap_bulk_write(data->regmap, reg, &val_le16, sizeof(val=
_le16));
> +}
> +
> +static int hx9023s_get_prox_state(struct hx9023s_data *data)
> +{
> +       return regmap_read(data->regmap, HX9023S_PROX_STATUS, &data->prox=
_state_reg);
> +}
> +
> +static int hx9023s_data_select(struct hx9023s_data *data)
> +{
> +       int ret;
> +       unsigned int i, buf;
> +       unsigned long tmp;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, &buf);
> +       if (ret)
> +               return ret;
> +
> +       tmp =3D buf;
> +       for (i =3D 0; i < 4; i++) {
> +               data->ch_data[i].sel_diff =3D test_bit(i, &tmp);
> +               data->ch_data[i].sel_lp =3D !data->ch_data[i].sel_diff;
> +               data->ch_data[i].sel_bl =3D test_bit(i + 4, &tmp);
> +               data->ch_data[i].sel_raw =3D !data->ch_data[i].sel_bl;
> +       }
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, &buf);
> +       if (ret)
> +               return ret;
> +
> +       tmp =3D buf;
> +       data->ch_data[4].sel_diff =3D test_bit(2, &tmp);
> +       data->ch_data[4].sel_lp =3D !data->ch_data[4].sel_diff;
> +       data->ch_data[4].sel_bl =3D test_bit(3, &tmp);
> +       data->ch_data[4].sel_raw =3D !data->ch_data[4].sel_bl;
> +
> +       return 0;
> +}
> +
> +static int hx9023s_sample(struct hx9023s_data *data)
> +{
> +       int ret, value;
> +       unsigned int i;
> +       u8 data_size, offset_data_size, *p, size, rx_buf[HX9023S_CH_NUM *=
 HX9023S_BYTES_MAX];
> +
> +       ret =3D hx9023s_data_lock(data, true);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D hx9023s_data_select(data);
> +       if (ret)
> +               return ret;

From here onwards, it looks like if there is an error, then
`hx9023s_data_lock(data, false)` does not get called.
Is that expected?
Maybe some `goto err` statements would be needed?


> +
> +       data_size =3D HX9023S_3BYTES;
> +
> +       /* ch0~ch3 */
> +       p =3D rx_buf;
> +       size =3D (HX9023S_CH_NUM - 1) * data_size;
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, p, s=
ize);
> +       if (ret)
> +               return ret;
> +
> +       /* ch4 */
> +       p =3D rx_buf + size;
> +       size =3D data_size;
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0, p, s=
ize);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {

[1]
Maybe use some per-device (example: indio_dev->num_channels) here
(instead of HX9023S_CH_NUM)?
If adding support for a part with fewer channels, this would crash.
This comment is for all places where for (i =3D 0; i < HX9023S_CH_NUM;
i++)  is used

> +               value =3D get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +               value =3D sign_extend32(value, 15);
> +               data->ch_data[i].raw =3D 0;
> +               data->ch_data[i].bl =3D 0;
> +               if (data->ch_data[i].sel_raw =3D=3D true)
> +                       data->ch_data[i].raw =3D value;
> +               if (data->ch_data[i].sel_bl =3D=3D true)
> +                       data->ch_data[i].bl =3D value;
> +       }
> +
> +       /* ch0~ch3 */
> +       p =3D rx_buf;
> +       size =3D (HX9023S_CH_NUM - 1) * data_size;
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, p, =
size);
> +       if (ret)
> +               return ret;
> +
> +       /* ch4 */
> +       p =3D rx_buf + size;
> +       size =3D data_size;
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0, p, =
size);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {

See comment [1]

> +               value =3D get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +               value =3D sign_extend32(value, 15);
> +               data->ch_data[i].lp =3D 0;
> +               data->ch_data[i].diff =3D 0;
> +               if (data->ch_data[i].sel_lp =3D=3D true)
> +                       data->ch_data[i].lp =3D value;
> +               if (data->ch_data[i].sel_diff =3D=3D true)
> +                       data->ch_data[i].diff =3D value;
> +       }
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {

See comment [1]

> +               if (data->ch_data[i].sel_lp =3D=3D true && data->ch_data[=
i].sel_bl =3D=3D true)
> +                       data->ch_data[i].diff =3D data->ch_data[i].lp - d=
ata->ch_data[i].bl;
> +       }
> +
> +       /* offset DAC */
> +       offset_data_size =3D HX9023S_2BYTES;
> +       p =3D rx_buf;
> +       size =3D HX9023S_CH_NUM * offset_data_size;
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, p=
, size);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {

See comment [1]

> +               value =3D get_unaligned_le16(&rx_buf[i * offset_data_size=
]);
> +               value =3D FIELD_GET(GENMASK(11, 0), value);
> +               data->ch_data[i].dac =3D value;
> +       }
> +
> +       ret =3D hx9023s_data_lock(data, false);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
> +{
> +       int ret;
> +       unsigned int buf;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
> +       if (ret)
> +               return ret;
> +
> +       data->ch_en_stat =3D buf;
> +       if (en && data->ch_en_stat =3D=3D 0)
> +               data->prox_state_reg =3D 0;
> +
> +       data->ch_data[ch_id].enable =3D en;
> +       __assign_bit(ch_id, &data->ch_en_stat, en);
> +
> +       return regmap_write(data->regmap, HX9023S_CH_NUM_CFG, data->ch_en=
_stat);
> +}
> +
> +static int hx9023s_property_get(struct hx9023s_data *data)
> +{
> +       struct fwnode_handle *child;
> +       struct device *dev =3D regmap_get_device(data->regmap);
> +       int ret;
> +       u32 i, reg, temp, array[2];
> +
> +       data->chan_in_use =3D 0;
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {

See comment [1]

> +               data->ch_data[i].channel_positive =3D HX9023S_NOT_CONNECT=
ED;
> +               data->ch_data[i].channel_negative =3D HX9023S_NOT_CONNECT=
ED;
> +       }
> +
> +       device_for_each_child_node(dev, child) {
> +               ret =3D fwnode_property_read_u32(child, "reg", &reg);

Maybe add a protection for when reg >=3D num_channels (HX9023S_CH_NUM)?

> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, ret, "Failed to read re=
g\n");
> +               }
> +               __set_bit(reg, &data->chan_in_use);
> +
> +               if (fwnode_property_read_u32(child, "input-channel", &tem=
p) =3D=3D 0) {
> +                       data->ch_data[reg].channel_positive =3D temp;
> +                       data->ch_data[reg].channel_negative =3D HX9023S_N=
OT_CONNECTED;
> +               } else if (fwnode_property_read_u32_array(child, "diff-ch=
annels",
> +                                                       array, sizeof(arr=
ay)) =3D=3D 0) {
> +                       data->ch_data[reg].channel_positive =3D array[0];
> +                       data->ch_data[reg].channel_negative =3D array[1];
> +               } else {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, ret,
> +                               "Failed to read channel input for channel=
 %d\n", reg);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int hx9023s_update_chan_en(struct hx9023s_data *data,
> +                               unsigned long chan_read,
> +                               unsigned long chan_event)
> +{
> +       unsigned int i;
> +       unsigned long channels =3D chan_read | chan_event;
> +
> +       if ((data->chan_read | data->chan_event) !=3D channels) {
> +               for_each_set_bit(i, &channels, HX9023S_CH_NUM)
> +                       hx9023s_ch_en(data, i, test_bit(i, &data->chan_in=
_use));
> +               for_each_clear_bit(i, &channels, HX9023S_CH_NUM)
> +                       hx9023s_ch_en(data, i, false);
> +       }
> +
> +       data->chan_read =3D chan_read;
> +       data->chan_event =3D chan_event;
> +
> +       return 0;
> +}
> +
> +static int hx9023s_get_proximity(struct hx9023s_data *data,
> +                               const struct iio_chan_spec *chan,
> +                               int *val)
> +{
> +       int ret;
> +
> +       ret =3D hx9023s_sample(data);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D hx9023s_get_prox_state(data);
> +       if (ret)
> +               return ret;
> +
> +       *val =3D data->ch_data[chan->channel].diff;
> +       return IIO_VAL_INT;
> +}
> +
> +static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, in=
t *val2)
> +{
> +       int ret;
> +       unsigned int odr, index;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_PRF_CFG, &index);
> +       if (ret)
> +               return ret;
> +
> +       odr =3D hx9023s_samp_freq_table[index];
> +       *val =3D KILO / odr;
> +       *val2 =3D div_u64((KILO % odr) * MICRO, odr);
> +
> +       return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int hx9023s_read_raw(struct iio_dev *indio_dev, const struct iio_=
chan_spec *chan,
> +                               int *val, int *val2, long mask)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (chan->type !=3D IIO_PROXIMITY)
> +               return -EINVAL;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D hx9023s_get_proximity(data, chan, val);
> +               iio_device_release_direct_mode(indio_dev);
> +               return ret;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               return hx9023s_get_samp_freq(data, val, val2);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int=
 val2)
> +{
> +       struct device *dev =3D regmap_get_device(data->regmap);
> +       unsigned int i, period_ms;
> +
> +       period_ms =3D div_u64(NANO, (val * MEGA + val2));
> +
> +       for (i =3D 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
> +               if (period_ms =3D=3D hx9023s_samp_freq_table[i])
> +                       break;
> +       }
> +       if (i =3D=3D ARRAY_SIZE(hx9023s_samp_freq_table)) {
> +               dev_err(dev, "Period:%dms NOT found!\n", period_ms);
> +               return -EINVAL;
> +       }
> +
> +       return regmap_write(data->regmap, HX9023S_PRF_CFG, i);
> +}
> +
> +static int hx9023s_write_raw(struct iio_dev *indio_dev, const struct iio=
_chan_spec *chan,
> +                               int val, int val2, long mask)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       if (chan->type !=3D IIO_PROXIMITY)
> +               return -EINVAL;
> +
> +       if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ)
> +               return -EINVAL;
> +
> +       return hx9023s_set_samp_freq(data, val, val2);
> +}
> +
> +static irqreturn_t hx9023s_irq_handler(int irq, void *private)
> +{
> +       struct iio_dev *indio_dev =3D private;
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       if (data->trigger_enabled)
> +               iio_trigger_poll(data->trig);
> +
> +       return IRQ_WAKE_THREAD;
> +}
> +
> +static void hx9023s_push_events(struct iio_dev *indio_dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       s64 timestamp =3D iio_get_time_ns(indio_dev);
> +       unsigned long prox_changed;
> +       unsigned int chan;
> +
> +       hx9023s_sample(data);
> +       hx9023s_get_prox_state(data);
> +
> +       prox_changed =3D (data->chan_prox_stat ^ data->prox_state_reg) & =
data->chan_event;
> +       for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
> +               unsigned int dir;
> +
> +               dir =3D (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_F=
ALLING : IIO_EV_DIR_RISING;
> +
> +               iio_push_event(indio_dev,
> +                       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_=
TYPE_THRESH, dir),
> +                       timestamp);
> +       }
> +       data->chan_prox_stat =3D data->prox_state_reg;
> +}
> +
> +static irqreturn_t hx9023s_irq_thread_handler(int irq, void *private)
> +{
> +       struct iio_dev *indio_dev =3D private;
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&data->mutex);
> +       hx9023s_push_events(indio_dev);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int hx9023s_read_event_val(struct iio_dev *indio_dev,
> +                                const struct iio_chan_spec *chan,
> +                                enum iio_event_type type,
> +                                enum iio_event_direction dir,
> +                                enum iio_event_info info, int *val, int =
*val2)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       if (chan->type !=3D IIO_PROXIMITY)
> +               return -EINVAL;
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       return hx9023s_get_thres_far(data, chan->channel,=
 val);
> +               case IIO_EV_DIR_FALLING:
> +                       return hx9023s_get_thres_near(data, chan->channel=
, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_PERIOD:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       return hx9023s_read_far_debounce(data, val);
> +               case IIO_EV_DIR_FALLING:
> +                       return hx9023s_read_near_debounce(data, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int hx9023s_write_event_val(struct iio_dev *indio_dev,
> +                                 const struct iio_chan_spec *chan,
> +                                 enum iio_event_type type,
> +                                 enum iio_event_direction dir,
> +                                 enum iio_event_info info, int val, int =
val2)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       if (chan->type !=3D IIO_PROXIMITY)
> +               return -EINVAL;
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       return hx9023s_set_thres_far(data, chan->channel,=
 val);
> +               case IIO_EV_DIR_FALLING:
> +                       return hx9023s_set_thres_near(data, chan->channel=
, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_PERIOD:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       return hx9023s_write_far_debounce(data, val);
> +               case IIO_EV_DIR_FALLING:
> +                       return hx9023s_write_near_debounce(data, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int hx9023s_read_event_config(struct iio_dev *indio_dev,
> +                               const struct iio_chan_spec *chan,
> +                               enum iio_event_type type,
> +                               enum iio_event_direction dir)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       return test_bit(chan->channel, &data->chan_event);
> +}
> +
> +static int hx9023s_write_event_config(struct iio_dev *indio_dev,
> +                               const struct iio_chan_spec *chan,
> +                               enum iio_event_type type,
> +                               enum iio_event_direction dir,
> +                               int state)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       if (test_bit(chan->channel, &data->chan_in_use)) {
> +               hx9023s_ch_en(data, chan->channel, !!state);
> +               __assign_bit(chan->channel, &data->chan_event, data->ch_d=
ata[chan->channel].enable);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct iio_info hx9023s_info =3D {
> +       .read_raw =3D hx9023s_read_raw,
> +       .write_raw =3D hx9023s_write_raw,
> +       .read_event_value =3D hx9023s_read_event_val,
> +       .write_event_value =3D hx9023s_write_event_val,
> +       .read_event_config =3D hx9023s_read_event_config,
> +       .write_event_config =3D hx9023s_write_event_config,
> +};
> +
> +static int hx9023s_set_trigger_state(struct iio_trigger *trig, bool stat=
e)
> +{
> +       struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&data->mutex);
> +       if (state)
> +               hx9023s_interrupt_enable(data);
> +       else if (!data->chan_read)
> +               hx9023s_interrupt_disable(data);
> +       data->trigger_enabled =3D state;
> +
> +       return 0;
> +}
> +
> +static const struct iio_trigger_ops hx9023s_trigger_ops =3D {
> +       .set_trigger_state =3D hx9023s_set_trigger_state,
> +};
> +
> +static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
> +{
> +       struct iio_poll_func *pf =3D private;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       struct device *dev =3D regmap_get_device(data->regmap);
> +       int ret;
> +       unsigned int bit, index, i =3D 0;
> +
> +       guard(mutex)(&data->mutex);
> +       ret =3D hx9023s_sample(data);
> +       if (ret) {
> +               dev_warn(dev, "sampling failed\n");
> +               goto out;
> +       }
> +
> +       ret =3D hx9023s_get_prox_state(data);
> +       if (ret) {
> +               dev_warn(dev, "get prox failed\n");
> +               goto out;
> +       }
> +
> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength) {
> +               index =3D indio_dev->channels[bit].channel;
> +               data->buffer.channels[i++] =3D cpu_to_le16(data->ch_data[=
index].diff);
> +       }
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->=
timestamp);
> +
> +out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       unsigned long channels =3D 0;
> +       unsigned int bit;
> +
> +       guard(mutex)(&data->mutex);
> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength)
> +               __set_bit(indio_dev->channels[bit].channel, &channels);
> +
> +       hx9023s_update_chan_en(data, channels, data->chan_event);
> +
> +       return 0;
> +}
> +
> +static int hx9023s_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&data->mutex);
> +       hx9023s_update_chan_en(data, 0, data->chan_event);
> +
> +       return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops hx9023s_buffer_setup_ops =3D {
> +       .preenable =3D hx9023s_buffer_preenable,
> +       .postdisable =3D hx9023s_buffer_postdisable,
> +};
> +
> +static int hx9023s_id_check(struct iio_dev *indio_dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +       unsigned int id;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
> +       if (ret)
> +               return ret;
> +
> +       if (id =3D=3D HX9023S_CHIP_ID) {
> +               indio_dev->name =3D "hx9023s";

This assignment is quirky here.
Maybe move this into the probe function?
The rest of the function looks fine.

> +               return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static int hx9023s_probe(struct i2c_client *client)
> +{
> +       struct device *dev =3D &client->dev;
> +       struct iio_dev *indio_dev;
> +       struct hx9023s_data *data;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct hx9023s_da=
ta));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data =3D iio_priv(indio_dev);
> +       mutex_init(&data->mutex);
> +
> +       data->regmap =3D devm_regmap_init_i2c(client, &hx9023s_regmap_con=
fig);
> +       if (IS_ERR(data->regmap))
> +               return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap =
init failed\n");
> +
> +       ret =3D hx9023s_property_get(data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "dts phase failed\n");
> +
> +       ret =3D devm_regulator_get_enable(dev, "vdd");
> +       if (ret)
> +               return dev_err_probe(dev, ret, "regulator get failed\n");
> +
> +       ret =3D hx9023s_id_check(indio_dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "id check failed\n");
> +
> +       indio_dev->channels =3D hx9023s_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(hx9023s_channels);
> +       indio_dev->info =3D &hx9023s_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       i2c_set_clientdata(client, indio_dev);
> +
> +       ret =3D hx9023s_reg_init(data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "device init failed\n");
> +
> +       ret =3D hx9023s_ch_cfg(data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "channel config failed\n")=
;
> +
> +       ret =3D regcache_sync(data->regmap);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "regcache sync failed\n");
> +
> +       if (client->irq) {
> +               ret =3D devm_request_threaded_irq(dev, client->irq, hx902=
3s_irq_handler,
> +                                               hx9023s_irq_thread_handle=
r, IRQF_ONESHOT,
> +                                               "hx9023s_event", indio_de=
v);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "irq request faile=
d\n");
> +
> +               data->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d", in=
dio_dev->name,
> +                                               iio_device_id(indio_dev))=
;
> +               if (!data->trig)
> +                       return dev_err_probe(dev, -ENOMEM,
> +                                       "iio trigger alloc failed\n");
> +
> +               data->trig->ops =3D &hx9023s_trigger_ops;
> +               iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +               ret =3D devm_iio_trigger_register(dev, data->trig);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                       "iio trigger register failed\n");
> +       }
> +
> +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollf=
unc_store_time,
> +                                       hx9023s_trigger_handler, &hx9023s=
_buffer_setup_ops);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                               "iio triggered buffer setup failed\n");
> +
> +       ret =3D devm_iio_device_register(dev, indio_dev);

A direct return would also work:
return devm_iio_device_register(dev, indio_dev);

And it would get logged if it happens.

> +       if (ret)
> +               return dev_err_probe(dev, ret, "iio device register faile=
d\n");
> +
> +       return 0;
> +}
> +
> +static int hx9023s_suspend(struct device *dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(dev_get_drvdata(dev));
> +
> +       hx9023s_interrupt_disable(data);
> +
> +       return 0;
> +}
> +
> +static int hx9023s_resume(struct device *dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(dev_get_drvdata(dev));
> +
> +       if (data->trigger_enabled)
> +               hx9023s_interrupt_enable(data);
> +
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s=
_resume);
> +
> +static const struct of_device_id hx9023s_of_match[] =3D {
> +       { .compatible =3D "tyhx,hx9023s" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, hx9023s_of_match);
> +
> +static const struct i2c_device_id hx9023s_id[] =3D {
> +       { "hx9023s" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9023s_id);
> +
> +static struct i2c_driver hx9023s_driver =3D {
> +       .driver =3D {
> +               .name =3D "hx9023s",
> +               .of_match_table =3D hx9023s_of_match,
> +               .pm =3D &hx9023s_pm_ops,
> +
> +               /*
> +                * The I2C operations in hx9023s_reg_init() and hx9023s_c=
h_cfg()
> +                * are time-consuming. Prefer async so we don't delay boo=
t
> +                * if we're builtin to the kernel.
> +                */
> +               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +       },
> +       .probe =3D hx9023s_probe,
> +       .id_table =3D hx9023s_id,
> +};
> +module_i2c_driver(hx9023s_driver);
> +
> +MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
> +MODULE_DESCRIPTION("Driver for TYHX HX9023S SAR sensor");
> +MODULE_LICENSE("GPL");
>
> --
> 2.25.1
>
>

