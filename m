Return-Path: <linux-iio+bounces-25987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7FC3CAC4
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B3FA4E41CB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E3284665;
	Thu,  6 Nov 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BEczX6MQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF026B75B
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448252; cv=none; b=slffHn4NmHJJb9uJ5L8i632skIgPOhCTJmCEa5cRvlj6zR+CYm5ykiTcDn/N8ZMILwcacYEqQwr0B79PdFBl0O9xqBr4Q20M9DBtFbGgD9ez7Xp5DQ4q4aSvlbFo8qAQviSZubVb3beqfM+mMNM/47nQfLrwQI2lJrJ7/+AB8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448252; c=relaxed/simple;
	bh=UxI515hK70Mh2FvdMOyXfCdzhOLlb7GWLgr+G4tmYfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxAxkrAiPg4kSFE8cGgxEf2xvz04HcZxzhQl4SxicLqDqCfBZb5WKFfuEHN5MH+oad7DSsicM/FMFnqUq5eqmIn4ImKVl9fRddgXqr36UxDVCqerKyOoPRY5Bx0ePNSskPmYpRqrIXc4ql9X4LezJdyJltItgAphS/DYfJcCKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BEczX6MQ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656bf426c81so583515eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762448249; x=1763053049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EMELjj+bjUiWeG3JaqK5gLcQCsmLkvwHXIrpyQe7VQ=;
        b=BEczX6MQZxhb2S1YZ76ZMu2RNrfmBKzhdWPSF06xReNjYsiCiwgYPACXVCIo4FeP2D
         2c0ss+4pwJPgDrZm+rRNI5iUmxZqo3PVIj5zgKC3vqayij0RrENlqVS5rUgMO9c26ecr
         V13h9e0EQHzjLFZqNU8QCeEZe5bRYlhOvSjTojv11m7Jp9z/WjkpgJYij+h7eH+VjXoE
         eQa5rvH+RX/kd1B7YFDzfYOLOS+UF9qwClvE1dOxgnQrsvNA4XuyuhXgRPKXXy/GOcow
         o6wpuHal1o4tMCHlk1ATCzqqFkGcUuWXlTaOXpIl0BMz3tC+mycEdRClxATkXf6LVikW
         fhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448249; x=1763053049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EMELjj+bjUiWeG3JaqK5gLcQCsmLkvwHXIrpyQe7VQ=;
        b=wBQH/RZeoUH+cJtNlfMPm32aed6wtlHehNB0X6hVePCye7x04nghUdm8BUei5IsNqf
         gPaB5aRlY0cizIrxm1IutFjxH16WUWLVLKD70ZrQGucgoHTvI88JM4UcHOuOVyoUlBr+
         FWW7tZ5DnavjCZ21u10Kwek3XHGZi3pFhQAaPBi2b3WyfTpgBXCLnFcPt8T74CkK2FwT
         /9yxnv8n+E1bX6PsoOuefLVUA3nBNendQlJPgexrn1/CnkMv0NarYXhzZkm2k5Qr9ABX
         y8CVAOT0hQEBkPzjrPjbcXh7wn5tSxu2zNL4E1o7S/WDuIOznAII+af23SyWQvk0v1Mt
         ykQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWefD635PFsAq3NbLwSW56IDSQ/RTPFt3Z07Efy6ochZjp2ujjwLi5sWqkiT44EPWzeOpa7nr3yZpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNmjU9XUYHsEK0MOJ9QGg7Uia3Sym6yLfG2e2alyW52Q83EwM
	YHnikfNVOjlDBsI9as1qg1HorfNbFbT5Qs8M2CndmcyQ8btmSV35/lP8fPrtrJKkqAw=
X-Gm-Gg: ASbGnctLHe4xXVCvq1RNG+TZZzxJbncmlr+LEZXMui7+TPJN+sDnKkbrg+dk7ePxHD8
	buG04TtfZv2GKnQqHQxY/+1PtYy3HtMyFCdutDoANoCYob1W55yksVQT+NiFteWZ1SHsOjvdCfC
	Sg01KqcwbhiBkFqZ+EkcHLADsFzMbkyTcGpkMDbq2whCihTwJC3rPkWYxNRudDKtDoz+7N0KPF6
	Ksbwp8KkGizArmpQk+zp21FXEjMNI58itZuGGTkWxQuX63NBviSUftn2epgLe72Ai+reUPVnfAJ
	UX/YXPh2Db7k1SGigUXgEYw1n0suQbFdg0oWAEdI9pcGx+4jB7r7jpwBk6cncZ7ZizCUWQwsp+A
	fOG/u9omDglXnEvqxQVLK1QKN83fbwTIbnktLuK5d52RDITfWE4RENnt9V1DPCkIIv0MUwBdyo+
	Pl1Wc17RrWfzvQCaBslnoGJprEqTN2E/twlKklTe7BveOGLerWreTWiDqkn5Zh
