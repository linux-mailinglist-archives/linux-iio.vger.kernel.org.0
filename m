Return-Path: <linux-iio+bounces-7212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E8925461
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 09:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184811F213FD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C1130AC8;
	Wed,  3 Jul 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VX1OawUO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155E13541F
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990386; cv=none; b=TrzDUr1KWj9Gh4NodomJfjDIhPGP6FP9SYWvTVWVgMIQk1u1jPoAAQ8AUO1cjmRsE5Hb1jP+MKc9vrCNZMrO2mISqiq3czFmhYmwv8mWxYWLRjMcpVO9JwkadWnHJos5YMXn286/ez5SoUnEYzhsPlXyh48N7Ol8F+vAa0FxQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990386; c=relaxed/simple;
	bh=jUicmPdse5Gm01RLEEq07RvZG3I3n2eeBgNNCHsF3G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In/DcZIw+ppEyx+AXaqRtCLxp76mdYJ/sC01s9EjAcUht3gNG39FazID7qcHdIa7a0YkbQByxkEnG6QCHesh8TWWqf+E+uj0oTmmFlDB7RFrOF4eVMxu5PdXqubFWC6Bws31LxMkllerX11mYImKIpiEN1PpossRkRpJfZleklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VX1OawUO; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48f6b596fdcso221238137.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2024 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719990381; x=1720595181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fI3GszR4h/fyLi5TJDLR6vXmtBKea2cxzeZm9lbTXQ=;
        b=VX1OawUOdS6Ev86+y+xNEjcydiIMcVSL8cMb1knrVlkgtbHGs2aF3Rslr2MhlAEKM/
         pBKK4yyLQVfbu/eLpKWjZBaFDkK7pEcJwi+Oo/MihEmNL5DAq5IQrNIKvV5W0Yw7Ukdt
         zNUmvmMGhTZV3Jt3UkbPlHZZhx8hMyAI+URqk/3r2CY5I0hZCDVLvXscpKnW0sAygPPg
         w+jQd+KtKAZFrG4tozRPF8wt954oK2N/TDePGvbeXOG5nRi8GQSeXmbVVlmqNrdtQLGM
         gA7pzVIhg9yqztId5miCBdtPh08z0GYMEeFDvSuSaM+VlW3w/9+jwZGIfAL/QVqjb6zU
         0Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719990381; x=1720595181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fI3GszR4h/fyLi5TJDLR6vXmtBKea2cxzeZm9lbTXQ=;
        b=YsMyMevx633yN9ORvjoR62fSNF0q2Ty3W6NG714p+YMP/uCfDHf9x68g2l7K67z9v7
         zS1xt8g5FuNcWYxxR71RlWu3AHKyI/TIiHGFx8VKYmvkV+QbJsrfx9ZekXcI/c4YksG+
         CPqf6/28fDfb9HTCIvGVECzhVvPM9B2x3XAD+sYYER6WHVgc1YnwIpfZpDCZYJuiNtmC
         VwZ3kb2hjhoHZbRfVS2A/2xRsuOC7alnFmvgafrzpZHHbYlnQ4HDEI1mfY/2WT/KY1ZM
         ZgccNB53mXwmZPG0MUG4xxCIEdOO15vBisCB2oliVUjavT6uEe8IoneQgV3q3WcftmHF
         S+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFcmqRyXLnRJiuJoyWWiKi7iMYqoDHve4RliWkzbrYQ3RFG23H6TNFq72nYkSj8jlKjVB1wICAGh15En7/xuBKq/pw9BOYebrj
X-Gm-Message-State: AOJu0YxoAILsAJQDW3okcRIdFMXSaeJVwb+9xSqdnWULKs9AKuocqaTM
	XY5KV9x16D/N5f9Jkuaurfqfb8Z1ACUX7+gcTnXrckDTzdb84yNd2mEQb25GIzStcDS8U8sCWBb
	T2QHjS5XHSI896YnOAC3yBhZvNjPS/e9c6O2i+Q==
X-Google-Smtp-Source: AGHT+IFfUPoYfEVEj87o17Wn8S3HmI7zoxhqT9x0eAteLiAMx7eivjwpjhiid7pTcCsuGtWy1ujSdP9V3qcLVMMU1mA=
X-Received: by 2002:a05:6122:698:b0:4f2:e302:4577 with SMTP id
 71dfb90a1353d-4f2e30248e1mr516506e0c.1.1719990380679; Wed, 03 Jul 2024
 00:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701083138.15891-1-antoniu.miclaus@analog.com> <20240701083138.15891-2-antoniu.miclaus@analog.com>
