Return-Path: <linux-iio+bounces-8913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BB967173
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C621F22754
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316E17DFE4;
	Sat, 31 Aug 2024 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjZbPFU0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C651EF01;
	Sat, 31 Aug 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106412; cv=none; b=L83Qb96/3wRgSzpnIEET+i9lsUClLlkt/TeXYYrnxoXfkC/hO1GGaZFesOGRGtdqtK/GnAZyVSE3p3rbyjzLPpJaETht+m71Q33XyNwJjSIWhpcywxToJqFfbSOnfRWK45NB0lCAqtBZbtzzRSYsVPxOEFNAdwMifUJgECN36bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106412; c=relaxed/simple;
	bh=NQzHTIqKUVEIhDPUBjemGlNE3PItBmvUoufR9nDrBUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4LXze8YQ0unPD30eeLGlf0VEdJHs2bvwcmTIo4abVOwlEaP8TP1EmtFkA7V7D3wso5j8Z7ZR4+QlDPoInLATIea0XpWDPY9SIbBBOHFH6k6DtSQNdbc5ZNCGF6ka5CTXuojcB4ttR2mmniVyihajR63w8Ew81akycIs37Be4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjZbPFU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCFDC4CEC0;
	Sat, 31 Aug 2024 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725106412;
	bh=NQzHTIqKUVEIhDPUBjemGlNE3PItBmvUoufR9nDrBUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fjZbPFU0utoZdCT2JVXXE9h/Ix0BbJhnw43T7YbHcdysE2+DyweA4OonoxRorA73q
	 Tl5hE5OfzYIVvOw3SMbJm9OIrZXwPyJUIZtRq8+0ikXn3UqyVDXLYJPONPHje11DXl
	 N/rE6KdIQfnknUQPvHvWlklexwU6/TtdW3c9v/HybrE0hcC0xDp0esgpmS+ghziNPf
	 CjOvRwf0iR2fFVV5BDAs3rzv8zKlbvCXKLxGpYeP2BCEoL8g2rnZA+yuK6DUm5+d95
	 cC3gF5K//gS3Ir7Edb5dEfIj2pgq60K1j7kECJhbyYjyInq2a0WO9EXNNn667d/D0B
	 J3nfIdDjgiPAA==
Date: Sat, 31 Aug 2024 13:13:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 7/8] iio: dac: ad3552r: add axi platform driver
Message-ID: <20240831131322.494119f3@jic23-huawei>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-7-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-7-b6da6015327a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:32:05 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for ad3552r AXI DAC IP version.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Hi Angelo

To me this feels like the interface is much closer to SPI + SPI offload
than to a conventional IIO backend on the basis it carries the configuration
path as well.

Can we see if it can be fitted into that model?  You will need to define
a new bus type etc for it but should be fairly simple given constrained
setup (at least today!)

That will resolve a bunch of questions around the binding as well.

Jonathan

> diff --git a/drivers/iio/dac/ad3552r-axi.c b/drivers/iio/dac/ad3552r-axi.c
> new file mode 100644
> index 000000000000..98e5da08c973
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-axi.c
> @@ -0,0 +1,572 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD3552R
> + * Digital to Analog converter driver, AXI DAC backend version
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/backend.h>
> +#include <linux/of.h>

Why?  Probably want mod_devicetable.h

> +#include <linux/platform_device.h>
> +#include <linux/units.h>


> +static int ad3552r_axi_update_scan_mode(struct iio_dev *indio_dev,
> +					const unsigned long *active_scan_mask)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +
> +	st->active_scan_mask = *active_scan_mask;