X-Google-Smtp-Source: AGHT+IHzlR0HgKCTXqcdpQoc31zxWf5TD937J0hAbm3u4u+SCCRMsue1l7rnFqxUozkh0bMEpEoNyQ==
X-Received: by 2002:a05:6808:6f92:b0:438:273f:d09f with SMTP id 5614622812f47-4501475fe87mr189416b6e.5.1762448248844;
        Thu, 06 Nov 2025 08:57:28 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:149c:d223:50dd:7f45? ([2600:8803:e7e4:500:149c:d223:50dd:7f45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4500280856fsm985247b6e.24.2025.11.06.08.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:57:27 -0800 (PST)
Message-ID: <5c618c00-f7f1-4260-8970-7c493d50315e@baylibre.com>
Date: Thu, 6 Nov 2025 10:57:26 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: David Jander <david@protonic.nl>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20251105143814.1807444-1-o.rempel@pengutronix.de>
 <20251105143814.1807444-3-o.rempel@pengutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251105143814.1807444-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 8:38 AM, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
> 
> Highlights:
> - Supports 2/3/4/6/8-channel variants with per-channel RAW and SCALE.
> - Implements device-required full-duplex fixed-frame transfers.
> - Handles both input and output CRC; uses a non-reflected CCITT (0x1021)
>   implementation because the generic crc_ccitt helper is incompatible.
> 
> Note: Despite the almost identical name, this hardware is not
> compatible with the ADS131E0x series handled by
> drivers/iio/adc/ti-ads131e08.c.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/iio/adc/Kconfig        |  10 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads131m0x.c | 886 +++++++++++++++++++++++++++++++++
>  3 files changed, 897 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads131m0x.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..c17f8914358c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1691,6 +1691,16 @@ config TI_ADS131E08
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads131e08.
>  
> +config TI_ADS131M0X
> +	tristate "Texas Instruments ADS131M0x"
> +	depends on SPI && COMMON_CLK
> +	help
> +	  Say yes here to get support for Texas Instruments ADS131M02, ADS131M03,
> +	  ADS131M04, ADS131M06 and ADS131M08 chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads131m0x.
> +
>  config TI_ADS7138
>  	tristate "Texas Instruments ADS7128 and ADS7138 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d008f78dc010..c23dae3ddcc7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -147,6 +147,7 @@ obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
>  obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
> +obj-$(CONFIG_TI_ADS131M0X) += ti-ads131m0x.o

No x in the name please. As in my other review, I would make it ads131m02.

>  obj-$(CONFIG_TI_ADS7138) += ti-ads7138.o
>  obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
> diff --git a/drivers/iio/adc/ti-ads131m0x.c b/drivers/iio/adc/ti-ads131m0x.c
> new file mode 100644
> index 000000000000..d40aacc129ba
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads131m0x.c
> @@ -0,0 +1,886 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Texas Instruments ADS131M0x family ADC chips.
> + *
> + * Copyright (C) 2024 Protonic Holland
> + * Copyright (C) 2025 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + *
> + * Primary Datasheet Reference (used for citations):
> + * ADS131M08 8-Channel, Simultaneously-Sampling, 24-Bit, Delta-Sigma ADC
> + * Document SBAS950B, Revised February 2021
> + * https://www.ti.com/lit/ds/symlink/ads131m08.pdf
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +
> +/* Max channels supported by the largest variant in the family (ADS131M08) */
> +#define ADS131M_MAX_CHANNELS		8
> +
> +/* ADS131M08 tolerates up to 25 MHz SCLK.
> + */
> +#define ADS131M_MAX_SCLK_HZ		25000000

25 * MEGA, but this should rather be in the devicetree bindings
as spi-max-frequency.

> +
> +/* Section 6.7, t_REGACQ (min time after reset) is 5us */
> +#define ADS131M_RESET_DELAY_US		10
Why not make this 5 instead of 10?

> +
> +/*
> + * SPI Frame word count calculation.
> + * Frame = N channel words + 1 response word + 1 CRC word.
> + * Word size depends on WLENGTH bits in MODE register (Default 24-bit).
> + */
> +#define ADS131M_FRAME_WSIZE(nch)	(nch + 2)
> +/*
> + * SPI Frame byte size calculation.
> + * Assumes default word size of 24 bits (3 bytes).
> + */
> +#define ADS131M_FRAME_BSIZE(nch)	(ADS131M_FRAME_WSIZE(nch) * 3)

Would be easier to understand at the call site if we spell out
WORD_SIZE and BYTE_SIZE.

> +/*
> + * Index calculation for the start byte of channel 'x' data within the RX buffer.
> + * Assumes 24-bit words (3 bytes per word).
> + * The received frame starts with the response word (e.g., STATUS register
> + * content when NULL command was sent), followed by data for channels 0 to N-1,
> + * and finally the output CRC word.
> + * Response = index 0..2, Chan0 = index 3..5, Chan1 = index 6..8, ...
> + * Index for ChanX = 3 (response) + x * 3 (channel data size).
> + */
> +#define ADS131M_CHANNEL_INDEX(x)	(x * 3 + 3)
> +
> +#define ADS131M_CMD_NULL		0x0000
> +#define ADS131M_CMD_RESET		0x0011
> +
> +#define ADS131M_CMD_RREG(a, n) \
> +	(0xa000 | ((u16)(a & 0x1f) << 7) | (u16)(n & 0x7f))
> +#define ADS131M_CMD_WREG(a, n) \
> +	(0x6000 | ((u16)(a & 0x1f) << 7) | (u16)(n & 0x7f))
> +
> +/*  STATUS Register (0x01h) bit definitions */
> +#define ADS131M_STATUS_CRC_ERR		BIT(12) /* Input CRC Error */
> +
> +#define ADS131M_REG_MODE		0x02
> +#define ADS131M_MODE_RX_CRC_EN		BIT(12) /* Enable Input CRC */
> +#define ADS131M_MODE_CRC_TYPE_ANSI	BIT(11) /* 0=CCITT, 1=ANSI */
> +#define ADS131M_MODE_RESET_FLAG		BIT(10)
> +
> +struct ads131m_configuration {
> +	const struct iio_chan_spec	*channels;
> +	u8				num_channels;
> +	u16				reset_ack;
> +};
> +
> +enum ads131m_device_id {
> +	ADS131M08_ID,
> +	ADS131M06_ID,
> +	ADS131M04_ID,
> +	ADS131M03_ID,
> +	ADS131M02_ID,
> +};
> +
> +struct ads131m_priv {
> +	struct spi_device *spi;
> +	struct clk *clk;
> +	struct mutex lock;
> +	u8 num_channels;
> +	const struct ads131m_configuration *config;
> +	u8 tx_buffer[ADS131M_FRAME_BSIZE(ADS131M_MAX_CHANNELS)]
> +		__aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buffer[ADS131M_FRAME_BSIZE(ADS131M_MAX_CHANNELS)]
> +		__aligned(IIO_DMA_MINALIGN);

The second __aligned(IIO_DMA_MINALIGN) is not needed. And everything
below here needs to be move above the first __aligned(IIO_DMA_MINALIGN)
Othewise the items below can be corrupted.

> +	struct spi_transfer xfer[1];

Not much sense in an array with length one. Can drop [1].

> +	struct spi_message msg;
> +	unsigned int gain[ADS131M_MAX_CHANNELS];

It looks like this is never assigned (always all 0s). Maybe we should
save it for a later patch that implements variable gain?

> +};
> +
...

> +static int ads131m_check_status_crc_err(struct ads131m_priv *priv)
> +{
> +	int ret;
> +	u16 status;
> +
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "SPI error on STATUS read for CRC check\n");
> +		return ret;
> +	}
> +
> +	status = get_unaligned_be16(&priv->rx_buffer[0]);
> +	if (status & ADS131M_STATUS_CRC_ERR) {
> +		dev_err(&priv->spi->dev, "Previous input CRC error, STATUS=0x%04x\n",
> +			status);

Should this be rate-limited? If things get really bad, we could get an
error on every xfer which could flood the logs.

> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +

...

> +/**
> + * ads131m_rmw_reg - Reads, modifies, and writes a single register.

Any reason we couldn't turn the read/write into a regmap and avoid
implementing extras like this?

> + * @priv: Device private data structure.
> + * @reg: The 8-bit register address.
> + * @clear: Bitmask of bits to clear.
> + * @set: Bitmask of bits to set.
> + *
> + * This function performs an atomic read-modify-write operation on a register.
> + * It reads the register, applies the clear and set masks, and writes
> + * the new value back if it has changed.
> + *
> + * Context: This function handles its own mutex locking
> + *
> + * Return: 0 on success, or a negative error code.
> + */

...

> +static int ads131m_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
> +{
> +	struct ads131m_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ads131m_adc_read(priv, channel->channel, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale = (Vref / Gain) / 2^(Resolution - 1)
> +		 * Vref = 1.2V (1200mV) [DS, 8.3.4], Resolution = 24 bits
> +		 * LSB = (1.2V / Gain) / 2^23
> +		 *
> +		 * Using IIO_VAL_FRACTIONAL_LOG2, the unit is millivolts.
> +		 * Scale = val * 2^(-val2)
> +		 * Scale = 1200 * 2^-(23 + log2(Gain))

I would write it as vref_mv / 2^(23 + log2(gain)). The multiplication
by negative exponent is a bit subtile when we are talking about a
fractional value.

> +		 *
> +		 * priv->gain[] stores log2(Gain) (e.g., 0 for Gain=1).
> +		 */
> +		*val = 1200; /* 1.2Vref, in millivolts */
> +		*val2 = 23 + priv->gain[channel->channel];

s/gain/gain_log2/ for the variable name to make it obious
what kind of value it holds.

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +/**
> + * ads131m_hw_init - Initialize the ADC hardware.
> + * @priv: Device private data structure.
> + *
> + * This function performs the hardware-specific initialization sequence:
> + * 1. Enables the main clock.
> + * 2. Issues a software RESET command to clear FIFOs and defaults.
> + * 3. Configures the MODE register to clear RESET, set CCITT CRC,
> + * and enable Input CRC checking.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_hw_init(struct ads131m_priv *priv)
> +{
> +	struct spi_device *spi = priv->spi;
> +	u16 clear_mask, set_mask;
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&spi->dev, "clk enable failed: %d\n", ret);
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(&spi->dev, ads131m_clk_disable_unprepare,
> +				       priv->clk);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +

Would be trivial to implement optional gpio hardware reset here as well.

> +	/*
> +	 * Issue a software RESET to ensure device is in a known state.
> +	 * This clears the 2-deep FIFO and resets all registers to default.
> +	 */
> +	ret = ads131m_soft_reset(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The RESET command sets all registers to default, which means:
> +	 * 1. The RESET bit (Bit 10) in MODE is set to '1'.
> +	 * 2. The CRC_TYPE bit (Bit 11) in MODE is '0' (CCITT).
> +	 * 3. The RX_CRC_EN bit (Bit 12) in MODE is '0' (Disabled).
> +	 *
> +	 * We must:
> +	 * 1. Clear the RESET bit.
> +	 * 2. Enable Input CRC (RX_CRC_EN).
> +	 * 3. Explicitly clear the ANSI CRC bit (for certainty).
> +	 */
> +	clear_mask = ADS131M_MODE_CRC_TYPE_ANSI | ADS131M_MODE_RESET_FLAG;
> +	set_mask = ADS131M_MODE_RX_CRC_EN;
> +
> +	ret = ads131m_rmw_reg(priv, ADS131M_REG_MODE, clear_mask, set_mask);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to configure MODE register\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads131m_probe(struct spi_device *spi)
> +{
> +	const struct ads131m_configuration *config;
> +	struct iio_dev *indio_dev;
> +	struct ads131m_priv *priv;
> +	int ret;
> +
> +	spi->mode = SPI_MODE_1;
> +	spi->bits_per_word = 8;
> +
> +	if (!spi->max_speed_hz || spi->max_speed_hz > ADS131M_MAX_SCLK_HZ)
> +		spi->max_speed_hz = ADS131M_MAX_SCLK_HZ;
> +
> +	ret = spi_setup(spi);

As Jonathan mentioned, we should be able to avoid calling spi_setup()
here completly.

> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Error in spi setup\n");
> +		return ret;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->spi = spi;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads131m_info;
> +
> +	config = device_get_match_data(&spi->dev);
> +	if (!config) {
> +		const struct spi_device_id *id;
> +
> +		id = spi_get_device_id(spi);
> +		if (!id)
> +			return -ENODEV;
> +
> +		config = (const void *)id->driver_data;
> +	}
> +	priv->config = config;
> +
> +	indio_dev->channels = config->channels;
> +	indio_dev->num_channels = config->num_channels;
> +	priv->num_channels = config->num_channels;

We already have priv->config->num_channels, so this extra copy seems
unnecessary.

> +
> +	/* Get the external clock source connected to the CLKIN pin */
> +	priv->clk = devm_clk_get(&spi->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		ret = PTR_ERR(priv->clk);
> +		dev_err(&spi->dev, "clk get failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&priv->lock);
> +	/* Setup the reusable SPI message structure */
> +	ads131m_prepare_message(priv);
> +
> +	/*
> +	 * Perform all hardware-specific initialization.
> +	 */
> +	ret = ads131m_hw_init(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
...