In-Reply-To: <20240701083138.15891-2-antoniu.miclaus@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 10:06:09 +0300
Message-ID: <CA+GgBR89nOCwrGgU=fsS_+woj9mDeqR_hizZMjNgLtxoZ+pY=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: accel: add ADXL380 driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jun Yan <jerrysteve1101@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 11:47=E2=80=AFAM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> The ADXL380/ADXL382 is a low noise density, low power, 3-axis
> accelerometer with selectable measurement ranges. The ADXL380 supports
> the +/-4 g, +/-8 g, and +/-16 g ranges, and the ADXL382 supports
> +/-15 g, +/-30 g and +/-60 g ranges.
> The ADXL380/ADXL382 offers industry leading noise, enabling precision
> applications with minimal calibration. The low noise, and low power
> ADXL380/ADXL382 enables accurate measurement in an environment with
> high vibration, heart sounds and audio.
>
> In addition to its low power consumption, the ADXL380/ADXL382 has many
> features to enable true system level performance. These include a
> built-in micropower temperature sensor, single / double / triple tap
> detection and a state machine to prevent a false triggering. In
> addition, the ADXL380/ADXL382 has provisions for external control of
> the sampling time and/or an external clock.
>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - drop __aligned(IIO_DMA_MINALIGN); from tables and use it on fifo_buf
>  - drop brackets around odr >> 1 and odr & 1
>  - wrap long line
>  - drop comma on null terminator
>  - fix odd indentation
>  - drop extra space before >
>  - add space before } on arrays where missing
>  MAINTAINERS                     |    4 +
>  drivers/iio/accel/Kconfig       |   27 +
>  drivers/iio/accel/Makefile      |    3 +
>  drivers/iio/accel/adxl380.c     | 1908 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/adxl380.h     |   26 +
>  drivers/iio/accel/adxl380_i2c.c |   64 ++
>  drivers/iio/accel/adxl380_spi.c |   66 ++
>  7 files changed, 2098 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl380.c
>  create mode 100644 drivers/iio/accel/adxl380.h
>  create mode 100644 drivers/iio/accel/adxl380_i2c.c
>  create mode 100644 drivers/iio/accel/adxl380_spi.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1425182c85e2..67583f13da51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -624,6 +624,10 @@ M: Antoniu Miclaus <antoniu.miclaus@analog.com>
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
>  F:     Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> +F:     drivers/iio/accel/adxl380.c
> +F:     drivers/iio/accel/adxl380.h
> +F:     drivers/iio/accel/adxl380_i2c.c
> +F:     drivers/iio/accel/adxl380_spi.c
>
>  AF8133J THREE-AXIS MAGNETOMETER DRIVER
>  M:     Ond=C5=99ej Jirman <megi@xff.cz>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c2da5066e9a7..6572ab447e14 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -177,6 +177,33 @@ config ADXL372_I2C
>           To compile this driver as a module, choose M here: the
>           module will be called adxl372_i2c.
>
> +config ADXL380
> +       tristate
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +
> +config ADXL380_SPI
> +       tristate "Analog Devices ADXL380 3-Axis Accelerometer SPI Driver"
> +       depends on SPI
> +       select ADXL380
> +       select REGMAP_SPI
> +       help
> +         Say yes here to add support for the Analog Devices ADXL380 tria=
xial
> +         acceleration sensor.
> +         To compile this driver as a module, choose M here: the
> +         module will be called adxl380_spi.
> +
> +config ADXL380_I2C
> +       tristate "Analog Devices ADXL380 3-Axis Accelerometer I2C Driver"
> +       depends on I2C
> +       select ADXL380
> +       select REGMAP_I2C
> +       help
> +         Say yes here to add support for the Analog Devices ADXL380 tria=
xial
> +         acceleration sensor.
> +         To compile this driver as a module, choose M here: the
> +         module will be called adxl380_i2c.
> +
>  config BMA180
>         tristate "Bosch BMA023/BMA1x0/BMA250 3-Axis Accelerometer Driver"
>         depends on I2C && INPUT_BMA150=3Dn
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index db90532ba24a..ca8569e25aba 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -21,6 +21,9 @@ obj-$(CONFIG_ADXL367_SPI) +=3D adxl367_spi.o
>  obj-$(CONFIG_ADXL372) +=3D adxl372.o
>  obj-$(CONFIG_ADXL372_I2C) +=3D adxl372_i2c.o
>  obj-$(CONFIG_ADXL372_SPI) +=3D adxl372_spi.o
> +obj-$(CONFIG_ADXL380) +=3D adxl380.o
> +obj-$(CONFIG_ADXL380_I2C) +=3D adxl380_i2c.o
> +obj-$(CONFIG_ADXL380_SPI) +=3D adxl380_spi.o
>  obj-$(CONFIG_BMA180) +=3D bma180.o
>  obj-$(CONFIG_BMA220) +=3D bma220_spi.o
>  obj-$(CONFIG_BMA400) +=3D bma400_core.o
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> new file mode 100644
> index 000000000000..d37f4d85cf84
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380.c
> @@ -0,0 +1,1908 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL380 3-Axis Digital Accelerometer core driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <linux/regulator/consumer.h>
> +
> +#include "adxl380.h"
> +
> +#define ADXL380_ID_VAL                         380
> +#define ADXL382_ID_VAL                         382
> +
> +#define ADXL380_DEVID_AD_REG                   0x00
> +#define ADLX380_PART_ID_REG                    0x02
> +
> +#define ADXL380_X_DATA_H_REG                   0x15
> +#define ADXL380_Y_DATA_H_REG                   0x17
> +#define ADXL380_Z_DATA_H_REG                   0x19
> +#define ADXL380_T_DATA_H_REG                   0x1B
> +
> +#define ADXL380_MISC_0_REG                     0x20
> +#define ADXL380_XL382_MSK                      BIT(7)
> +
> +#define ADXL380_MISC_1_REG                     0x21
> +
> +#define ADXL380_X_DSM_OFFSET_REG               0x4D
> +
> +#define ADXL380_ACT_INACT_CTL_REG              0x37
> +#define ADXL380_INACT_EN_MSK                   BIT(2)
> +#define ADXL380_ACT_EN_MSK                     BIT(0)
> +
> +#define ADXL380_SNSR_AXIS_EN_REG               0x38
> +#define ADXL380_ACT_INACT_AXIS_EN_MSK          GENMASK(2, 0)
> +
> +#define ADXL380_THRESH_ACT_H_REG               0x39
> +#define ADXL380_TIME_ACT_H_REG                 0x3B
> +#define ADXL380_THRESH_INACT_H_REG             0x3E
> +#define ADXL380_TIME_INACT_H_REG               0x40
> +#define ADXL380_THRESH_MAX                     GENMASK(12, 0)
> +#define ADXL380_TIME_MAX                       GENMASK(24, 0)
> +
> +#define ADXL380_FIFO_CONFIG_0_REG              0x30
> +#define ADXL380_FIFO_SAMPLES_8_MSK             BIT(0)
> +#define ADXL380_FIFO_MODE_MSK                  GENMASK(5, 4)
> +
> +#define ADXL380_FIFO_DISABLED                  0
> +#define ADXL380_FIFO_NORMAL                    1
> +#define ADXL380_FIFO_STREAMED                  2
> +#define ADXL380_FIFO_TRIGGERED                 3
> +
> +#define ADXL380_FIFO_CONFIG_1_REG              0x31
> +#define ADXL380_FIFO_STATUS_0_REG              0x1E
> +
> +#define ADXL380_TAP_THRESH_REG                 0x43
> +#define ADXL380_TAP_DUR_REG                    0x44
> +#define ADXL380_TAP_LATENT_REG                 0x45
> +#define ADXL380_TAP_WINDOW_REG                 0x46
> +#define ADXL380_TAP_TIME_MAX                   GENMASK(7, 0)
> +
> +#define ADXL380_TAP_CFG_REG                    0x47
> +#define ADXL380_TAP_AXIS_MSK                   GENMASK(1, 0)
> +
> +#define ADXL380_TRIG_CFG_REG                   0x49
> +#define ADXL380_TRIG_CFG_DEC_2X_MSK            BIT(7)
> +#define ADXL380_TRIG_CFG_SINC_RATE_MSK         BIT(6)
> +
> +#define ADXL380_FILTER_REG                     0x50
> +#define ADXL380_FILTER_EQ_FILT_MSK             BIT(6)
> +#define ADXL380_FILTER_LPF_MODE_MSK            GENMASK(5, 4)
> +#define ADXL380_FILTER_HPF_PATH_MSK            BIT(3)
> +#define ADXL380_FILTER_HPF_CORNER_MSK          GENMASK(2, 0)
> +
> +#define ADXL380_OP_MODE_REG                    0x26
> +#define ADXL380_OP_MODE_RANGE_MSK              GENMASK(7, 6)
> +#define ADXL380_OP_MODE_MSK                    GENMASK(3, 0)
> +#define ADXL380_OP_MODE_STANDBY                        0
> +#define ADXL380_OP_MODE_HEART_SOUND            1
> +#define ADXL380_OP_MODE_ULP                    2
> +#define ADXL380_OP_MODE_VLP                    3
> +#define ADXL380_OP_MODE_LP                     4
> +#define ADXL380_OP_MODE_LP_ULP                 6
> +#define ADXL380_OP_MODE_LP_VLP                 7
> +#define ADXL380_OP_MODE_RBW                    8
> +#define ADXL380_OP_MODE_RBW_ULP                        10
> +#define ADXL380_OP_MODE_RBW_VLP                        11
> +#define ADXL380_OP_MODE_HP                     12
> +#define ADXL380_OP_MODE_HP_ULP                 14
> +#define ADXL380_OP_MODE_HP_VLP                 15
> +
> +#define ADXL380_OP_MODE_4G_RANGE               0
> +#define ADXL382_OP_MODE_15G_RANGE              0
> +#define ADXL380_OP_MODE_8G_RANGE               1
> +#define ADXL382_OP_MODE_30G_RANGE              1
> +#define ADXL380_OP_MODE_16G_RANGE              2
> +#define ADXL382_OP_MODE_60G_RANGE              2
> +
> +#define ADXL380_DIG_EN_REG                     0x27
> +#define ADXL380_CHAN_EN_MSK(chan)              BIT(4 + (chan))
> +#define ADXL380_FIFO_EN_MSK                    BIT(3)
> +
> +#define ADXL380_INT0_MAP0_REG                  0x2B
> +#define ADXL380_INT1_MAP0_REG                  0x2D
> +#define ADXL380_INT_MAP0_INACT_INT0_MSK                BIT(6)
> +#define ADXL380_INT_MAP0_ACT_INT0_MSK          BIT(5)
> +#define ADXL380_INT_MAP0_FIFO_WM_INT0_MSK      BIT(3)
> +
> +#define ADXL380_INT0_MAP1_REG                  0x2C
> +#define ADXL380_INT1_MAP1_REG                  0x2E
> +#define ADXL380_INT_MAP1_DOUBLE_TAP_INT0_MSK   BIT(1)
> +#define ADXL380_INT_MAP1_SINGLE_TAP_INT0_MSK   BIT(0)
> +
> +#define ADXL380_INT0_REG                       0x5D
> +#define ADXL380_INT0_POL_MSK                   BIT(7)
> +
> +#define ADXL380_RESET_REG                      0x2A
> +#define ADXL380_FIFO_DATA                      0x1D
> +
> +#define ADXL380_DEVID_AD_VAL                   0xAD
> +#define ADXL380_RESET_CODE                     0x52
> +
> +#define ADXL380_STATUS_0_REG                   0x11
> +#define ADXL380_STATUS_0_FIFO_FULL_MSK         BIT(1)
> +#define ADXL380_STATUS_0_FIFO_WM_MSK           BIT(3)
> +
> +#define ADXL380_STATUS_1_INACT_MSK             BIT(6)
> +#define ADXL380_STATUS_1_ACT_MSK               BIT(5)
> +#define ADXL380_STATUS_1_DOUBLE_TAP_MSK                BIT(1)
> +#define ADXL380_STATUS_1_SINGLE_TAP_MSK                BIT(0)
> +
> +#define ADXL380_FIFO_SAMPLES                   315UL
> +
> +enum adxl380_channels {
> +       ADXL380_ACCEL_X,
> +       ADXL380_ACCEL_Y,
> +       ADXL380_ACCEL_Z,
> +       ADXL380_TEMP,
> +       ADXL380_CH_NUM,

nitpick:  If ADXL380_CH_NUM is the number of channels, then a trailing
comma is not needed.
Fine to also leave it.

> +};
> +
> +enum adxl380_axis {
> +       ADXL380_X_AXIS,
> +       ADXL380_Y_AXIS,
> +       ADXL380_Z_AXIS,
> +};
> +
> +enum adxl380_activity_type {
> +       ADXL380_ACTIVITY,
> +       ADXL380_INACTIVITY,
> +};
> +
> +enum adxl380_tap_type {
> +       ADXL380_SINGLE_TAP,
> +       ADXL380_DOUBLE_TAP,
> +};
> +
> +enum adxl380_tap_time_type {
> +       ADXL380_TAP_TIME_LATENT,
> +       ADXL380_TAP_TIME_WINDOW,
> +};
> +
> +static const int adxl380_range_scale_factor_tbl[] =3D { 1, 2, 4 };
> +
> +const struct adxl380_chip_info adxl380_chip_info =3D {
> +       .name =3D "adxl380",
> +       .chip_id =3D ADXL380_ID_VAL,
> +       .scale_tbl =3D {
> +               [ADXL380_OP_MODE_4G_RANGE] =3D { 0, 1307226 },
> +               [ADXL380_OP_MODE_8G_RANGE] =3D { 0, 2615434 },
> +               [ADXL380_OP_MODE_16G_RANGE] =3D { 0, 5229886 },
> +       },
> +       .samp_freq_tbl =3D { 8000, 16000, 32000 },
> +       /*
> +        * The datasheet defines an intercept of 470 LSB at 25 degC
> +        * and a sensitivity of 10.2 LSB/C.
> +        */
> +       .temp_offset =3D  25 * 102 / 10 - 470,
> +
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl380_chip_info, IIO_ADXL380);
> +
> +const struct adxl380_chip_info adxl382_chip_info =3D {
> +       .name =3D "adxl382",
> +       .chip_id =3D ADXL382_ID_VAL,
> +       .scale_tbl =3D {
> +               [ADXL382_OP_MODE_15G_RANGE] =3D { 0, 4903325 },
> +               [ADXL382_OP_MODE_30G_RANGE] =3D { 0, 9806650 },
> +               [ADXL382_OP_MODE_60G_RANGE] =3D { 0, 19613300 },
> +       },
> +       .samp_freq_tbl =3D { 16000, 32000, 64000 },
> +       /*
> +        * The datasheet defines an intercept of 570 LSB at 25 degC
> +        * and a sensitivity of 10.2 LSB/C.
> +        */
> +       .temp_offset =3D  25 * 102 / 10 - 570,
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl382_chip_info, IIO_ADXL380);
> +
> +static const unsigned int adxl380_th_reg_high_addr[2] =3D {
> +       [ADXL380_ACTIVITY] =3D ADXL380_THRESH_ACT_H_REG,
> +       [ADXL380_INACTIVITY] =3D ADXL380_THRESH_INACT_H_REG,
> +};
> +
> +static const unsigned int adxl380_time_reg_high_addr[2] =3D {
> +       [ADXL380_ACTIVITY] =3D ADXL380_TIME_ACT_H_REG,
> +       [ADXL380_INACTIVITY] =3D ADXL380_TIME_INACT_H_REG,
> +};
> +
> +static const unsigned int adxl380_tap_time_reg[2] =3D {
> +       [ADXL380_TAP_TIME_LATENT] =3D ADXL380_TAP_LATENT_REG,
> +       [ADXL380_TAP_TIME_WINDOW] =3D ADXL380_TAP_WINDOW_REG,
> +};
> +
> +struct adxl380_state {
> +       struct regmap *regmap;
> +       struct device *dev;
> +       const struct adxl380_chip_info *chip_info;
> +       /*
> +        * Synchronize access to members of driver state, and ensure atom=
icity
> +        * of consecutive regmap operations.
> +        */
> +       struct mutex lock;
> +       enum adxl380_axis tap_axis_en;
> +       u8 range;
> +       u8 odr;
> +       u8 fifo_set_size;
> +       u8 transf_buf[3];
> +       u16 watermark;
> +       u32 act_time_ms;
> +       u32 act_threshold;
> +       u32 inact_time_ms;
> +       u32 inact_threshold;
> +       u32 tap_latent_us;
> +       u32 tap_window_us;
> +       u32 tap_duration_us;
> +       u32 tap_threshold;
> +       int irq;
> +       int int_map[2];
> +       int lpf_tbl[4];
> +       int hpf_tbl[7][2];
> +
> +       __be16 fifo_buf[ADXL380_FIFO_SAMPLES] __aligned(IIO_DMA_MINALIGN)=
;
> +};
> +
> +bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg)
> +{
> +       return reg =3D=3D ADXL380_FIFO_DATA;
> +}
> +EXPORT_SYMBOL_NS_GPL(adxl380_readable_noinc_reg, IIO_ADXL380);
> +
> +static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
> +{
> +       int ret;
> +       unsigned int act_inact_ctl;
> +       u8 op_mode =3D ADXL380_OP_MODE_STANDBY;
> +
> +       if (en) {
> +               ret =3D regmap_read(st->regmap, ADXL380_ACT_INACT_CTL_REG=
, &act_inact_ctl);
> +               if (ret)
> +                       return ret;
> +
> +               /* Activity/ Inactivity detection available only in VLP/U=
LP mode */
> +               if (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
> +                   FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl))
> +                       op_mode =3D ADXL380_OP_MODE_VLP;
> +               else
> +                       op_mode =3D ADXL380_OP_MODE_HP;
> +       }
> +
> +       return regmap_update_bits(st->regmap, ADXL380_OP_MODE_REG,
> +                                ADXL380_OP_MODE_MSK,
> +                                FIELD_PREP(ADXL380_OP_MODE_MSK, op_mode)=
);
> +}
> +
> +static void adxl380_scale_act_inact_thresholds(struct adxl380_state *st,
> +                                              u8 old_range,
> +                                              u8 new_range)
> +{
> +       st->act_threshold =3D mult_frac(st->act_threshold,
> +                                     adxl380_range_scale_factor_tbl[old_=
range],
> +                                     adxl380_range_scale_factor_tbl[new_=
range]);
> +       st->inact_threshold =3D mult_frac(st->inact_threshold,
> +                                       adxl380_range_scale_factor_tbl[ol=
d_range],
> +                                       adxl380_range_scale_factor_tbl[ne=
w_range]);
> +}
> +
> +static int adxl380_write_act_inact_threshold(struct adxl380_state *st,
> +                                            enum adxl380_activity_type a=
ct,
> +                                            unsigned int th)
> +{
> +       int ret;
> +       u8 reg =3D adxl380_th_reg_high_addr[act];
> +
> +       if (th > ADXL380_THRESH_MAX)
> +               return -EINVAL;
> +
> +       ret =3D regmap_write(st->regmap, reg + 1, th & GENMASK(7, 0));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, reg, GENMASK(2, 0), th >> =
8);
> +       if (ret)
> +               return ret;
> +
> +       if (act =3D=3D ADXL380_ACTIVITY)
> +               st->act_threshold =3D th;
> +       else
> +               st->inact_threshold =3D th;
> +
> +       return 0;
> +}
> +
> +static int adxl380_set_act_inact_threshold(struct iio_dev *indio_dev,
> +                                          enum adxl380_activity_type act=
,
> +                                          u16 th)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_write_act_inact_threshold(st, act, th);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_set_tap_threshold_value(struct iio_dev *indio_dev, u8=
 th)