We probably want another accessor for this, but for now that variable
can still be read from iio_dev->active_scan_mask so no need
for the copy here (and hence no need for this callback).
> +
> +	return 0;
> +}
> +
> +static int ad3552r_axi_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	struct iio_backend_data_fmt fmt = {
> +		.type = IIO_BACKEND_DATA_UNSIGNED
> +	};
> +	int loop_len, val, err;
> +
> +	/* Inform DAC chip to switch into DDR mode */
> +	err = axi3552r_qspi_update_reg_bits(st->back,
> +					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					    AD3552R_MASK_SPI_CONFIG_DDR,
> +					    AD3552R_MASK_SPI_CONFIG_DDR, 1);
> +	if (err)
> +		return err;
> +
> +	/* Inform DAC IP to go for DDR mode from now on */
> +	err = iio_backend_ddr_enable(st->back);
> +	if (err)
> +		goto exit_err;
> +
> +	switch (st->active_scan_mask) {
> +	case AD3552R_CH0_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
> +		break;
> +	case AD3552R_CH1_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	case AD3552R_CH0_CH1_ACTIVE:
> +		st->single_channel = false;
> +		loop_len = AD3552R_STREAM_4BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> +					&loop_len, 1);
> +	if (err)
> +		goto exit_err;
> +
> +	iio_backend_data_transfer_addr(st->back, val);
err = ?
> +	if (err)
> +		goto exit_err;
> +	/*
> +	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
> +	 * of the IP are in the design and they need to generate the signals
> +	 * synchronized.
> +	 *
> +	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
> +	 * but EXT_SYMC is anabled anyway.
> +	 */
> +
> +	if (st->synced_transfer == AD3552R_EXT_SYNC_ARM)
> +		err = iio_backend_ext_sync_enable(st->back);
> +	else
> +		err = iio_backend_ext_sync_disable(st->back);
> +	if (err)
> +		goto exit_err_sync;
> +
> +	err = iio_backend_data_format_set(st->back, 0, &fmt);
> +	if (err)
> +		goto exit_err;
> +
> +	err =  iio_backend_buffer_enable(st->back);
> +	if (!err)
> +		return 0;
Keep the good path inline as that's more idiomatic and what a reviewers
eyes expect to see.

	if (err)
		goto exit_err_sync;

	return 0;
> +
> +exit_err_sync:
> +	iio_backend_ext_sync_disable(st->back);
> +
> +exit_err:
> +	axi3552r_qspi_update_reg_bits(st->back,
> +				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				      AD3552R_MASK_SPI_CONFIG_DDR,
> +				      0, 1);
> +
> +	iio_backend_ddr_disable(st->back);
> +
> +	return err;
> +}
> +
> +static int ad3552r_axi_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	int err;
> +
> +	err = iio_backend_buffer_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	/* Inform DAC to set in DDR mode */

You set the DAC to ddr mode whilst disabling it? That seems backwards.

> +	err = axi3552r_qspi_update_reg_bits(st->back,
> +					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					    AD3552R_MASK_SPI_CONFIG_DDR,
> +					    0, 1);
> +	if (err)
> +		return err;
> +
> +	return iio_backend_ddr_disable(st->back);
> +}
> +

