Return-Path: <linux-iio+bounces-5178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A4A8CC345
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF61C22EC6
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714315AF6;
	Wed, 22 May 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ7wb+mr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F358F6D;
	Wed, 22 May 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388540; cv=none; b=JiqrNYho9LA7Zt0obHlYymHIAcrnHTMMmOaSEEyxtrWjRwk7EuCkBMIfujsq9FhX4Jao7IuaDAezXe8iUTv9ZNVh91WUDpU4vW9Nprz//fAdhgyf/uN4ZXLHHDHg+1vuH/kzJSsZ7LFgaAmIe9hE4WBxhVhxKXYp/cNY2DcQ0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388540; c=relaxed/simple;
	bh=1ZEG+iiAbko/VkigBF/Y1eLMSqNZ/zORuryWmHOtqRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIC4vYbgfFsWQ7OtKPmu1LHrNnfIMyDLLy44Rq6nROUS8FvzSBOxK1gnwLA4Pf3gX7u6OINkjoY7iFJAqrmcRiFczQK0ugzDuPdsxwzOMZdfcbuCtGkXrGTpVD93UulRjAuc05JvbklyBnDm9DJigxaAw9vdlpCgme98pMJ3dyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ7wb+mr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so8706115e9.3;
        Wed, 22 May 2024 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716388537; x=1716993337; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=acj3WAWpBSD7glsyNzOuc4SFRscSXQ2DzG+TU0NYEIs=;
        b=VZ7wb+mrL0yxtjplZ2c4nNCt7pY0yXdGuDezhjH6+5kyXWnWdOp7OPaqeNY8b7nEgp
         XI6bHK2qOszQhK3WShoAeYahnzdufNKLtKsHwJWOyjqcw1ReahGb7J+Lb47J/jcs6RWn
         s9Z34X/Tve20OwHGAxm4n3TqjANhmSuWGbgNKxbT5sRuKDGneEb39CupinSyzDaKJeHt
         OZzNbVdGuygWS3TRjaUT0x2MRZaVTcX8DqSZTAw71YKqmMcPYQN+NeL3q6AMRUlpRyHv
         /swYORXSArJwMYrHQOMl4PqUVC6t3ZdEx8itJ1QDZIyyyADk6lBct+1iU2LwhKwIdW3z
         M6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716388537; x=1716993337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acj3WAWpBSD7glsyNzOuc4SFRscSXQ2DzG+TU0NYEIs=;
        b=fF6233T91VO5w5OEswpHCiy30MA0Wz1zY/zb243lBt/od194/l9pS4TA3l/CRAVkuM
         OU/vkZ3zP5iMuRwQbJ6j4i9mEM+I70z3gmjy/4eRlELyF2A1AzUSEmJGlbOiEkeZaQLN
         Pu6csLO8IF8HCgPhYXAXxXqa5IlV0BQrcCZv0t2TO3qfqCDdYUWXK9Q1LyrGmtRJ1yW+
         XIPBF1fxnkssOUqUqycA7uHoSG4x2jn+XeOl4WAGMy0emhpveRrQKqToFApBzZJ4udy+
         rIU3YP5NQZmaiD3gzKNHQ7YWfU+zevHxX+ULXHrQOQgPF3Gblwg9q7P0gdX1xLEeg+Mg
         UcgA==
X-Forwarded-Encrypted: i=1; AJvYcCWrjRmOKTVGDcOVBSl76UUi2u+ZAaCSlxYZKBSVfsn+5UkP6nqYs6pxPkY1yQmyR1F7jMGJdCDQ/syvHnxOeNrAJIomXkxTf/Wo7UkvSuXAaxUDbIe2l4qSU4mGvv20B1MVF6lMNBdt
X-Gm-Message-State: AOJu0YxPBw6BTptBRYHffahGVmegeuS9jslKI7u13vkFIXBoBcMS8gGX
	XsjZRblY9W00VKl9MiITCbNiFc/JH32Jca6WB6wJbrHVL7Te+11p
X-Google-Smtp-Source: AGHT+IEZw72E8y2f3IwsPRxWdP5TsgueUI89PMMm6NDIV9pH9xszpfRPIfUObWL3rUKnkl0jU4zMAw==
X-Received: by 2002:a05:600c:4704:b0:41c:258:9b70 with SMTP id 5b1f17b1804b1-420fd354cadmr17151415e9.28.1716388536390;
        Wed, 22 May 2024 07:35:36 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe518a8fasm475404685e9.33.2024.05.22.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:35:36 -0700 (PDT)
Message-ID: <9c19faf6ee186f144a705f458da83ea25f7a3a34.camel@gmail.com>
Subject: Re: [PATCH] drivers: iio: adc: add support for ad777x family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: ranechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Marius Cristea <marius.cristea@microchip.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Maksim Kiselev
 <bigunclemax@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Liam Beguin <liambeguin@gmail.com>,
  linux-kernel@vger.kernel.org
