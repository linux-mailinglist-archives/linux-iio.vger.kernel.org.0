Return-Path: <linux-iio+bounces-18944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD6AA6267
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58DF1BC2481
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB2218E97;
	Thu,  1 May 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mZuNoCPP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AF2153FB
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121055; cv=none; b=TrUzD9A6bFvZ05KrQdWmvHqdZhimcOZgH8TFTLaGm8kx5d/B+yzRrhYMAfXNu3TLyKJmX6O2dT7lo2WaEmPJ/EC+Ec/z7E1i5llmIfRHJIzLyFnIXKOhmM9asO8Zp6DAiFhN6U1I9brfeDlwYbBjOsmUwfUg1ZlbmHoQHGIDuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121055; c=relaxed/simple;
	bh=MM+UrEEjqz+NrsstsJtdsAGd6ziIcPN05fJJ2PWqHJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJFhWDO5MkGx+jR9TsAxnCRINQByN91NLk4l09qlnne5foz7kfn/pqKdsB6duuTBl+hjr3CrUViqz0tBuQSzjC3abUdTKb3MmeupzklcT/I3uat++YeEfedfYYOSJ1gJjvSSDbExNIXGRCS5VJc5yjsD3FMpHlLeEX7CJbhF+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mZuNoCPP; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fbc00143d6so970580b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746121052; x=1746725852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irUKWtP2D61Kl8u554d0UJW47H6YlvzGEZcZ4664eOs=;
        b=mZuNoCPP0sbn3micT0KpI7+g3oyeDjlPNS5Fg1hI3n6L2t3VQwWaZM+4YWte3XVp8U
         aWW2dklttTRRbG8uj1Mo9Lbd049BQc1F2FgJ/v+ZVHcwgI5yfpWwIBo2hljfrm6Nrnoh
         RpLpzgudJK8tVsweIioGs6nJmq4xsj3TBuwjxHH78gYYJ2pSKwX5Nr2fQfJbxAq7FAUi
         YXLJ0r9ItKbeKgveiJD0CnQkB7POVq/DOeuRaH4AB8de+GLrMcABu5iz1QOnqjTkEMSl
         /CQYUVk6FR5q2/C+oXabf5m6F0BMLFMaDdrmMNMwFsmR0L07cB+ZUFt0JLKj1SEHzQ7Q
         Dqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746121052; x=1746725852;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irUKWtP2D61Kl8u554d0UJW47H6YlvzGEZcZ4664eOs=;
        b=OgMhxvvCK6egs5aN6IbjvAS5jyfGJ0qwiUjW7J7PrXTlGrS/yYzJttRLqccLDMfqmw
         5bTstOrmlCtF0LsgPz+jgd3hYCHpgTREgBt3hMSr7lMS/77sUN7GPr6CB2qfSXQGBKhJ
         BI4xDh+Nmzk8LOYW6lGpQ9W/g2LijhW84JSxnX+TEN7MCdtJAiU9jg5P/Vwr6SonCBKH
         3+FQW7G7ANoyYnn7HEvuud2fzcFrhf0BkEdN//pALUE8QAfmy2MCh2Kd2YcD23v7+Cy1
         22wjmaDyZdrjKaW9wHuAAhy+kHHwNDVJUwvtOBb0DaP548J4gTA0G+m6ICycxMpr+nZT
         5Giw==
X-Forwarded-Encrypted: i=1; AJvYcCXAGP7DyNPc7/MEnZCn5Q6tXCNS4aMNAYtgx8jyOXh2TOrSG/Epn1H41fGSOBQgkYcC5vcdYNN9m7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zaDPiMElcFQcZZB8xd1kciDrukG7KJHAobJnIUsTHGExbDwU
	P653YtnCadLUw3uYWyJLNSNbIiOEF6BciK29o74lDGAiFC9v2w0BsfNWVlEbM7M=
X-Gm-Gg: ASbGncspDXJ47e1oGh2uW/mu9u+BkFuEOlpKK/diZYDeDFCVjaiNsdCDKnYLJTV2lzC
	1Q4o7JRflvf4ML5zBepDZSafoctr8wvBjCg+h9K0gSV4Er9RgWYi1WiVmP+1G29TizKNrmPzn3x
	wUOaRCUw4rbxnXAvLAO3pZCKkfB4Do0wvbDhD5NoQljei8pUof4Fpx5xopwYei+Pqul2eSsY243
	2MgZHaQ7AuMZ0PnztXldRwxPDX5poiSrz3ZdlaScv15dlXReLEMhjG4tPxSEiEQaxlrA26jYdoZ
	auJVThdGJlBEQ6nAaOOBXKtnV72nb73EuYCFP9NFoEiup8I2rc+PvYz5xzvd009TMNupnSTfj9a
	2OwmOyhpcVKQy+hBJWg==