> +{
> +       int ret;
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(st->regmap, ADXL380_TAP_THRESH_REG, th);
> +       if (ret)
> +               return ret;
> +
> +       st->tap_threshold =3D th;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int _adxl380_write_tap_time_us(struct adxl380_state *st,
> +                                     enum adxl380_tap_time_type tap_time=
_type,
> +                                     u32 us)
> +{
> +       u8 reg =3D adxl380_tap_time_reg[tap_time_type];
> +       unsigned int reg_val;
> +       int ret;
> +
> +       /* scale factor for tap window is 1250us / LSB */
> +       reg_val =3D DIV_ROUND_CLOSEST(us, 1250);
> +       if (reg_val > ADXL380_TAP_TIME_MAX)
> +               reg_val =3D ADXL380_TAP_TIME_MAX;
> +
> +       ret =3D regmap_write(st->regmap, reg, reg_val);
> +       if (ret)
> +               return ret;
> +
> +       if (tap_time_type =3D=3D ADXL380_TAP_TIME_WINDOW)
> +               st->tap_window_us =3D us;
> +       else
> +               st->tap_latent_us =3D us;
> +
> +       return 0;
> +}
> +
> +static int adxl380_write_tap_time_us(struct adxl380_state *st,
> +                                    enum adxl380_tap_time_type tap_time_=
type, u32 us)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D _adxl380_write_tap_time_us(st, tap_time_type, us);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_write_tap_dur_us(struct iio_dev *indio_dev, u32 us)
> +{
> +       int ret;
> +       unsigned int reg_val;
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       /* 625us per code is the scale factor of TAP_DUR register */
> +       reg_val =3D DIV_ROUND_CLOSEST(us, 625);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(st->regmap, ADXL380_TAP_DUR_REG, reg_val);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_read_chn(struct adxl380_state *st, u8 addr)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_bulk_read(st->regmap, addr, &st->transf_buf, 2);
> +       if (ret)
> +               return ret;
> +
> +       return get_unaligned_be16(st->transf_buf);
> +}
> +
> +static int adxl380_get_odr(struct adxl380_state *st, int *odr)
> +{
> +       int ret;
> +       unsigned int trig_cfg, odr_idx;
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_TRIG_CFG_REG, &trig_cfg);
> +       if (ret)
> +               return ret;
> +
> +       odr_idx =3D (FIELD_GET(ADXL380_TRIG_CFG_SINC_RATE_MSK, trig_cfg) =
<< 1) |
> +                 (FIELD_GET(ADXL380_TRIG_CFG_DEC_2X_MSK, trig_cfg) & 1);
> +
> +       *odr =3D st->chip_info->samp_freq_tbl[odr_idx];
> +
> +       return 0;
> +}
> +
> +static const int adxl380_lpf_div[] =3D {
> +       1, 4, 8, 16,
> +};
> +
> +static int adxl380_fill_lpf_tbl(struct adxl380_state *st)
> +{
> +       int ret, i;
> +       int odr;
> +
> +       ret =3D adxl380_get_odr(st, &odr);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(st->lpf_tbl); i++)
> +               st->lpf_tbl[i] =3D DIV_ROUND_CLOSEST(odr, adxl380_lpf_div=
[i]);
> +
> +       return 0;
> +}
> +
> +static const int adxl380_hpf_mul[] =3D {
> +       0, 247000, 62084, 15545, 3862, 954, 238,
> +};
> +
> +static int adxl380_fill_hpf_tbl(struct adxl380_state *st)
> +{
> +       int i, ret, odr_hz;
> +       u32 multiplier;
> +       u64 div, rem, odr;
> +
> +       ret =3D  adxl380_get_odr(st, &odr_hz);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(adxl380_hpf_mul); i++) {
> +               odr =3D mul_u64_u32_shr(odr_hz, MEGA, 0);
> +               multiplier =3D adxl380_hpf_mul[i];
> +               div =3D div64_u64_rem(mul_u64_u32_shr(odr, multiplier, 0)=
,
> +                                   TERA * 100, &rem);
> +
> +               st->hpf_tbl[i][0] =3D div;
> +               st->hpf_tbl[i][1] =3D div_u64(rem, MEGA * 100);
> +       }
> +
> +       return 0;
> +}
> +
> +static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
> +                                ADXL380_TRIG_CFG_DEC_2X_MSK,
> +                                FIELD_PREP(ADXL380_TRIG_CFG_DEC_2X_MSK, =
odr & 1));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
> +                                ADXL380_TRIG_CFG_SINC_RATE_MSK,
> +                                FIELD_PREP(ADXL380_TRIG_CFG_SINC_RATE_MS=
K, odr >> 1));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_set_measure_en(st, true);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_fill_lpf_tbl(st);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_fill_hpf_tbl(st);
> +}
> +
> +static int adxl380_find_match_1d_tbl(const int *array, unsigned int size=
,
> +                                    int val)

