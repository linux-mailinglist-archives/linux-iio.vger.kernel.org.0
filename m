Return-Path: <linux-iio+bounces-26860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD1CAADC4
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 530D13009845
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825992D876A;
	Sat,  6 Dec 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnIL+l05"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2A3B8D6F;
	Sat,  6 Dec 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765054457; cv=none; b=Gq2lqGhvXQG5/haMniZc/kGcsrN0Df3C8Cb48ZnYmnFNHk0k9kGK2YcCOzp5GmGugPnuwv15NqKrAbydM/H4P00oa/Pm/l+xm4TMr3G8Xa/DpjCvzLE5EU8hXbj6PdDaD1nDhZZEp7M+y4RLeeVuX6gDmzymEoQ5lIRpE/S464U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765054457; c=relaxed/simple;
	bh=8snUSMoc54cd3klpXlNpnzVn4sa1ke114YaanTzQbB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5/ZL8Ze1X/0XiEawmhmXpKrGEYb6fNE8U5o0K3Z2MtDIgd1xHkytBtX/JrnU4HWREbgKihXfhizNwMpkjwmL5qDqXRFvBGGs5QtrVIx2eqVizDfORla1GTFpGFk0aP0P2u4iADE0jNON1HTBCjBvUHe7xm+UeYbpbaBn3uD+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnIL+l05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68674C4CEF5;
	Sat,  6 Dec 2025 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765054457;
	bh=8snUSMoc54cd3klpXlNpnzVn4sa1ke114YaanTzQbB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LnIL+l05iU12ob86TG00w/P3ReNuQw1efKJLanCzb5ZGr/ynqzhMisTR2GGcZ6wN2
	 AiCV9v1sutdKcxmymZ1Lgldqqoz2vsIECjZ5/84WAk9appmM6gltsesFNA+NcOVJ1H
	 2TthEaT7YTZYfAgcjAHEc5Sd0D9pKf1Mhc1b+jxwkH8xHshkEerMDXZIG/wAePi2Cm
	 GYAP0I0lAqbuwegYnzG0oPeeIUdJ7HSwfzNZD44iNZab3CJMdhN6//IT2MMX8FqZGo
	 K8GAdDpvUW/CqEl5zpDW+K5h+NNce+ftS6rBVi31RO5gyAiMpcxQqxzOrUxS52PsDJ
	 1hi47mK1mGtdw==
Date: Sat, 6 Dec 2025 20:54:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <20251206205407.6ba41d76@jic23-huawei>
In-Reply-To: <20251204-honeywell_abp2_driver-v3-2-ad3275bad35e@subdimension.ro>
References: <20251204-honeywell_abp2_driver-v3-0-ad3275bad35e@subdimension.ro>
	<20251204-honeywell_abp2_driver-v3-2-ad3275bad35e@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 17:12:56 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds driver for digital Honeywell ABP2 series of board mount
> pressure and temperature sensors.
> 
> This driver covers 113 different pressure ranges and units on
> both i2c and SPI buses.
> 
> The communication protocol involves sending two simple commands
> to the sensor and there is no register access or a memory map.
> For this reason the regmap API was not used.
> 
> The i2c address is hardcoded and depends on the part number.
> 
> Optional end of conversion interrupt control is present on the
> i2c variants of the chips.
> The EOC can also be defined for the SPI variants if a non-ABP2
> but compatible chip is to be driven.
> 
> Tested on two sensors (ABP2MRRT001PDSA3 and ABP2DANT001BA2A3).
> 
> Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Hi Petre

Nice clean driver.

A few things inline.  I managed to delete my first review so the comments are a terse
memory of what I had in that!  End of review sessions and dinner time for me
so sorry for the brevity!

Jonathan

> diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
> new file mode 100644
> index 000000000000..80623043bd55
> --- /dev/null
> +++ b/drivers/iio/pressure/abp2030pa.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Honeywell ABP2 series pressure sensor driver
> + *
> + * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>

I'm not immediately spotting use of this but I might well be missing it!

> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