X-Google-Smtp-Source: AGHT+IGR+dGuObVDak2t27VZBQEAE0+huLD7gktjN1shtRcOgGkAj1/A0/eNlW781GEshuaebVEQ4A==
X-Received: by 2002:a05:6808:2287:b0:3fa:3922:5fbe with SMTP id 5614622812f47-40341161d02mr103775b6e.5.1746121051911;
        Thu, 01 May 2025 10:37:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7cab6cdsm194276eaf.6.2025.05.01.10.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 10:37:31 -0700 (PDT)
Message-ID: <01cb0333-1ca7-46b3-9f32-5e81b8a53537@baylibre.com>
Date: Thu, 1 May 2025 12:37:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] iio: adc: ti-ads1262.c: add initial driver for TI
 ADS1262 ADC
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
 <20250501100043.325423-2-sayyad.abid16@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250501100043.325423-2-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 5:00 AM, Sayyad Abid wrote:
> Add the core driver file `ti-ads1262.c` for the TI ADS1262 ADC.
> This initial version implements basic IIO functionality for device
> probe via SPI and reading raw voltage samples from input channels.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1262.c | 438 +++++++++++++++++++++++++++++++++++
>  1 file changed, 438 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1262.c
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> new file mode 100644
> index 000000000000..ef34c528ffeb
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Texas Instruments ADS1662 32-bit ADC
> + *
> + * Datasheet: https://www.ti.com/product/ADS1262
> + */
> +
> +#include <linux/kernel.h>

This header includes too much, please use more specific headers.

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/delay.h>

Alphabetical order is preferred.

> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +/* Commands */
> +#define ADS1262_CMD_RESET		0x06
> +#define ADS1262_CMD_START1		0x08
> +#define ADS1262_CMD_STOP1		0x0A
> +#define ADS1262_CMD_RDATA1		0x12
> +#define ADS1262_CMD_RREG		0x20
> +#define ADS1262_CMD_WREG		0x40
> +
> +/* Registers */
> +#define ADS1262_REG_ID			0x00
> +#define ADS1262_REG_POWER		0x01
> +#define ADS1262_REG_INTERFACE		0x02
> +#define ADS1262_REG_MODE0		0x03
> +#define ADS1262_REG_MODE1		0x04
> +#define ADS1262_REG_MODE2		0x05
> +#define ADS1262_REG_INPMUX		0x06
> +
> +/* Configurations */
> +#define ADS1262_INTREF_ENABLE		0x01
> +#define ADS1262_MODE0_ONE_SHOT		0x40
> +#define ADS1262_MODE2_PGA_EN		0x00
> +#define ADS1262_MODE2_PGA_BYPASS	BIT(7)
> +
> +/* Masks */
> +#define ADS1262_MASK_MODE2_DR		GENMASK(4, 0)
> +
> +/* ADS1262_SPECS */
> +#define ADS1262_MAX_CHANNELS		11
> +#define ADS1262_BITS_PER_SAMPLE		32
> +#define ADS1262_CLK_RATE_HZ		7372800
> +#define ADS1262_CLOCKS_TO_USECS(x)	\
> +	(DIV_ROUND_UP((x) * MICROHZ_PER_HZ, ADS1262_CLK_RATE_HZ))

This is only for the internal clock, but external clock is also possible so
better to just do this inline rather than a macro.

> +#define ADS1262_VOLTAGE_INT_REF_uV	2500000
> +#define ADS1262_TEMP_SENSITIVITY_uV_per_C 420
> +
> +#define ADS1262_SETTLE_TIME_USECS	10000
> +
> +/* The Read/Write commands require 4 tCLK to encode and decode, for speeds
> + * 2x the clock rate, these commands would require extra time between the
> + * command byte and the data. A simple way to tacke this issue is by
> + * limiting the SPI bus transfer speed while accessing registers.
> + */
> +#define ADS1262_SPI_BUS_SPEED_SLOW	ADS1262_CLK_RATE_HZ
> +
> +/* For reading and writing we need a buffer of size 3bytes*/
> +#define ADS1262_SPI_CMD_BUFFER_SIZE	3
> +
> +/* Read data buffer size for
> + * 1 status byte - 4 byte data (32 bit) - 1 byte checksum / CRC
> + */
> +#define ADS1262_SPI_RDATA_BUFFER_SIZE	6
> +
> +#define MILLI				1000