> +
> +static int ad3552r_axi_reset(struct ad3552r_axi_state *st)
> +{
> +	int err;
> +
> +	/* AXI reset performed by backend enable() */

This comment is confusing given it's in a function called
axi_reset and you don't do the backend enable() here.
So how is this resetting the AXI bus (or is that name
referring to the fpga IP?)

> +
> +	st->reset_gpio = devm_gpiod_get_optional(st->dev,
> +						 "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
> +
> +	if (st->reset_gpio) {
> +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> +		fsleep(10);
> +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> +	} else {
> +		err = axi3552r_qspi_update_reg_bits(st->back,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +					AD3552R_MASK_SOFTWARE_RESET,
> +					AD3552R_MASK_SOFTWARE_RESET, 1);
> +		if (err)
> +			return err;
> +	}
> +	msleep(100);
> +
> +	return 0;
> +}
> +
> +static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
> +{
> +	struct fwnode_handle *child __free(fwnode_handle) = NULL;
> +	u8 gs_p, gs_n;
> +	s16 goffs;
> +	u16 id, rfb, reg = 0, offset = 0;
Generally don't mix assignment and non assignment stuff on online.
Fine to have them all not assigned or all assigned, but a mix
tends to lead to people missing one in the middle that is
different.

	u16 id, rfb,
	u16 reg = 0, offset = 0;


> +	u32 val, range;
> +	int err;
> +
> +	err = ad3552r_axi_reset(st);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_ddr_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	val = AD3552R_SCRATCH_PAD_TEST_VAL1;
> +	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +					&val, 1);

as per earlier review, I'd pass an unsigned int instead of a void *
Then you can avoid the dance with a local variable.

> +	if (err)
> +		return err;
> +
> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL1) {
> +		dev_err(st->dev,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> +		return -EIO;
> +	}
> +
> +	val = AD3552R_SCRATCH_PAD_TEST_VAL2;
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_SCRATCH_PAD,
> +					&val, 1);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL2) {
> +		dev_err(st->dev,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> +		return -EIO;
> +	}
> +
> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	id = val;
> +	mdelay(100);

Document this delay as it's odd to need a gap whilst reading ID registers.

> +
> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	id |= val << 8;
> +	if (id != AD3552R_ID) {
> +		dev_err(st->dev, "Chip ID mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_ID, id);

Print an message only on this. We want to enable fallback dt compatibles for
future devices on old kernels, so we can't require a match on a WHOAMI type register.
We can put a message in the log though to give us a hint if that fallback
compatible is wrong.

> +		return -ENODEV;
> +	}
> +
> +	st->chip_id = id;

This is usually a bad sign.  It is much more extensible for a driver to at
this point 'pick' between a set of per device type structures that encode
all the difference between device variants.  So good to do that from
the start.  Lots of old drivers do it this way, but we've learnt over the years
that it becomes steadily more messy over time as a driver supports more and
more devices.

I guess the existing driver is doing it this way though so maybe that's
a refactor for another day.


> +
> +	val = AD3552R_REF_INIT;
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +					&val, 1);
> +	if (err)
> +		return err;
> +
> +	val = AD3552R_TRANSFER_INIT;
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +					&val, 1);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err = ad3552r_get_ref_voltage(st->dev, &val);
> +	if (err)
> +		return err;
> +
> +	err = axi3552r_qspi_update_reg_bits(st->back,
> +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				val, 1);
> +	if (err)
> +		return err;
> +
> +	err = ad3552r_get_drive_strength(st->dev, &val);
> +	if (!err) {
> +		err = axi3552r_qspi_update_reg_bits(st->back,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> +					val, 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	child = device_get_named_child_node(st->dev, "channel");
> +	if (!child)
> +		return -EINVAL;
> +
> +	err = ad3552r_get_output_range(st->dev, st->chip_id, child, &range);
> +	if (!err)
> +		return ad3552r_axi_set_output_range(st, range);
> +
> +	if (err != -ENOENT)
> +		return err;
> +
> +	/* Try to get custom range */
> +	err = ad3552r_get_custom_gain(st->dev, child,
> +					&gs_p, &gs_n, &rfb, &goffs);
> +	if (err)
> +		return err;
> +
> +	ad3552r_calc_custom_gain(gs_p, gs_n, goffs, &reg);
> +
> +	offset = abs((s32)goffs);
> +
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_OFFSET(0),
> +					&offset, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_OFFSET(1),
> +					&offset, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_GAIN(0),
> +					&reg, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	err = iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_GAIN(1),
> +					&reg, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad3552r_axi_buffer_setup_ops = {
> +	.postenable = ad3552r_axi_buffer_postenable,
> +	.predisable = ad3552r_axi_buffer_predisable,
> +};

> +
> +static const char *const synchronous_mode_status[] = {
> +	[AD3552R_NO_SYNC] = "no_sync",
> +	[AD3552R_EXT_SYNC_ARM] = "ext_sync_arm",

I'll comment on this in the ABI docs patch.

> +};
> +
> +static const struct iio_enum ad3552r_synchronous_mode_enum = {
> +	.items = synchronous_mode_status,
> +	.num_items = ARRAY_SIZE(synchronous_mode_status),
> +	.get = ad3552r_get_synchronous_mode_status,
> +	.set = ad3552r_set_synchronous_mode_status,
> +};
> +
> +static const struct iio_chan_spec_ext_info ad3552r_axi_ext_info[] = {
> +	IIO_ENUM("synchronous_mode", IIO_SHARED_BY_TYPE,
> +		 &ad3552r_synchronous_mode_enum),
> +	IIO_ENUM_AVAILABLE("synchronous_mode", IIO_SHARED_BY_TYPE,
> +			   &ad3552r_synchronous_mode_enum),
> +	{},
	{ }

I'm not blanket fixing this case yet (unlikely the ID ones) but
generally it's nice to not have a comma after a 'null' terminator
entry as adding anything after it would be a bug.



> +};
> +
> +#define AD3552R_CHANNEL(ch) { \
> +	.type = IIO_VOLTAGE, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all = (((ch) == 0) ? \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0), \

If it's shared by all it should be set for all.
The core code will only create one attr as a result.

Technically it's not a 'bug' to not do this but the semantics
are wrong if you set something that is for all channels on only
one of them, so if there are other drivers doing this that I've
missed we should clean that up.


> +	.output = 1, \
> +	.indexed = 1, \
> +	.channel = (ch), \
> +	.scan_index = (ch), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.shift = 0, \

Zero shift is the 'obvious' default, so need to specify it in this
case.

> +		.endianness = IIO_BE, \
> +	}, \
> +	.ext_info = ad3552r_axi_ext_info, \
> +}

> +
> +static const struct of_device_id ad3552r_axi_of_id[] = {
> +	{ .compatible = "adi,ad3552r" },
> +	{}

Trivial, but I'm trying to standardize formats of these in IIO on 
	{ }
> +};

> +MODULE_DEVICE_TABLE(of, ad3552r_axi_of_id);