I think this was copied from adxl372.
But, I am wondering (at a later point in time), if it makes sense to
use (or create) a common utility function for this.
I haven't looked yet, if there is one.

> +{
> +       int i;
> +
> +       for (i =3D 0; i < size; i++) {
> +               if (val =3D=3D array[i])
> +                       return i;
> +       }
> +
> +       return size - 1;
> +}
> +
> +static int adxl380_find_match_2d_tbl(const int (*freq_tbl)[2], int n, in=
t val, int val2)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < n; i++) {
> +               if (freq_tbl[i][0] =3D=3D val && freq_tbl[i][1] =3D=3D va=
l2)
> +                       return i;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int adxl380_get_lpf(struct adxl380_state *st, int *lpf)
> +{
> +       int ret;
> +       unsigned int trig_cfg, lpf_idx;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_FILTER_REG, &trig_cfg);
> +       if (ret)
> +               return ret;
> +
> +       lpf_idx =3D FIELD_GET(ADXL380_FILTER_LPF_MODE_MSK, trig_cfg);
> +
> +       *lpf =3D st->lpf_tbl[lpf_idx];
> +
> +       return 0;
> +}
> +
> +static int adxl380_set_lpf(struct adxl380_state *st, u8 lpf)
> +{
> +       int ret;
> +       u8 eq_bypass =3D 0;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       if (lpf)
> +               eq_bypass =3D 1;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_FILTER_REG,
> +                                ADXL380_FILTER_EQ_FILT_MSK,
> +                                FIELD_PREP(ADXL380_FILTER_EQ_FILT_MSK, e=
q_bypass));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_FILTER_REG,
> +                                ADXL380_FILTER_LPF_MODE_MSK,
> +                                FIELD_PREP(ADXL380_FILTER_LPF_MODE_MSK, =
lpf));
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_get_hpf(struct adxl380_state *st, int *hpf_int, int *=
hpf_frac)
> +{
> +       int ret;
> +       unsigned int trig_cfg, hpf_idx;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_FILTER_REG, &trig_cfg);
> +       if (ret)
> +               return ret;
> +
> +       hpf_idx =3D FIELD_GET(ADXL380_FILTER_HPF_CORNER_MSK, trig_cfg);
> +
> +       *hpf_int =3D st->hpf_tbl[hpf_idx][0];
> +       *hpf_frac =3D st->hpf_tbl[hpf_idx][1];
> +
> +       return 0;
> +}
> +
> +static int adxl380_set_hpf(struct adxl380_state *st, u8 hpf)
> +{
> +       int ret;
> +       u8 hpf_path =3D 0;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       if (hpf)
> +               hpf_path =3D 1;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_FILTER_REG,
> +                                ADXL380_FILTER_HPF_PATH_MSK,
> +                                FIELD_PREP(ADXL380_FILTER_HPF_PATH_MSK, =
hpf_path));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_FILTER_REG,
> +                                ADXL380_FILTER_HPF_CORNER_MSK,
> +                                FIELD_PREP(ADXL380_FILTER_HPF_CORNER_MSK=
, hpf));
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int _adxl380_set_act_inact_time_ms(struct adxl380_state *st,
> +                                         enum adxl380_activity_type act,
> +                                         u32 ms)
> +{
> +       u8 reg =3D adxl380_time_reg_high_addr[act];
> +       unsigned int reg_val;
> +       int ret;
> +
> +       /* 500us per code is the scale factor of TIME_ACT / TIME_INACT re=
gisters */
> +       reg_val =3D min(DIV_ROUND_CLOSEST(ms * 1000, 500), ADXL380_TIME_M=
AX);
> +
> +       put_unaligned_be24(reg_val, &st->transf_buf[0]);
> +
> +       ret =3D regmap_bulk_write(st->regmap, reg, st->transf_buf, sizeof=
(st->transf_buf));
> +       if (ret)
> +               return ret;
> +
> +       if (act =3D=3D ADXL380_ACTIVITY)
> +               st->act_time_ms =3D ms;
> +       else
> +               st->inact_time_ms =3D ms;
> +
> +       return 0;
> +}
> +
> +static int adxl380_set_act_inact_time_ms(struct adxl380_state *st,
> +                                        enum adxl380_activity_type act,
> +                                        u32 ms)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D _adxl380_set_act_inact_time_ms(st, act, ms);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_set_range(struct adxl380_state *st, u8 range)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_OP_MODE_REG,
> +                                ADXL380_OP_MODE_RANGE_MSK,
> +                                FIELD_PREP(ADXL380_OP_MODE_RANGE_MSK, ra=
nge));
> +
> +       if (ret)
> +               return ret;
> +
> +       adxl380_scale_act_inact_thresholds(st, st->range, range);
> +
> +       /* Activity thresholds depend on range */
> +       ret =3D adxl380_write_act_inact_threshold(st, ADXL380_ACTIVITY,
> +                                               st->act_threshold);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_write_act_inact_threshold(st, ADXL380_INACTIVITY,
> +                                               st->inact_threshold);
> +       if (ret)
> +               return ret;
> +
> +       st->range =3D range;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_write_act_inact_en(struct adxl380_state *st,
> +                                     enum adxl380_activity_type type,
> +                                     bool en)
> +{
> +       if (type =3D=3D ADXL380_ACTIVITY)
> +               return regmap_update_bits(st->regmap, ADXL380_ACT_INACT_C=
TL_REG,
> +                                         ADXL380_ACT_EN_MSK,
> +                                         FIELD_PREP(ADXL380_ACT_EN_MSK, =
en));
> +
> +       return regmap_update_bits(st->regmap, ADXL380_ACT_INACT_CTL_REG,
> +                                 ADXL380_INACT_EN_MSK,
> +                                 FIELD_PREP(ADXL380_INACT_EN_MSK, en));
> +}
> +
> +static int adxl380_read_act_inact_int(struct adxl380_state *st,
> +                                     enum adxl380_activity_type type,
> +                                     bool *en)
> +{
> +       int ret;
> +       unsigned int reg_val;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_read(st->regmap, st->int_map[0], &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       if (type =3D=3D ADXL380_ACTIVITY)
> +               *en =3D FIELD_GET(ADXL380_INT_MAP0_ACT_INT0_MSK, reg_val)=
;
> +       else
> +               *en =3D FIELD_GET(ADXL380_INT_MAP0_INACT_INT0_MSK, reg_va=
l);
> +
> +       return 0;
> +}
> +
> +static int adxl380_write_act_inact_int(struct adxl380_state *st,
> +                                      enum adxl380_activity_type act,
> +                                      bool en)
> +{
> +       if (act =3D=3D ADXL380_ACTIVITY)
> +               return regmap_update_bits(st->regmap, st->int_map[0],
> +                                         ADXL380_INT_MAP0_ACT_INT0_MSK,
> +                                         FIELD_PREP(ADXL380_INT_MAP0_ACT=
_INT0_MSK, en));
> +
> +       return regmap_update_bits(st->regmap, st->int_map[0],
> +                                 ADXL380_INT_MAP0_INACT_INT0_MSK,
> +                                 FIELD_PREP(ADXL380_INT_MAP0_INACT_INT0_=
MSK, en));
> +}
> +
> +static int adxl380_act_inact_config(struct adxl380_state *st,
> +                                   enum adxl380_activity_type type,
> +                                   bool en)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_write_act_inact_en(st, type, en);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_write_act_inact_int(st, type, en);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_write_tap_axis(struct adxl380_state *st,
> +                                 enum adxl380_axis axis)
> +{
> +       int ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_TAP_CFG_REG,
> +                                ADXL380_TAP_AXIS_MSK,
> +                                FIELD_PREP(ADXL380_TAP_AXIS_MSK, axis));
> +
> +       if (ret)
> +               return ret;
> +
> +       st->tap_axis_en =3D axis;
> +
> +       return 0;
> +}
> +
> +static int adxl380_read_tap_int(struct adxl380_state *st, enum adxl380_t=
ap_type type, bool *en)
> +{
> +       int ret;
> +       unsigned int reg_val;
> +
> +       ret =3D regmap_read(st->regmap, st->int_map[1], &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       if (type =3D=3D ADXL380_SINGLE_TAP)
> +               *en =3D FIELD_GET(ADXL380_INT_MAP1_SINGLE_TAP_INT0_MSK, r=
eg_val);
> +       else
> +               *en =3D FIELD_GET(ADXL380_INT_MAP1_DOUBLE_TAP_INT0_MSK, r=
eg_val);
> +
> +       return 0;
> +}
> +
> +static int adxl380_write_tap_int(struct adxl380_state *st, enum adxl380_=
tap_type type, bool en)
> +{
> +       if (type =3D=3D ADXL380_SINGLE_TAP)
> +               return regmap_update_bits(st->regmap, st->int_map[1],
> +                                         ADXL380_INT_MAP1_SINGLE_TAP_INT=
0_MSK,
> +                                         FIELD_PREP(ADXL380_INT_MAP1_SIN=
GLE_TAP_INT0_MSK, en));
> +
> +       return regmap_update_bits(st->regmap, st->int_map[1],
> +                                 ADXL380_INT_MAP1_DOUBLE_TAP_INT0_MSK,
> +                                 FIELD_PREP(ADXL380_INT_MAP1_DOUBLE_TAP_=
INT0_MSK, en));
> +}
> +
> +static int adxl380_tap_config(struct adxl380_state *st,
> +                             enum adxl380_axis axis,
> +                             enum adxl380_tap_type type,
> +                             bool en)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_write_tap_axis(st, axis);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_write_tap_int(st, type, en);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_set_fifo_samples(struct adxl380_state *st)
> +{
> +       int ret;
> +       u16 fifo_samples =3D st->watermark * st->fifo_set_size;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0_REG,
> +                                ADXL380_FIFO_SAMPLES_8_MSK,
> +                                FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK,
> +                                           (fifo_samples & BIT(8))));
> +       if (ret)
> +               return ret;
> +
> +       return regmap_write(st->regmap, ADXL380_FIFO_CONFIG_1_REG,
> +                           fifo_samples & 0xFF);
> +}
> +
> +static int adxl380_get_status(struct adxl380_state *st, u8 *status0, u8 =
*status1)
> +{
> +       int ret;
> +
> +       /* STATUS0, STATUS1 are adjacent regs */
> +       ret =3D regmap_bulk_read(st->regmap, ADXL380_STATUS_0_REG,
> +                              &st->transf_buf, 2);
> +       if (ret)
> +               return ret;
> +
> +       *status0 =3D st->transf_buf[0];
> +       *status1 =3D st->transf_buf[1];
> +
> +       return 0;
> +}
> +
> +static int adxl380_get_fifo_entries(struct adxl380_state *st, u16 *fifo_=
entries)
> +{
> +       int ret;
> +
> +       ret =3D regmap_bulk_read(st->regmap, ADXL380_FIFO_STATUS_0_REG,
> +                              &st->transf_buf, 2);
> +       if (ret)
> +               return ret;
> +
> +       *fifo_entries =3D st->transf_buf[0] | ((BIT(0) & st->transf_buf[1=
]) << 8);
> +
> +       return 0;
> +}
> +
> +static void adxl380_push_event(struct iio_dev *indio_dev, s64 timestamp,
> +                              u8 status1)
> +{
> +       if (FIELD_GET(ADXL380_STATUS_1_ACT_MSK, status1))
> +               iio_push_event(indio_dev,
> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X=
_OR_Y_OR_Z,
> +                                                 IIO_EV_TYPE_THRESH, IIO=
_EV_DIR_RISING),
> +                              timestamp);
> +
> +       if (FIELD_GET(ADXL380_STATUS_1_INACT_MSK, status1))
> +               iio_push_event(indio_dev,
> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X=
_OR_Y_OR_Z,
> +                                                 IIO_EV_TYPE_THRESH, IIO=
_EV_DIR_FALLING),
> +                              timestamp);
> +       if (FIELD_GET(ADXL380_STATUS_1_SINGLE_TAP_MSK, status1))
> +               iio_push_event(indio_dev,
> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X=
_OR_Y_OR_Z,
> +                                                 IIO_EV_TYPE_GESTURE, II=
O_EV_DIR_SINGLETAP),
> +                              timestamp);
> +
> +       if (FIELD_GET(ADXL380_STATUS_1_DOUBLE_TAP_MSK, status1))
> +               iio_push_event(indio_dev,
> +                              IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X=
_OR_Y_OR_Z,
> +                                                 IIO_EV_TYPE_GESTURE, II=
O_EV_DIR_DOUBLETAP),
> +                              timestamp);
> +}
> +
> +static irqreturn_t adxl380_irq_handler(int irq, void  *p)
> +{
> +       struct iio_dev *indio_dev =3D p;
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       u8 status0, status1;
> +       u16 fifo_entries;
> +       int i;
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_get_status(st, &status0, &status1);
> +       if (ret)
> +               return IRQ_HANDLED;
> +
> +       adxl380_push_event(indio_dev, iio_get_time_ns(indio_dev), status1=
);
> +
> +       if (!FIELD_GET(ADXL380_STATUS_0_FIFO_WM_MSK, status0))
> +               return IRQ_HANDLED;
> +
> +       ret =3D adxl380_get_fifo_entries(st, &fifo_entries);
> +       if (ret)
> +               return IRQ_HANDLED;
> +
> +       for (i =3D 0; i < fifo_entries; i +=3D st->fifo_set_size) {
> +               ret =3D regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
> +                                       &st->fifo_buf[i],
> +                                       2 * st->fifo_set_size);
> +               if (ret)
> +                       return IRQ_HANDLED;
> +               iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int adxl380_write_calibbias_value(struct adxl380_state *st,
> +                                        unsigned long chan_addr,
> +                                        s8 calibbias)
> +{
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(st->regmap, ADXL380_X_DSM_OFFSET_REG + chan_=
addr, calibbias);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_read_calibbias_value(struct adxl380_state *st,
> +                                       unsigned long chan_addr,
> +                                       int *calibbias)
> +{
> +       int ret;
> +       unsigned int reg_val;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_X_DSM_OFFSET_REG + chan_a=
ddr, &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       *calibbias =3D sign_extend32(reg_val, 7);
> +
> +       return 0;
> +}
> +
> +static ssize_t hwfifo_watermark_min_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       return sysfs_emit(buf, "1\n");
> +}
> +
> +static ssize_t hwfifo_watermark_max_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       return sysfs_emit(buf, "%lu\n", ADXL380_FIFO_SAMPLES);
> +}
> +
> +static ssize_t adxl380_get_fifo_watermark(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       return sysfs_emit(buf, "%d\n", st->watermark);
> +}
> +
> +static ssize_t adxl380_get_fifo_enabled(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +       unsigned int reg_val;
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_DIG_EN_REG, &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%lu\n",
> +                         FIELD_GET(ADXL380_FIFO_EN_MSK, reg_val));
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +                      adxl380_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +                      adxl380_get_fifo_enabled, NULL, 0);
> +
> +static const struct iio_dev_attr *adxl380_fifo_attributes[] =3D {
> +       &iio_dev_attr_hwfifo_watermark_min,
> +       &iio_dev_attr_hwfifo_watermark_max,
> +       &iio_dev_attr_hwfifo_watermark,
> +       &iio_dev_attr_hwfifo_enabled,
> +       NULL
> +};
> +
> +static int adxl380_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int i;
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap,
> +                                st->int_map[0],
> +                                ADXL380_INT_MAP0_FIFO_WM_INT0_MSK,
> +                                FIELD_PREP(ADXL380_INT_MAP0_FIFO_WM_INT0=
_MSK, 1));
> +       if (ret)
> +               return ret;
> +
> +       for_each_clear_bit(i, indio_dev->active_scan_mask, ADXL380_CH_NUM=
) {

Would this need to be?:
for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength)