Date: Wed, 22 May 2024 16:35:34 +0200
In-Reply-To: <20240522120005.18197-1-ramona.nechita@analog.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 14:59 +0300, ranechita wrote:
> Added support for ad7770,ad7771,ad7779 ADCs. The
> data is streamed only on the spi-mode, without
> using the data lines.
>=20
> Signed-off-by: ranechita <ramona.nechita@analog.com>
> ---
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 11 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7779.c | 1182 +++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 1194 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad7779.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0d9282fa67f5..3e42cbc365d7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -206,6 +206,17 @@ config AD7768_1
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will be
> =C2=A0	=C2=A0 called ad7768-1.
> =C2=A0
> +config AD7779
> +	tristate "Analog Devices AD7779 ADC driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD7779 SPI
> +	=C2=A0 analog to digital converter (ADC)
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll be
> +	=C2=A0 called ad7779.
> +
> =C2=A0config AD7780
> =C2=A0	tristate "Analog Devices AD7780 and similar ADCs driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b3c434722364..e25997e926bb 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> =C2=A0obj-$(CONFIG_AD7606) +=3D ad7606.o
> =C2=A0obj-$(CONFIG_AD7766) +=3D ad7766.o
> =C2=A0obj-$(CONFIG_AD7768_1) +=3D ad7768-1.o
> +obj-$(CONFIG_AD7779) +=3D ad7779.o
> =C2=A0obj-$(CONFIG_AD7780) +=3D ad7780.o
> =C2=A0obj-$(CONFIG_AD7791) +=3D ad7791.o
> =C2=A0obj-$(CONFIG_AD7793) +=3D ad7793.o
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> new file mode 100644
> index 000000000000..d2c1b14464ff
> --- /dev/null
> +++ b/drivers/iio/adc/ad7779.c
> @@ -0,0 +1,1182 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD777X ADC
> + *
> + * Copyright 2023 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "cf_axi_adc.h"
> +
> +#define AD777X_SPI_READ_CMD			BIT(7)
> +
> +#define AD777X_DISABLE_SD			BIT(7)
> +
> +#define AD777X_REG_CH_DISABLE			0x08
> +#define AD777X_REG_CH_SYNC_OFFSET(ch)		(0x09 + (ch))
> +#define AD777X_REG_CH_CONFIG(ch)		(0x00 + (ch))
> +#define AD777X_REG_GENERAL_USER_CONFIG_1	0x11
> +#define AD777X_REG_GENERAL_USER_CONFIG_2	0x12
> +#define AD777X_REG_GENERAL_USER_CONFIG_3	0x13
> +#define AD777X_REG_DOUT_FORMAT			0x14
> +#define AD777X_REG_ADC_MUX_CONFIG		0x15
> +#define AD777X_REG_GPIO_CONFIG			0x17
> +#define AD777X_REG_BUFFER_CONFIG_1		0x19
> +#define AD777X_REG_GLOBAL_MUX_CONFIG		0x16
> +#define AD777X_REG_BUFFER_CONFIG_2		0x1A
> +#define AD777X_REG_GPIO_DATA			0x18
> +#define AD777X_REG_CH_OFFSET_UPPER_BYTE(ch)	(0x1C + (ch) * 6)
> +#define AD777X_REG_CH_OFFSET_LOWER_BYTE(ch)	(0x1E + (ch) * 6)
> +#define AD777X_REG_CH_GAIN_UPPER_BYTE(ch)	(0x1F + (ch) * 6)
> +#define AD777X_REG_CH_OFFSET_MID_BYTE(ch)	(0x1D + (ch) * 6)
> +#define AD777X_REG_CH_GAIN_MID_BYTE(ch)		(0x20 + (ch) * 6)
> +#define AD777X_REG_CH_ERR_REG(ch)		(0x4C + (ch))
> +#define AD777X_REG_CH0_1_SAT_ERR		0x54
> +#define AD777X_REG_CH_GAIN_LOWER_BYTE(ch)	(0x21 + (ch) * 6)
> +#define AD777X_REG_CH2_3_SAT_ERR		0x55
> +#define AD777X_REG_CH4_5_SAT_ERR		0x56
> +#define AD777X_REG_CH6_7_SAT_ERR		0x57
> +#define AD777X_REG_CHX_ERR_REG_EN		0x58
> +#define AD777X_REG_GEN_ERR_REG_1		0x59
> +#define AD777X_REG_GEN_ERR_REG_1_EN		0x5A
> +#define AD777X_REG_GEN_ERR_REG_2		0x5B
> +#define AD777X_REG_GEN_ERR_REG_2_EN		0x5C
> +#define AD777X_REG_STATUS_REG_1			0x5D
> +#define AD777X_REG_STATUS_REG_2			0x5E
> +#define AD777X_REG_STATUS_REG_3			0x5F
> +#define AD777X_REG_SRC_N_MSB			0x60
> +#define AD777X_REG_SRC_N_LSB			0x61
> +#define AD777X_REG_SRC_IF_MSB			0x62
> +#define AD777X_REG_SRC_IF_LSB			0x63
> +#define AD777X_REG_SRC_UPDATE			0x64
> +
> +#define AD777X_FILTER_MSK			BIT(6)
> +#define AD777X_MOD_POWERMODE_MSK		BIT(6)
> +#define AD777X_MOD_PDB_REFOUT_MSK		BIT(4)
> +#define AD777X_MOD_SPI_EN_MSK			BIT(4)
> +
> +/* AD777X_REG_DOUT_FORMAT */
> +#define AD777X_DOUT_FORMAT_MSK			GENMASK(7, 6)
> +#define AD777X_DOUT_HEADER_FORMAT		BIT(5)
> +#define AD777X_DCLK_CLK_DIV_MSK			GENMASK(3, 1)
> +
> +#define AD777X_REFMUX_CTRL_MSK			GENMASK(7, 6)
> +#define AD777X_SPI_CRC_EN_MSK			BIT(0)
> +
> +#define AD777X_MAXCLK_LOWPOWER			4096000
> +#define AD777X_NUM_CHANNELS			8
> +#define AD777X_RESET_BUF_SIZE			8
> +
> +#define AD777X_LOWPOWER_DIV			512
> +#define AD777X_HIGHPOWER_DIV			2048
> +
> +#define AD777X_SINC3_MAXFREQ			16000
> +#define AD777X_SINC5_MAXFREQ			128000
> +
> +#define AD777X_DEFAULT_SAMPLING_FREQ		8000
> +#define AD777X_DEFAULT_SAMPLING_2LINE		4000
> +#define AD777X_DEFAULT_SAMPLING_1LINE		2000
> +
> +#define AD777X_SPIMODE_MAX_SAMP_FREQ		16000
> +
> +/* AXI CONTROL REGS VALUES FOR DATA LINES */
> +#define AXI_CTRL_4_LINES			0x400
> +#define AXI_CTRL_2_LINES			0x200
> +#define AXI_CTRL_1_LINE				0x100
> +
> +#define DEC3					1000
> +#define DEC6					1000000
> +
> +#define GAIN_REL				0x555555
> +#define AD777X_FREQ_MSB_MSK			GENMASK(15, 8)
> +#define AD777X_FREQ_LSB_MSK			GENMASK(7, 0)
> +#define AD777X_UPPER				GENMASK(23, 16)
> +#define AD777X_MID				GENMASK(15, 8)
> +#define AD777X_LOWER				GENMASK(7, 0)
> +
> +#define AD777X_CRC8_POLY			0x07
> +DECLARE_CRC8_TABLE(ad777x_crc8_table);
> +
> +enum ad777x_data_lines {
> +	AD777x_4LINES,
> +	AD777x_2LINES,
> +	AD777x_1LINE,
> +};
> +
> +enum ad777x_filter {
> +	AD777X_SINC3,
> +	AD777X_SINC5,
> +};
> +
> +enum ad777x_variant {
> +	ad7770,
> +	ad7771,
> +	ad7779,
> +};
> +
> +enum ad777x_power_mode {
> +	AD777X_LOW_POWER,
> +	AD777X_HIGH_POWER,
> +};
> +
> +struct ad777x_chip_info {
> +	const char *name;
> +};
> +
> +struct ad777x_state {
> +	struct spi_device		*spi;
> +	const struct ad777x_chip_info	*chip_info;
> +	struct clk			*mclk;
> +	struct regulator		*vref;
> +	unsigned int			sampling_freq;
> +	enum ad777x_power_mode		power_mode;
> +	enum ad777x_data_lines		data_lines;
> +	enum ad777x_filter		filter_enabled;
> +	unsigned int			active_ch;
> +	unsigned int			spidata_mode;
> +	unsigned int			crc_enabled;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8			reg_rx_buf[3] ____cacheline_aligned;
> +	u8			reg_tx_buf[3];
> +	u8			spidata_rx[32];
> +	u8			spidata_tx[32];
> +	u8			reset_buf[8];
> +};
> +
> +static const char * const ad777x_filter_type[] =3D {
> +	[AD777X_SINC3] =3D "sinc3_filter",
> +	[AD777X_SINC5] =3D "sinc5_filter",
> +};
> +
> +static const char * const ad777x_data_lines_modes[] =3D {
> +	[AD777x_4LINES] =3D "4_data_lines",
> +	[AD777x_2LINES] =3D "2_data_lines",
> +	[AD777x_1LINE]=C2=A0 =3D "1_data_line",
> +};
> +
> +static bool ad777x_has_axi_adc(struct device *dev)
> +{
> +	return device_property_present(dev, "spibus-connected");
> +}
> +
> +static struct ad777x_state *ad777x_get_data(struct iio_dev *indio_dev)
> +{
> +	struct axiadc_converter *conv;
> +
> +	if (ad777x_has_axi_adc(&indio_dev->dev)) {
> +		conv =3D iio_device_get_drvdata(indio_dev);
> +		return conv->phy;
> +	}
> +
> +	return iio_priv(indio_dev);
> +}
> +

Hi Ramona,

Is this even compiling? This is definitely not code to be upstreamed since =
it relies
on the our out-of-tree/legacy driver for the adi-axi-adc. You need to conve=
rt this to
use the IIO backend framework (adding new interfaces if needed).

- Nuno S=C3=A1