This is rarely used in a modern IIO driver. Why do you need it here?

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>
> +
> +static irqreturn_t abp2_trigger_handler(int irq, void *private)
> +{
> +	int ret;
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct abp2_data *data = iio_priv(indio_dev);
> +
> +	ret = abp2_get_measurement(data);
> +	if (ret < 0)
> +		goto out_notify_done;
> +
> +	data->scan.chan[0] = get_unaligned_be24(&data->rx_buf[1]);
> +	data->scan.chan[1] = get_unaligned_be24(&data->rx_buf[4]);
Turn on just the second channel and run the test in tools/iio/ for buffered
reads.

You'll see data from the first channel not the one userspace asked for.

Set available_scan_masks = { 0x3, 0 };
allows the IIO core to know this is what is happening and shuffle the
data as necessary for you.

> +
> +	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> +				    iio_get_time_ns(indio_dev));
> +
> +out_notify_done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
> +{
> +	int ret;
> +	struct abp2_data *data;
> +	struct iio_dev *indio_dev;
> +	const char *triplet;
> +	s32 tmp;
> +	s64 odelta, pdelta;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	data->ops = ops;
> +	data->irq = irq;
> +
> +	init_completion(&data->completion);
> +
> +	indio_dev->name = "abp2030pa";
> +	indio_dev->info = &abp2_info;
> +	indio_dev->channels = abp2_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(abp2_channels);
Put back setting direct mode (see comment I made in reply to that earlier thread)



> diff --git a/drivers/iio/pressure/abp2030pa.h b/drivers/iio/pressure/abp2030pa.h
> new file mode 100644
> index 000000000000..2beb7306812d
> --- /dev/null
> +++ b/drivers/iio/pressure/abp2030pa.h

> +/**
> + * struct abp2_data
> + * @dev: current device structure
> + * @ops: pointers for bus specific read and write functions
> + * @pmin: minimal pressure in pascal
> + * @pmax: maximal pressure in pascal
> + * @outmin: minimum raw pressure in counts (based on transfer function)
> + * @outmax: maximum raw pressure in counts (based on transfer function)
> + * @function: transfer function
> + * @p_scale: pressure scale
> + * @p_scale_dec: pressure scale, decimal number
> + * @p_offset: pressure offset
> + * @irq: end of conversion - applies only to the i2c sensor
> + * @completion: handshake from irq to read
> + * @scan: channel values for buffered mode
> + * @tx_buf: transmit buffer used during the SPI communication
> + * @rx_buf: raw data provided by sensor
> + */
> +struct abp2_data {
> +	struct device *dev;
> +	const struct abp2_ops *ops;
> +	s32 pmin;
> +	s32 pmax;
> +	u32 outmin;
> +	u32 outmax;
> +	enum abp2_func_id function;
> +	int p_scale;
> +	int p_scale_dec;
> +	int p_offset;
> +	int irq;
> +	struct completion completion;
> +	struct {
> +		u32 chan[2];
> +		aligned_s64 timestamp;
> +	} scan;
> +	u8 tx_buf[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);

See reply to earlier version (I've been away so lots of catching up to do!)

> +};

> diff --git a/drivers/iio/pressure/abp2030pa_spi.c b/drivers/iio/pressure/abp2030pa_spi.c
> new file mode 100644
> index 000000000000..924fcb2fb690
> --- /dev/null
> +++ b/drivers/iio/pressure/abp2030pa_spi.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Honeywell ABP2 series pressure sensor driver
> + *
> + * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include "abp2030pa.h"
> +
> +static int abp2_spi_xfer(struct abp2_data *data, u8 cmd, u8 nbytes)
> +{
> +	struct spi_device *spi = to_spi_device(data->dev);
> +	struct spi_transfer xfer;

struct spi_transfer xfer = { };

otherwise you are at the mercy of random data on the stack.

> +
> +	if (nbytes > ABP2_MEASUREMENT_RD_SIZE)
> +		return -EOVERFLOW;
> +
> +	data->tx_buf[0] = cmd;
> +	xfer.tx_buf = data->tx_buf;
> +	xfer.rx_buf = data->rx_buf;
> +	xfer.len = nbytes;
> +
> +	return spi_sync_transfer(spi, &xfer, 1);
> +}