Or, is the logic intended to go over the cleared bits here?

Depending on what's needed here, this could make use of
"iio_for_each_active_channel()" later.


> +               ret =3D regmap_update_bits(st->regmap, ADXL380_DIG_EN_REG=
,
> +                                        ADXL380_CHAN_EN_MSK(i),
> +                                        0 << (4 + i));
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       st->fifo_set_size =3D bitmap_weight(indio_dev->active_scan_mask,
> +                                         indio_dev->masklength);

Depending on Nuno's series (and if that gets accepted first), this
might need to use the new iio_get_masklength() wrapper.
That's not a reason against this going in first though.

> +
> +       if ((st->watermark * st->fifo_set_size) > ADXL380_FIFO_SAMPLES)
> +               st->watermark =3D (ADXL380_FIFO_SAMPLES  / st->fifo_set_s=
ize);
> +
> +       ret =3D adxl380_set_fifo_samples(st);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_DIG_EN_REG, ADXL38=
0_FIFO_EN_MSK,
> +                                FIELD_PREP(ADXL380_FIFO_EN_MSK, 1));
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int ret, i;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D adxl380_set_measure_en(st, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(st->regmap,
> +                                st->int_map[0],
> +                                ADXL380_INT_MAP0_FIFO_WM_INT0_MSK,
> +                                FIELD_PREP(ADXL380_INT_MAP0_FIFO_WM_INT0=
_MSK, 0));
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < indio_dev->num_channels; i++) {
> +               ret =3D regmap_update_bits(st->regmap, ADXL380_DIG_EN_REG=
,
> +                                        ADXL380_CHAN_EN_MSK(i),
> +                                        1 << (4 + i));
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_DIG_EN_REG, ADXL38=
0_FIFO_EN_MSK,
> +                                FIELD_PREP(ADXL380_FIFO_EN_MSK, 0));
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +static const struct iio_buffer_setup_ops adxl380_buffer_ops =3D {
> +       .postenable =3D adxl380_buffer_postenable,
> +       .predisable =3D adxl380_buffer_predisable,
> +};
> +
> +static int adxl380_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long info)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D adxl380_read_chn(st, chan->address);
> +               if (ret)
> +                       return ret;
> +
> +               iio_device_release_direct_mode(indio_dev);
> +
> +               *val =3D sign_extend32(ret >> chan->scan_type.shift,
> +                                    chan->scan_type.realbits - 1);
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_ACCEL:
> +                       scoped_guard(mutex, &st->lock) {
> +                               *val =3D st->chip_info->scale_tbl[st->ran=
ge][0];
> +                               *val2 =3D st->chip_info->scale_tbl[st->ra=
nge][1];
> +                       }
> +                       return IIO_VAL_INT_PLUS_NANO;
> +               case IIO_TEMP:
> +                       /* 10.2 LSB / Degree Celsius */
> +                       *val =3D 10000;
> +                       *val2 =3D 102;
> +                       return IIO_VAL_FRACTIONAL;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_OFFSET:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       *val =3D st->chip_info->temp_offset;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_CALIBBIAS:
> +               switch (chan->type) {
> +               case IIO_ACCEL:
> +                       ret =3D adxl380_read_calibbias_value(st, chan->sc=
an_index, val);
> +                       if (ret)
> +                               return ret;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               ret =3D adxl380_get_odr(st, val);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               ret =3D  adxl380_get_lpf(st, val);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +               ret =3D  adxl380_get_hpf(st, val, val2);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int adxl380_read_avail(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan,
> +                             const int **vals, int *type, int *length,
> +                             long mask)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       if (chan->type !=3D IIO_ACCEL)
> +               return -EINVAL;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals =3D (const int *)st->chip_info->scale_tbl;
> +               *type =3D IIO_VAL_INT_PLUS_NANO;
> +               *length =3D ARRAY_SIZE(st->chip_info->scale_tbl) * 2;
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *vals =3D (const int *)st->chip_info->samp_freq_tbl;
> +               *type =3D IIO_VAL_INT;
> +               *length =3D ARRAY_SIZE(st->chip_info->samp_freq_tbl);
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               *vals =3D (const int *)st->lpf_tbl;
> +               *type =3D IIO_VAL_INT;
> +               *length =3D ARRAY_SIZE(st->lpf_tbl);
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +               *vals =3D (const int *)st->hpf_tbl;
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               /* Values are stored in a 2D matrix */
> +               *length =3D ARRAY_SIZE(st->hpf_tbl) * 2;
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int adxl380_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int val, int val2, long info)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int odr_index, lpf_index, hpf_index, range_index;
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               odr_index =3D adxl380_find_match_1d_tbl(st->chip_info->sa=
mp_freq_tbl,
> +                                                     ARRAY_SIZE(st->chip=
_info->samp_freq_tbl),
> +                                                     val);
> +               return adxl380_set_odr(st, odr_index);
> +       case IIO_CHAN_INFO_CALIBBIAS:
> +               return adxl380_write_calibbias_value(st, chan->scan_index=
, val);
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               lpf_index =3D adxl380_find_match_1d_tbl(st->lpf_tbl,
> +                                                     ARRAY_SIZE(st->lpf_=
tbl),
> +                                                     val);
> +               if (lpf_index < 0)
> +                       return lpf_index;