There is already linux/units.h for this.

> +
> +/**
> + * struct ads1262_private - ADS1262 ADC private data structure
> + * @spi: SPI device structure
> + * @reset_gpio: GPIO descriptor for reset pin
> + * @prev_channel: Previously selected channel for MUX configuration
> + * @cmd_buffer: Buffer for SPI command transfers
> + * @rx_buffer: Buffer for SPI data reception
> + */
> +struct ads1262_private {
> +	struct spi_device *spi;
> +	struct gpio_desc *reset_gpio;
> +	u8 prev_channel;
> +	u8 cmd_buffer[ADS1262_SPI_CMD_BUFFER_SIZE];
> +	u8 rx_buffer[ADS1262_SPI_RDATA_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);

cmd_buffer is also used with SPI, so __aligned(IIO_DMA_MINALIGN); needs to go
there instead.

> +};
> +
> +#define ADS1262_CHAN(index)						\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = index,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> +		.storagebits = 32,					\
> +		.endianness = IIO_CPU					\
> +	},								\
> +}
> +
> +#define ADS1262_DIFF_CHAN(index, pos_channel, neg_channel)		\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = pos_channel,						\
> +	.channel2 = neg_channel,					\
> +	.differential = 1,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> +		.storagebits = 32,					\
> +		.endianness = IIO_CPU					\
> +	},								\
> +}
> +
> +#define ADS1262_TEMP_CHAN(index)					\
> +{									\
> +	.type = IIO_TEMP,						\
> +	.indexed = 1,							\
> +	.channel = index,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			     BIT(IIO_CHAN_INFO_SCALE) |			\
> +			     BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> +		.storagebits = 32,					\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +static const struct iio_chan_spec ads1262_channels[] = {
> +	/* Single ended channels*/
> +	ADS1262_CHAN(0),
> +	ADS1262_CHAN(1),
> +	ADS1262_CHAN(2),
> +	ADS1262_CHAN(3),
> +	ADS1262_CHAN(4),
> +	ADS1262_CHAN(5),
> +	ADS1262_CHAN(6),
> +	ADS1262_CHAN(7),
> +	ADS1262_CHAN(8),
> +	ADS1262_CHAN(9),

Hard-coding the channels here means there would be no point in allowing the
devicetree to specify the channels. However, since the same pins can be used
for many other purposes, I don't think hard-coding channels here makes sense
and we should always dynamically create the channel specs for channels connected
to AIN pins based on the devicetree.

> +	/* The channel at index 10 is AINCOM, which is the common ground
> +	 * of the ADC. It is not a valid channel for the user.
> +	 */

If this bit about AINCOM is true, then the DT bindings need to reflect that.
The datasheet makes it looks like any other input though.



> +
> +	/* Temperature and Monitor channels */
> +	ADS1262_TEMP_CHAN(11),	/* TEMP SENSOR */
> +	ADS1262_CHAN(12),	/* AVDD MON */
> +	ADS1262_CHAN(13),	/* DVDD MON */
> +	ADS1262_CHAN(14),	/* TDAC TEST */

It will be fine to always add these diagnotic channels though without having to
specify them in the devicetree.

> +	/* Differential channels */
> +	ADS1262_DIFF_CHAN(15, 0, 1),	/* AIN0 - AIN1 */
> +	ADS1262_DIFF_CHAN(16, 2, 3),	/* AIN2 - AIN3 */
> +	ADS1262_DIFF_CHAN(17, 4, 5),	/* AIN4 - AIN5 */
> +	ADS1262_DIFF_CHAN(18, 6, 7),	/* AIN6 - AIN7 */
> +	ADS1262_DIFF_CHAN(19, 8, 9),	/* AIN8 - AIN9 */
> +};
> +
> +static int ads1262_write_cmd(struct ads1262_private *priv, u8 command)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = priv->cmd_buffer,
> +		.rx_buf = priv->rx_buffer,
> +		.len = ADS1262_SPI_RDATA_BUFFER_SIZE,
> +		.speed_hz = ADS1262_CLK_RATE_HZ,
> +	};
> +
> +	priv->cmd_buffer[0] = command;
> +
> +	return spi_sync_transfer(priv->spi, &xfer, 1);
> +}
> +
> +static int ads1262_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ads1262_private *priv = context;
> +
> +	priv->cmd_buffer[0] = ADS1262_CMD_WREG | reg;
> +	priv->cmd_buffer[1] = 0;
> +	priv->cmd_buffer[2] = val;
> +
> +	return spi_write(priv->spi, &priv->cmd_buffer[0], 3);
> +}
> +
> +static int ads1262_reg_read(void *context, unsigned int reg)
> +{
> +	struct ads1262_private *priv = context;
> +	struct spi_transfer reg_read_xfer = {
> +		.tx_buf = priv->cmd_buffer,
> +		.rx_buf = priv->cmd_buffer,
> +		.len = 3,
> +		.speed_hz = ADS1262_CLK_RATE_HZ,
> +	};
> +	int ret;
> +
> +	priv->cmd_buffer[0] = ADS1262_CMD_RREG | reg;
> +	priv->cmd_buffer[1] = 0;
> +	priv->cmd_buffer[2] = 0;
> +
> +	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Why not use regmap? You will still custom read/write functions similar to these
because of needing the lower SCLK rate, but it will give you a bunch of other
nice features for free.

> +
> +static int ads1262_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads1262_private *priv = iio_priv(indio_dev);
> +
> +	if (priv->reset_gpio) {
> +		gpiod_set_value(priv->reset_gpio, 0);
> +		usleep_range(200, 300);

Use fsleep(). Also, could make this clear that it is 4 tCLK cycles (the hard-
coded value would have to be changed if external clock support was added).

> +		gpiod_set_value(priv->reset_gpio, 1);

The DT bindings will take care of active low, so this looks backwards. Also
st->reset_gpio is never assigned, so this is dead code.

> +	} else {
> +		return ads1262_write_cmd(priv, ADS1262_CMD_RESET);
> +	}
> +	return 0;
> +}
> +
> +static int ads1262_init(struct iio_dev *indio_dev)
> +{
> +	struct ads1262_private *priv = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	ret = ads1262_reset(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* 10 milliseconds settling time for the ADC to stabilize */
> +	fsleep(ADS1262_SETTLE_TIME_USECS);

Woud make more sense to have this inside the reset function.

> +
> +	/* Clearing the RESET bit in the power register to detect ADC reset */
> +	ret = ads1262_reg_write(priv, ADS1262_REG_POWER, ADS1262_INTREF_ENABLE);

This is where regmap_clear_bits() would come in handy. Then you don't have to
care about other defaults like INTREF being 1.

> +	if (ret)
> +		return ret;
> +
> +	/* Setting the ADC to one-shot conversion mode */
> +	ret = ads1262_reg_write(priv, ADS1262_REG_MODE0, ADS1262_MODE0_ONE_SHOT);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_reg_read(priv, ADS1262_REG_INPMUX);
> +	if (ret)
> +		return ret;
> +
> +	priv->prev_channel = priv->cmd_buffer[2];

Regmap has features to give all of the default values of registers and mark
which registers are volatile. Then you don't have to manage stuff like this
yourself.

> +
> +	return ret;
> +}
> +
> +static int ads1262_get_samp_freq(struct ads1262_private *priv, int *val)
> +{
> +	unsigned long samp_freq;
> +	int ret;
> +
> +	ret = ads1262_reg_read(priv, ADS1262_REG_MODE2);
> +	if (ret)
> +		return ret;
> +
> +	samp_freq = priv->cmd_buffer[2];
> +
> +	*val = (samp_freq & ADS1262_MASK_MODE2_DR);

Use FIELD_GET().

> +
> +	return IIO_VAL_INT;
> +}
> +
> +/**
> + * ads1262_read - Read a single sample from the ADC
> + * @priv: Pointer to the ADS1262 private data structure
> + * @chan: Pointer to the IIO channel specification
> + * @val: Pointer to store the read value
> + *
> + * Reads a single sample from the specified ADC channel. For differential
> + * channels, it sets up the MUX with both channels. For single-ended channels,
> + * it uses the channel number and AINCOM (0x0A).
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int ads1262_read(struct ads1262_private *priv,
> +			struct iio_chan_spec const *chan, int *val)
> +{
> +	u8 mux_value;
> +	int ret;
> +
> +	if (chan->differential) {
> +		mux_value = (chan->channel << 4) | chan->channel2;
> +	} else {
> +		/* For single-ended channels, use the channel number on one end
> +		 * and AINCOM (0x0A) on the other end
> +		 */
> +		mux_value = (chan->channel << 4) | 0x0A;
> +	}
> +
> +	if (mux_value != priv->prev_channel) {
> +		ret = ads1262_write_cmd(priv, ADS1262_CMD_STOP1);
> +		if (ret)
> +			return ret;
> +
> +		ret = ads1262_reg_write(priv, ADS1262_REG_INPMUX, mux_value);
> +		if (ret)
> +			return ret;
> +
> +		priv->prev_channel = mux_value;
> +	}
> +
> +	ret = ads1262_write_cmd(priv, ADS1262_CMD_START1);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);

