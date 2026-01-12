Return-Path: <linux-iio+bounces-27658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C4D1535E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29EB03009D4C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC73314B8;
	Mon, 12 Jan 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkN23cxg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283F326D65;
	Mon, 12 Jan 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249580; cv=none; b=AN36kl8gMoEkeRhbzT62EmoEqBPO23fzdDINCG4Rb3pg8j5F4McTPgYNQE0o/N3de7Q6X5b5ei5myXoRoNc2JK59rRSbqor7ZI9nL3+1Sh04DvuodZDwpOkr4NQOLvO3nNEpCZbHdm63Tg9T9p3f/mIdbs0yQoNccRR+H/RBYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249580; c=relaxed/simple;
	bh=0TXaD9ggM6lSqpbdsxFru3JcCz3t5Kb0Y319VoyuXdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvMP+NlcbTxNyeWY7io9FsGum1sq8UW1KfO7mRu8dTsI8SFtygeDug2Ym0Ow02sSqRAJoAwmx+CodOOdg6hmmSpt73IWS4koZHQIO2gdD3KAdbkywrSfc0mSfZlFzXfbxcY/u6zh1n0mwHUyDGDLZ0kCcX8EhivkFGCczYmRsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkN23cxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E66AC116D0;
	Mon, 12 Jan 2026 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768249580;
	bh=0TXaD9ggM6lSqpbdsxFru3JcCz3t5Kb0Y319VoyuXdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pkN23cxgJD3krVrp54XESQFcTt3UfbZuNtfMqeMEhdOhBkMuazwoUKrtXod23yIA1
	 DCxnOCpT3G0fjRaMkD+T+iLW5yOsBMvzAwOseRV+jTLBRWgOKxkVrj/EKDSBumcgLw
	 +fpHuuAQvxNkUDuxjD5bgY8t0+OPGFvMCZuvGBuSuXbCBkOWqHf+7mLEqc/q4HdQZR
	 AZTreqmJD2wE3LXv/Mb5m34O/EsqIqF+N9+3/8pZd5+o2qiYj2Y3si8MMjzlmXO7xx
	 f5/+lkbp3/1Xxl4rYf91ZHnb8STe8jSLXJJHVE0Vj5jeck+ARFjBDNZZuL/l0/lW4+
	 wzaFSk/Bhf6OA==
Date: Mon, 12 Jan 2026 20:26:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jan.sun97@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: dac: Add MAX22007 DAC driver support
Message-ID: <20260112202610.350223da@jic23-huawei>
In-Reply-To: <20260108-max22007-dev-v2-2-2506c738784f@analog.com>
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
	<20260108-max22007-dev-v2-2-2506c738784f@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 13:58:24 +0100
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for the MAX22007, a 4-channel 12-bit DAC that drives
> voltage or current output on each channel.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
> new file mode 100644
> index 000000000000..19557c008554
> --- /dev/null
> +++ b/drivers/iio/dac/max22007.c
> @@ -0,0 +1,507 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * max22007.c - MAX22007 DAC driver
> + *
> + * Driver for Analog Devices MAX22007 Digital to Analog Converter.
> + *
> + * Copyright (c) 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/crc8.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

Hi.

I decided to use your driver (well v1 actually but comments still apply)
to mess around with https://github.com/masoncl/review-prompts (I'm trying to see
if it is worth the effort!) and I queried if the includes were correct.
(rather than running IWYU directly). 

It correctly noted:

The driver has 2 missing includes and 1 unnecessary include:

  // Should ADD:
  #include <linux/kstrtox.h>    // for kstrtobool()
  #include <linux/sysfs.h>      // for sysfs_emit()

  // Should REMOVE:
  #include <linux/unaligned.h>  // not used

Now I keep mean to start running IWYU against commits at time
of merge but it's enough of a pain that I don't do it when just
reviewing.

Interestingly, claude argued itself out of reporting a bug around the reset
in v1 (which is now fixed)

For fun I asked it what smatch would have reported... See below.


> +static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
> +			     void *val, size_t val_size)
> +{
> +	struct max22007_state *st = context;
> +	u8 reg_byte = *(u8 *)reg;
> +	u8 calculated_crc, received_crc;
> +	u8 crc_data[3];
> +	u8 rx_buf[4];
> +	int ret;
> +
> +	if (reg_size != 1)
One from claude that I think is sensible, if not a bug.
Should sanity check val_size as well.

> +		return -EINVAL;
> +
> +	ret = spi_write_then_read(st->spi, &reg_byte, 1, rx_buf,
> +				  val_size + MAX22007_CRC_OVERHEAD);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	crc_data[0] = reg_byte;
> +	crc_data[1] = rx_buf[0];
> +	crc_data[2] = rx_buf[1];
> +
> +	calculated_crc = crc8(max22007_crc8_table, crc_data, 3, 0x00);
> +	received_crc = rx_buf[val_size];
> +
> +	if (calculated_crc != received_crc) {
> +		dev_err(&st->spi->dev, "CRC mismatch on read register %02x\n", reg_byte);
> +		return -EIO;
> +	}
> +
> +	memcpy(val, rx_buf, val_size);
> +
> +	return 0;
> +}
> +
> +static int max22007_spi_write(void *context, const void *data, size_t count)
> +{
> +	struct max22007_state *st = context;
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +	};
Similarly claude reported a false positive here but it seems sensible to
cover it:  Check the size of count is <= ARRAY_SIZE(st->tx_buf) - 1;

> +
> +	memset(st->tx_buf, 0, sizeof(st->tx_buf));
> +
> +	xfer.len = count + MAX22007_CRC_OVERHEAD;
> +
> +	memcpy(st->tx_buf, data, count);
> +	st->tx_buf[count] = crc8(max22007_crc8_table, st->tx_buf,
> +				 sizeof(st->tx_buf) - 1, 0x00);
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}

...

> +
> +static int max22007_write_channel_data(struct max22007_state *state,
> +				       unsigned int channel, unsigned int data)
Another one Claude raised that I think is worth cleaning up though not technically
a bug.  This is passed int val at the caller as the data parameter here.
I'd keep that as an int and then add a check on it being positive below.

Wrap around means any negative would end up as a big positive and fail the test
below (I think anyway) but we can make the check more obvious!

> +{
> +	unsigned int reg_val;
> +
> +	if (data > MAX22007_DAC_MAX_RAW)
> +		return -EINVAL;
> +
> +	reg_val = FIELD_PREP(MAX22007_DAC_DATA_MASK, data);
> +
> +	return regmap_write(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), reg_val);
> +}
>