The way I see adxl380_find_match_1d_tbl(), it will never return negative.

> +               return adxl380_set_lpf(st, lpf_index);
> +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +               hpf_index =3D adxl380_find_match_2d_tbl(st->hpf_tbl,
> +                                                     ARRAY_SIZE(st->hpf_=
tbl),
> +                                                     val, val2);
> +               if (hpf_index < 0)
> +                       return hpf_index;
> +               return adxl380_set_hpf(st, hpf_index);
> +       case IIO_CHAN_INFO_SCALE:
> +               range_index =3D adxl380_find_match_2d_tbl(st->chip_info->=
scale_tbl,
> +                                                       ARRAY_SIZE(st->ch=
ip_info->scale_tbl),
> +                                                       val, val2);
> +               if (range_index < 0)
> +                       return range_index;
> +               return adxl380_set_range(st, range_index);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int adxl380_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                    struct iio_chan_spec const *chan,
> +                                    long info)
> +{
> +       switch (info) {
> +       case IIO_CHAN_INFO_SCALE:
> +               if (chan->type !=3D IIO_ACCEL)
> +                       return -EINVAL;
> +
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
> +}
> +
> +static int adxl380_read_event_config(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +       bool int_en;
> +       bool tap_axis_en =3D false;
> +
> +       switch (chan->channel2) {
> +       case IIO_MOD_X:
> +               tap_axis_en =3D st->tap_axis_en =3D=3D ADXL380_X_AXIS;
> +               break;
> +       case IIO_MOD_Y:
> +               tap_axis_en =3D st->tap_axis_en =3D=3D ADXL380_Y_AXIS;
> +               break;
> +       case IIO_MOD_Z:
> +               tap_axis_en =3D st->tap_axis_en =3D=3D ADXL380_Z_AXIS;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       switch (dir) {
> +       case IIO_EV_DIR_RISING:
> +               ret =3D adxl380_read_act_inact_int(st, ADXL380_ACTIVITY, =
&int_en);
> +               if (ret)
> +                       return ret;
> +               return int_en;
> +       case IIO_EV_DIR_FALLING:
> +               ret =3D adxl380_read_act_inact_int(st, ADXL380_INACTIVITY=
, &int_en);
> +               if (ret)
> +                       return ret;
> +               return int_en;
> +       case IIO_EV_DIR_SINGLETAP:
> +               ret =3D adxl380_read_tap_int(st, ADXL380_SINGLE_TAP, &int=
_en);
> +               if (ret)
> +                       return ret;
> +               return int_en && tap_axis_en;
> +       case IIO_EV_DIR_DOUBLETAP:
> +               ret =3D adxl380_read_tap_int(st, ADXL380_DOUBLE_TAP, &int=
_en);
> +               if (ret)
> +                       return ret;
> +               return int_en && tap_axis_en;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int adxl380_write_event_config(struct iio_dev *indio_dev,
> +                                     const struct iio_chan_spec *chan,
> +                                     enum iio_event_type type,
> +                                     enum iio_event_direction dir,
> +                                     int state)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       enum adxl380_axis axis;
> +
> +       switch (chan->channel2) {
> +       case IIO_MOD_X:
> +               axis =3D ADXL380_X_AXIS;
> +               break;
> +       case IIO_MOD_Y:
> +               axis =3D ADXL380_Y_AXIS;
> +               break;
> +       case IIO_MOD_Z:
> +               axis =3D ADXL380_Z_AXIS;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       switch (dir) {
> +       case IIO_EV_DIR_RISING:
> +               return adxl380_act_inact_config(st, ADXL380_ACTIVITY, sta=
te);
> +       case IIO_EV_DIR_FALLING:
> +               return adxl380_act_inact_config(st, ADXL380_INACTIVITY, s=
tate);
> +       case IIO_EV_DIR_SINGLETAP:
> +               return adxl380_tap_config(st, axis, ADXL380_SINGLE_TAP, s=
tate);
> +       case IIO_EV_DIR_DOUBLETAP:
> +               return adxl380_tap_config(st, axis, ADXL380_DOUBLE_TAP, s=
tate);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int adxl380_read_event_value(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan,
> +                                   enum iio_event_type type,
> +                                   enum iio_event_direction dir,
> +                                   enum iio_event_info info,
> +                                   int *val, int *val2)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&st->lock);
> +
> +       switch (type) {
> +       case IIO_EV_TYPE_THRESH:
> +               switch (info) {
> +               case IIO_EV_INFO_VALUE: {
> +                       switch (dir) {
> +                       case IIO_EV_DIR_RISING:
> +                               *val =3D st->act_threshold;
> +                               return IIO_VAL_INT;
> +                       case IIO_EV_DIR_FALLING:
> +                               *val =3D st->inact_threshold;
> +                               return IIO_VAL_INT;
> +                       default:
> +                               return -EINVAL;
> +                       }
> +               }
> +               case IIO_EV_INFO_PERIOD:
> +                       switch (dir) {
> +                       case IIO_EV_DIR_RISING:
> +                               *val =3D st->act_time_ms;
> +                               *val2 =3D 1000;
> +                               return IIO_VAL_FRACTIONAL;
> +                       case IIO_EV_DIR_FALLING:
> +                               *val =3D st->inact_time_ms;
> +                               *val2 =3D 1000;
> +                               return IIO_VAL_FRACTIONAL;
> +                       default:
> +                               return -EINVAL;
> +                       }
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_TYPE_GESTURE:
> +               switch (info) {
> +               case IIO_EV_INFO_VALUE:
> +                       *val =3D st->tap_threshold;
> +                       return IIO_VAL_INT;
> +               case IIO_EV_INFO_RESET_TIMEOUT:
> +                       *val =3D st->tap_window_us;
> +                       *val2 =3D 1000000;
> +                       return IIO_VAL_FRACTIONAL;
> +               case IIO_EV_INFO_TAP2_MIN_DELAY:
> +                       *val =3D st->tap_latent_us;
> +                       *val2 =3D 1000000;
> +                       return IIO_VAL_FRACTIONAL;
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int adxl380_write_event_value(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type, enum iio_e=
vent_direction dir,
> +                                    enum iio_event_info info, int val, i=
nt val2)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       u32 val_ms, val_us;
> +
> +       if (chan->type !=3D IIO_ACCEL)
> +               return -EINVAL;
> +
> +       switch (type) {
> +       case IIO_EV_TYPE_THRESH:
> +               switch (info) {
> +               case IIO_EV_INFO_VALUE:
> +                       switch (dir) {
> +                       case IIO_EV_DIR_RISING:
> +                               return adxl380_set_act_inact_threshold(in=
dio_dev,
> +                                                                      AD=
XL380_ACTIVITY, val);
> +                       case IIO_EV_DIR_FALLING:
> +                               return adxl380_set_act_inact_threshold(in=
dio_dev,
> +                                                                      AD=
XL380_INACTIVITY, val);
> +                       default:
> +                               return -EINVAL;
> +                       }
> +               case IIO_EV_INFO_PERIOD:
> +                       val_ms =3D val * 1000 + DIV_ROUND_UP(val2, 1000);
> +                       switch (dir) {
> +                       case IIO_EV_DIR_RISING:
> +                               return adxl380_set_act_inact_time_ms(st,
> +                                                                    ADXL=
380_ACTIVITY, val_ms);
> +                       case IIO_EV_DIR_FALLING:
> +                               return adxl380_set_act_inact_time_ms(st,
> +                                                                    ADXL=
380_INACTIVITY, val_ms);
> +                       default:
> +                               return -EINVAL;
> +                       }
> +
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_TYPE_GESTURE:
> +               switch (info) {
> +               case IIO_EV_INFO_VALUE:
> +                       return adxl380_set_tap_threshold_value(indio_dev,=
 val);
> +               case IIO_EV_INFO_RESET_TIMEOUT:
> +                       val_us =3D val * 1000000 + val2;
> +                       return adxl380_write_tap_time_us(st,
> +                                                        ADXL380_TAP_TIME=
_WINDOW,
> +                                                        val_us);
> +               case IIO_EV_INFO_TAP2_MIN_DELAY:
> +                       val_us =3D val * 1000000 + val2;
> +                       return adxl380_write_tap_time_us(st,
> +                                                        ADXL380_TAP_TIME=
_LATENT,
> +                                                        val_us);
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static ssize_t in_accel_gesture_tap_maxtomin_time_show(struct device *de=
v,
> +                                                      struct device_attr=
ibute *attr,
> +                                                      char *buf)
> +{
> +       int vals[2];
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&st->lock);
> +
> +       vals[0] =3D st->tap_duration_us;
> +       vals[1] =3D MICRO;
> +
> +       return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
> +}
> +
> +static ssize_t in_accel_gesture_tap_maxtomin_time_store(struct device *d=
ev,
> +                                                       struct device_att=
ribute *attr,
> +                                                       const char *buf, =
size_t len)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       int ret, val_int, val_fract_us;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us)=
;
> +       if (ret)
> +               return ret;
> +
> +       /* maximum value is 255 * 625 us =3D 0.159375 seconds */
> +       if (val_int || val_fract_us > 159375 || val_fract_us < 0)
> +               return -EINVAL;
> +
> +       ret =3D adxl380_write_tap_dur_us(indio_dev, val_fract_us);
> +       if (ret)
> +               return ret;
> +
> +       return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(in_accel_gesture_tap_maxtomin_time, 0);
> +
> +static struct attribute *adxl380_event_attributes[] =3D {
> +       &iio_dev_attr_in_accel_gesture_tap_maxtomin_time.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group adxl380_event_attribute_group =3D {
> +       .attrs =3D adxl380_event_attributes,
> +};
> +
> +static int adxl380_reg_access(struct iio_dev *indio_dev,
> +                             unsigned int reg,
> +                             unsigned int writeval,
> +                             unsigned int *readval)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       if (readval)
> +               return regmap_read(st->regmap, reg, readval);
> +
> +       return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int adxl380_set_watermark(struct iio_dev *indio_dev, unsigned int=
 val)
> +{
> +       struct adxl380_state *st  =3D iio_priv(indio_dev);
> +
> +       st->watermark =3D min(val, ADXL380_FIFO_SAMPLES);
> +
> +       return 0;
> +}
> +
> +static const struct iio_info adxl380_info =3D {
> +       .read_raw =3D adxl380_read_raw,
> +       .read_avail =3D &adxl380_read_avail,
> +       .write_raw =3D adxl380_write_raw,
> +       .write_raw_get_fmt =3D adxl380_write_raw_get_fmt,
> +       .read_event_config =3D adxl380_read_event_config,
> +       .write_event_config =3D adxl380_write_event_config,
> +       .read_event_value =3D adxl380_read_event_value,
> +       .write_event_value =3D adxl380_write_event_value,
> +       .event_attrs =3D &adxl380_event_attribute_group,
> +       .debugfs_reg_access =3D &adxl380_reg_access,
> +       .hwfifo_set_watermark =3D adxl380_set_watermark,
> +};
> +
> +static const struct iio_event_spec adxl380_events[] =3D {
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_RISING,
> +               .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |
> +                                      BIT(IIO_EV_INFO_VALUE) |
> +                                      BIT(IIO_EV_INFO_PERIOD),
> +       },
> +       {
> +               .type =3D IIO_EV_TYPE_THRESH,
> +               .dir =3D IIO_EV_DIR_FALLING,
> +               .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |
> +                                      BIT(IIO_EV_INFO_VALUE) |
> +                                      BIT(IIO_EV_INFO_PERIOD),
> +       },
> +       {
> +               .type =3D IIO_EV_TYPE_GESTURE,
> +               .dir =3D IIO_EV_DIR_SINGLETAP,
> +               .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +               .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE) |
> +                                      BIT(IIO_EV_INFO_RESET_TIMEOUT),
> +       },
> +       {
> +               .type =3D IIO_EV_TYPE_GESTURE,
> +               .dir =3D IIO_EV_DIR_DOUBLETAP,
> +               .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +               .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE) |
> +                                      BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> +                                      BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> +       },
> +};
> +
> +#define ADXL380_ACCEL_CHANNEL(index, reg, axis) {                      \
> +       .type =3D IIO_ACCEL,                                             =
 \
> +       .address =3D reg,                                                =
 \
> +       .modified =3D 1,                                                 =
 \
> +       .channel2 =3D IIO_MOD_##axis,                                    =
 \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |                 =
 \
> +                             BIT(IIO_CHAN_INFO_CALIBBIAS),             \
> +       .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),       =
 \
> +       .info_mask_shared_by_all_available =3D                           =
 \
> +               BIT(IIO_CHAN_INFO_SAMP_FREQ),                           \
> +       .info_mask_shared_by_type =3D                                    =
 \
> +               BIT(IIO_CHAN_INFO_SCALE) |                              \
> +               BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |      \
> +               BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),      \
> +       .info_mask_shared_by_type_available =3D                          =
 \
> +               BIT(IIO_CHAN_INFO_SCALE) |                              \
> +               BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |      \
> +               BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),      \
> +       .scan_index =3D index,                                           =
 \
> +       .scan_type =3D {                                                 =
 \
> +               .sign =3D 's',                                           =
 \
> +               .realbits =3D 16,                                        =
 \
> +               .storagebits =3D 16,                                     =
 \
> +               .endianness =3D IIO_BE,                                  =
 \
> +       },                                                              \
> +       .event_spec =3D adxl380_events,                                  =
 \
> +       .num_event_specs =3D ARRAY_SIZE(adxl380_events)                  =
 \
> +}
> +
> +static const struct iio_chan_spec adxl380_channels[] =3D {
> +       ADXL380_ACCEL_CHANNEL(0, ADXL380_X_DATA_H_REG, X),
> +       ADXL380_ACCEL_CHANNEL(1, ADXL380_Y_DATA_H_REG, Y),
> +       ADXL380_ACCEL_CHANNEL(2, ADXL380_Z_DATA_H_REG, Z),
> +       {
> +               .type =3D IIO_TEMP,
> +               .address =3D ADXL380_T_DATA_H_REG,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +                                     BIT(IIO_CHAN_INFO_SCALE) |
> +                                     BIT(IIO_CHAN_INFO_OFFSET),
> +               .scan_index =3D 3,
> +               .scan_type =3D {
> +                       .sign =3D 's',
> +                       .realbits =3D 12,
> +                       .storagebits =3D 16,
> +                       .shift =3D 4,
> +                       .endianness =3D IIO_BE,
> +               },
> +       },
> +};
> +
> +static int adxl380_config_irq(struct iio_dev *indio_dev)
> +{
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +       unsigned long irq_flag;
> +       struct irq_data *desc;
> +       u32 irq_type;
> +       u8 polarity;
> +       int ret;
> +
> +       desc =3D irq_get_irq_data(st->irq);
> +       if (!desc)
> +               return dev_err_probe(st->dev, -EINVAL, "Could not find IR=
Q %d\n", st->irq);
> +
> +       irq_type =3D irqd_get_trigger_type(desc);
> +       if (irq_type =3D=3D IRQ_TYPE_LEVEL_HIGH) {
> +               polarity =3D 0;
> +               irq_flag =3D IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
> +       } else if (irq_type =3D=3D IRQ_TYPE_LEVEL_LOW) {
> +               polarity =3D 1;
> +               irq_flag =3D IRQF_TRIGGER_LOW | IRQF_ONESHOT;
> +       } else {
> +               return dev_err_probe(st->dev, -EINVAL,
> +                                    "Invalid interrupt 0x%x. Only level =
interrupts supported\n",
> +                                    irq_type);
> +       }
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_INT0_REG,
> +                                ADXL380_INT0_POL_MSK,
> +                                FIELD_PREP(ADXL380_INT0_POL_MSK, polarit=
y));
> +       if (ret)
> +               return ret;
> +
> +       return devm_request_threaded_irq(st->dev, st->irq, NULL,
> +                                        adxl380_irq_handler, irq_flag,
> +                                        indio_dev->name, indio_dev);
> +}
> +
> +static int adxl380_setup(struct iio_dev *indio_dev)
> +{
> +       unsigned int reg_val;
> +       u16 part_id, chip_id;
> +       int ret, i;
> +       struct adxl380_state *st =3D iio_priv(indio_dev);
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_DEVID_AD_REG, &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       if (reg_val !=3D ADXL380_DEVID_AD_VAL)
> +               dev_warn(st->dev, "Unknown chip id %x\n", reg_val);
> +
> +       ret =3D regmap_bulk_read(st->regmap, ADLX380_PART_ID_REG,
> +                              &st->transf_buf, 2);
> +       if (ret)
> +               return ret;
> +
> +       part_id =3D get_unaligned_be16(st->transf_buf);
> +       part_id >>=3D 4;
> +
> +       if (part_id !=3D ADXL380_ID_VAL)
> +               dev_warn(st->dev, "Unknown part id %x\n", part_id);
> +
> +       ret =3D regmap_read(st->regmap, ADXL380_MISC_0_REG, &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       /* Bit to differentiate between ADXL380/382. */
> +       if (reg_val & ADXL380_XL382_MSK)
> +               chip_id =3D ADXL382_ID_VAL;
> +       else
> +               chip_id =3D ADXL380_ID_VAL;
> +
> +       if (chip_id !=3D st->chip_info->chip_id)
> +               dev_warn(st->dev, "Unknown chip id %x\n", chip_id);
> +
> +       ret =3D regmap_write(st->regmap, ADXL380_RESET_REG, ADXL380_RESET=
_CODE);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * A latency of approximately 0.5 ms is required after soft reset=
.
> +        * Stated in the register REG_RESET description.
> +        */
> +       fsleep(500);
> +
> +       for (i =3D 0; i < indio_dev->num_channels; i++) {
> +               ret =3D regmap_update_bits(st->regmap, ADXL380_DIG_EN_REG=
,
> +                                        ADXL380_CHAN_EN_MSK(i),
> +                                        1 << (4 + i));
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0_REG,
> +                                ADXL380_FIFO_MODE_MSK,
> +                                FIELD_PREP(ADXL380_FIFO_MODE_MSK, ADXL38=
0_FIFO_STREAMED));
> +       if (ret)
> +               return ret;
> +
> +       /* Select all 3 axis for act/inact detection. */
> +       ret =3D regmap_update_bits(st->regmap, ADXL380_SNSR_AXIS_EN_REG,
> +                                ADXL380_ACT_INACT_AXIS_EN_MSK,
> +                                FIELD_PREP(ADXL380_ACT_INACT_AXIS_EN_MSK=
,
> +                                           ADXL380_ACT_INACT_AXIS_EN_MSK=
));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_config_irq(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_fill_lpf_tbl(st);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D adxl380_fill_hpf_tbl(st);
> +       if (ret)
> +               return ret;
> +
> +       return adxl380_set_measure_en(st, true);
> +}
> +
> +int adxl380_probe(struct device *dev, struct regmap *regmap,
> +                 const struct adxl380_chip_info *chip_info)
> +{
> +       struct iio_dev *indio_dev;
> +       struct adxl380_state *st;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st =3D iio_priv(indio_dev);
> +
> +       st->dev =3D dev;
> +       st->regmap =3D regmap;
> +       st->chip_info =3D chip_info;
> +
> +       mutex_init(&st->lock);
> +
> +       indio_dev->channels =3D adxl380_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(adxl380_channels);
> +       indio_dev->name =3D chip_info->name;
> +       indio_dev->info =3D &adxl380_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +       ret =3D devm_regulator_get_enable(dev, "vddio");
> +       if (ret)
> +               return dev_err_probe(st->dev, ret,
> +                                    "Failed to get vddio regulator\n");
> +
> +       ret =3D devm_regulator_get_enable(st->dev, "vsupply");
> +       if (ret)
> +               return dev_err_probe(st->dev, ret,
> +                                    "Failed to get vsupply regulator\n")=
;
> +
> +       st->irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT0");
> +       if (st->irq > 0) {
> +               st->int_map[0] =3D ADXL380_INT0_MAP0_REG;
> +               st->int_map[1] =3D ADXL380_INT0_MAP1_REG;
> +       } else {
> +               st->irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1"=
);
> +               if (st->irq > 0)
> +                       return dev_err_probe(dev, -ENODEV,
> +                                            "no interrupt name specified=
");
> +               st->int_map[0] =3D ADXL380_INT1_MAP0_REG;
> +               st->int_map[1] =3D ADXL380_INT1_MAP1_REG;
> +       }

Would it make sense fo this interrupt-register setup to go into
"adxl380_config_irq()"?

> +
> +       ret =3D adxl380_setup(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
> +                                             &adxl380_buffer_ops,
> +                                             adxl380_fifo_attributes);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(adxl380_probe, IIO_ADXL380);
> +
> +MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer driver")=
;
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/accel/adxl380.h b/drivers/iio/accel/adxl380.h
> new file mode 100644
> index 000000000000..a683625d897a
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * ADXL380 3-Axis Digital Accelerometer
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#ifndef _ADXL380_H_
> +#define _ADXL380_H_
> +
> +struct adxl380_chip_info {
> +       const char *name;
> +       const int scale_tbl[3][2];
> +       const int samp_freq_tbl[3];
> +       const int temp_offset;
> +       const u16 chip_id;
> +};
> +
> +extern const struct adxl380_chip_info adxl380_chip_info;
> +extern const struct adxl380_chip_info adxl382_chip_info;
> +
> +int adxl380_probe(struct device *dev, struct regmap *regmap,
> +                 const struct adxl380_chip_info *chip_info);
> +bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg);
> +
> +#endif /* _ADXL380_H_ */
> diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_=
i2c.c
> new file mode 100644
> index 000000000000..1dc1e77be815
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380_i2c.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL380 3-Axis Digital Accelerometer I2C driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "adxl380.h"
> +
> +static const struct regmap_config adxl380_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .readable_noinc_reg =3D adxl380_readable_noinc_reg,
> +};
> +
> +static int adxl380_i2c_probe(struct i2c_client *client)
> +{
> +       struct regmap *regmap;
> +       const struct adxl380_chip_info *chip_data;
> +
> +       chip_data =3D i2c_get_match_data(client);
> +
> +       regmap =3D devm_regmap_init_i2c(client, &adxl380_regmap_config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       return adxl380_probe(&client->dev, regmap, chip_data);
> +}
> +
> +static const struct i2c_device_id adxl380_i2c_id[] =3D {
> +       { "adxl380", (kernel_ulong_t)&adxl380_chip_info },
> +       { "adxl382", (kernel_ulong_t)&adxl382_chip_info },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
> +
> +static const struct of_device_id adxl380_of_match[] =3D {
> +       { .compatible =3D "adi,adxl380", .data =3D &adxl380_chip_info },
> +       { .compatible =3D "adi,adxl382", .data =3D &adxl382_chip_info },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, adxl380_of_match);
> +
> +static struct i2c_driver adxl380_i2c_driver =3D {
> +       .driver =3D {
> +               .name =3D "adxl380_i2c",
> +               .of_match_table =3D adxl380_of_match,
> +       },
> +       .probe =3D adxl380_i2c_probe,
> +       .id_table =3D adxl380_i2c_id,
> +};
> +
> +module_i2c_driver(adxl380_i2c_driver);
> +
> +MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer I2C driv=
er");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_ADXL380);
> diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_=
spi.c
> new file mode 100644
> index 000000000000..e7b5778cb6cf
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380_spi.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL380 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "adxl380.h"
> +
> +static const struct regmap_config adxl380_spi_regmap_config =3D {
> +       .reg_bits =3D 7,
> +       .pad_bits =3D 1,
> +       .val_bits =3D 8,
> +       .read_flag_mask =3D BIT(0),
> +       .readable_noinc_reg =3D adxl380_readable_noinc_reg,
> +};
> +
> +static int adxl380_spi_probe(struct spi_device *spi)
> +{
> +       const struct adxl380_chip_info *chip_data;
> +       struct regmap *regmap;
> +
> +       chip_data =3D spi_get_device_match_data(spi);
> +
> +       regmap =3D devm_regmap_init_spi(spi, &adxl380_spi_regmap_config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       return adxl380_probe(&spi->dev, regmap, chip_data);
> +}
> +
> +static const struct spi_device_id adxl380_spi_id[] =3D {
> +       { "adxl380", (kernel_ulong_t)&adxl380_chip_info },
> +       { "adxl382", (kernel_ulong_t)&adxl382_chip_info },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, adxl380_spi_id);
> +
> +static const struct of_device_id adxl380_of_match[] =3D {
> +       { .compatible =3D "adi,adxl380", .data =3D &adxl380_chip_info },
> +       { .compatible =3D "adi,adxl382", .data =3D &adxl382_chip_info },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, adxl380_of_match);
> +
> +static struct spi_driver adxl380_spi_driver =3D {
> +       .driver =3D {
> +               .name =3D "adxl380_spi",
> +               .of_match_table =3D adxl380_of_match,
> +       },
> +       .probe =3D adxl380_spi_probe,
> +       .id_table =3D adxl380_spi_id,
> +};
> +
> +module_spi_driver(adxl380_spi_driver);
> +
> +MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer SPI driv=
er");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_ADXL380);
> --
> 2.45.2
>
>