fsleep().

Also, doesn't this depend on the sample rate (and filter type, but that isn't
implemented yet).

Another alternative would be to use the /DRDY interrupt instead so that we
don't have to try to guess the right amout of time to wait for the conversion
to complete.

> +
> +	*val = sign_extend64(get_unaligned_be32(priv->rx_buffer + 1),

val is not 64 bit. Since ADS1262_BITS_PER_SAMPLE == 32, we don't need to sign-
extend.

> +			     ADS1262_BITS_PER_SAMPLE - 1);
> +
> +	return 0;
> +}
> +
> +static int ads1262_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads1262_private *spi = iio_priv(indio_dev);
> +	s64 temp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ads1262_read(spi, chan, val);

Need to check return value.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = ADS1262_VOLTAGE_INT_REF_uV;
> +			*val2 = chan->scan_type.realbits;

Do we need realbits - 1 since this is signed?

> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_TEMP:
> +			temp = (s64)ADS1262_VOLTAGE_INT_REF_uV * MILLI;
> +			temp /= ADS1262_TEMP_SENSITIVITY_uV_per_C;
> +			*val = temp;
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ads1262_get_samp_freq(spi, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ads1262_info = {
> +	.read_raw = ads1262_read_raw,
> +};
> +
> +static void ads1262_stop(void *ptr)
> +{
> +	struct ads1262_private *adc = ptr;
> +
> +	ads1262_write_cmd(adc, ADS1262_CMD_STOP1);
> +}
> +
> +static int ads1262_probe(struct spi_device *spi)
> +{
> +	struct ads1262_private *adc;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +
> +	spi->mode = SPI_MODE_1;

We can leave this out and just rely on the devicetree to set it correctly.

> +	spi->max_speed_hz = ADS1262_SPI_BUS_SPEED_SLOW;

I found out the hard way, this isn't a good idea. You did it right by having
the register read/write functions specify the speed per xfer. Don't set the
speed here so that reading sample data can use the actual max rate from the
devicetree.

> +	spi_set_drvdata(spi, indio_dev);

There isn't spi_get_drvdata() so this isn't needed.

> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1262_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1262_channels);
> +	indio_dev->info = &ads1262_info;
> +
> +	ret = ads1262_reg_read(adc, ADS1262_REG_ID);
> +	if (ret)
> +		return ret;
> +
> +	if (adc->rx_buffer[2] != ADS1262_REG_ID)
> +		dev_err_probe(&spi->dev, -EINVAL, "Wrong device ID 0x%x\n",
> +			      adc->rx_buffer[2]);

Proably don't want to error here. It tends to cause problems if there is ever
a new compatibile chip with different ID.

> +
> +	ret = devm_add_action_or_reset(&spi->dev, ads1262_stop, adc);

We are using single pulse mode, so it doesn't seem like we would need to do
this at driver exit.

> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_init(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static struct spi_device_id ads1262_id_table[] = {
> +	{ "ads1262" },
> +	{}

	{ }

> +};
> +MODULE_DEVICE_TABLE(spi, ads1262_id_table);
> +
> +static const struct of_device_id ads1262_of_match[] = {
> +	{ .compatible = "ti,ads1262" },
> +	{},

	{ }

(It's the style we use in the IIO subsystem)

> +};
> +MODULE_DEVICE_TABLE(of, ads1262_of_match);
> +
> +static struct spi_driver ads1262_driver = {
> +	.driver = {
> +		.name = "ads1262",
> +		.of_match_table = ads1262_of_match,
> +	},
> +	.probe = ads1262_probe,
> +	.id_table = ads1262_id_table,
> +};
> +module_spi_driver(ads1262_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sayyad Abid <sayyad.abid16@gmail.com>");
> +MODULE_DESCRIPTION("TI ADS1262 ADC");


