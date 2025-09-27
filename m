Return-Path: <linux-iio+bounces-24503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC0BA622D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 19:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2A94A3A35
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB476225A29;
	Sat, 27 Sep 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZXXspY8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6222172D;
	Sat, 27 Sep 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758995614; cv=none; b=QDkh3tLy9M2gT+GQLsaI044+vgF2fEivufY26o96zKvlEVVSCBUQASWvCK8Ay8kkaXakrjFL+OKYABdInEDEUzYb5+eXWyZvQvsqGnsVQVXkjJI/H/l2/i6WVS3uuqTqcPZ270RCwx6EiS53tHrhjzYuHpAwDwNgEddZSip1Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758995614; c=relaxed/simple;
	bh=HL01py7no+tna4rKxPxIVjcCt1GA9gb9Uon2uY898HY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2Qz30pAG/DZmtvVY1MWdl1y3CWo4s8DZFLd5LTsNgnY1BUWs6ImBhqLejRT+eVUUeGn0UHbPup6AhjTD4p0YCevh6cqGc0lzn6B7SR3x+6oqu2z6hno/OB+miuKg8/kUYoSwH5PDFR64bdPCVaVotKHDyBSkW8wf+x3rjb1Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZXXspY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181BDC4CEE7;
	Sat, 27 Sep 2025 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758995613;
	bh=HL01py7no+tna4rKxPxIVjcCt1GA9gb9Uon2uY898HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZXXspY8NtIQwN76IYffAa4AGialPAvsowwa+Uc9G/6U4hsl0v1RDhHRRXPjkJ7EV
	 +HBJXnRo/oZKMTEgtTMUgv9PV7/dWpnpPrRw8Nq3Q2K/Qgt2vE1JNWZUuQjWoBdS26
	 VnAZrmZxe6WUMjUbvq5vA2QWUwX1H2/NDSH2AiHesKM1tMfxSpkMFyG9DGGL35l/qs
	 wMZ0QHSy7h16TBST4lM3iYrYoJfUiuNvxA42jLydmGpanZY+XAlhlNzBL2KqOaOjAR
	 E8Pbz7XyDjYTfh8trTxFanLItkFSEVLXQ/qMC5kFD6d4SN2/fyk1r2D9Zcvpdr25NE
	 X8pVe/5DEaZVg==
Date: Sat, 27 Sep 2025 18:53:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <20250927185324.2f9e8061@jic23-huawei>
In-Reply-To: <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
	<20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 14:30:54 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2,
> MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage output
> Digital-to-Analog Converters with nonvolatile or volatile memory and an I2C
> Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

Main feedback here is probably the stuff around the unusual regmap handling.
If you need to set extra bits for reads over writes, then regmap provides
the means to do that. If it is more custom than I'm understanding then use
a custom regmap so that you can pass the actual register addresses rather than some
composite of several things as the address.

> ---
...


> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c9c2ded78d9c6013e5618e6342ebc8f50e79a31e
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -0,0 +1,1347 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + * Datasheet for MCP47FEBXX can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
> + *
> + * Datasheet for MCP47FVBXX can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
> + *
> + * Datasheet for MCP47FXBX4/8 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
> + */
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

> +
> +/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
> +#define CH_0					GENMASK(1, 0)

Prefix with something driver specific as these are too brief and hence
high risk of clash with something in a header in future.

> +#define CH_1					GENMASK(3, 2)
> +#define CH_2					GENMASK(5, 4)
> +#define CH_3					GENMASK(7, 6)
> +#define CH_4					GENMASK(9, 8)
> +#define CH_5					GENMASK(11, 10)
> +#define CH_6					GENMASK(13, 12)
> +#define CH_7					GENMASK(15, 14)
> +
> +/* Gain Control and I2C Slave Address Reguster fields */
> +#define G_0					BIT(8)
> +#define G_1					BIT(9)
> +#define G_2					BIT(10)
> +#define G_3					BIT(11)
> +#define G_4					BIT(12)
> +#define G_5					BIT(13)
> +#define G_6					BIT(14)
> +#define G_7					BIT(15)
> +
> +#define MCP47FEB02_GAIN_STATUS_EEWA_MASK	BIT(6)
> +#define MCP47FEB02_VOLATILE_GAIN_MASK		GENMASK(15, 8)
> +#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK	GENMASK(7, 0)
> +#define MCP47FEB02_WIPERLOCK_STATUS_MASK	GENMASK(15, 0)
> +#define CMD_MEM_ADDR_MASK			GENMASK(7, 3)
> +
> +#define CMD_FORMAT(reg, cmd)			(FIELD_PREP(CMD_MEM_ADDR_MASK, (reg)) | (cmd))
> +#define READ_CMD				0x06
> +#define WRITE_CMD				0x00

regmap has the ability to set extra bits for reads over writes. Use that and I think
you shouldn't need to pass READ_CMD to every read and WRITE_CMD to every write.

readflag_mask = 0x6 perhaps does the job.


> +#define READ_OP(ch)				(((ch) << 3) | READ_CMD)
> +#define WRITE_OP(ch)				((ch) << 3)

> +
> +static const struct regmap_range mcp47feb02_readable_ranges[] = {
> +	regmap_reg_range(READ_OP(MCP47FEB02_DAC0_REG_ADDR),
> +			 READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
> +	regmap_reg_range(READ_OP(MCP47FEB02_NV_DAC0_REG_ADDR),
> +			 READ_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR)),

I might be wrong but that READ_OP looks like you are messing with the addresses
rather than handling a protocol that requires setting some flags to indicate
a read.

I'm not sure how this works with the regcache which would expect reads and
writes to end up at the same address.

> +};
> +
> +static const struct regmap_range mcp47feb02_writable_ranges[] = {
> +	regmap_reg_range(WRITE_OP(MCP47FEB02_DAC0_REG_ADDR),
> +			 WRITE_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
> +	regmap_reg_range(WRITE_OP(MCP47FEB02_NV_DAC0_REG_ADDR),
> +			 WRITE_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR)),
> +};

> +
> +static const struct regmap_config mcp47fvb02_regmap_config = {
> +	.name = "mcp47fvb02_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.rd_table = &mcp47fvb02_readable_table,
> +	.wr_table = &mcp47fvb02_writable_table,
> +	.volatile_table = &mcp47fvb02_volatile_table,
> +	.max_register = READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
> +	.cache_type = REGCACHE_RBTREE,

use MAPLE for all new code.

> +};
> +
> +static int mcp47feb02_write_to_register(struct regmap *regmap, unsigned int reg,
> +					int channel, int tmp_val)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read(regmap, CMD_FORMAT(reg, READ_CMD), &val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg == MCP47FEB02_GAIN_STATUS_REG_ADDR) {
> +		switch (channel) {
> +		case 0:
> +			FIELD_MODIFY(G_0, &val, tmp_val);
> +			break;
> +		case 1:
> +			FIELD_MODIFY(G_1, &val, tmp_val);
> +			break;
> +		case 2:
> +			FIELD_MODIFY(G_2, &val, tmp_val);
> +			break;
> +		case 3:
> +			FIELD_MODIFY(G_3, &val, tmp_val);
> +			break;
> +		case 4:
> +			FIELD_MODIFY(G_4, &val, tmp_val);
> +			break;
> +		case 5:
> +			FIELD_MODIFY(G_5, &val, tmp_val);
> +			break;
> +		case 6:
> +			FIELD_MODIFY(G_6, &val, tmp_val);
> +			break;
> +		case 7:
> +			FIELD_MODIFY(G_7, &val, tmp_val);
> +			break;
> +		default:
Why default sensible here? Add a comment.
> +			FIELD_MODIFY(G_0, &val, tmp_val);
> +			break;
> +		}
> +	} else {
> +		switch (channel) {
> +		case 0:
> +			FIELD_MODIFY(CH_0, &val, tmp_val);

Sometimes FIELD_MODIFY() and friends are too complex when
we are dealing with a bunch of identical sized fields in a register.
I'd just code the bit shifts directly.

> +			break;
> +		case 1:
> +			FIELD_MODIFY(CH_1, &val, tmp_val);
> +			break;
> +		case 2:
> +			FIELD_MODIFY(CH_2, &val, tmp_val);
> +			break;
> +		case 3:
> +			FIELD_MODIFY(CH_3, &val, tmp_val);
> +			break;
> +		case 4:
> +			FIELD_MODIFY(CH_4, &val, tmp_val);
> +			break;
> +		case 5:
> +			FIELD_MODIFY(CH_5, &val, tmp_val);
> +			break;
> +		case 6:
> +			FIELD_MODIFY(CH_6, &val, tmp_val);
> +			break;
> +		case 7:
> +			FIELD_MODIFY(CH_7, &val, tmp_val);
> +			break;
> +		default:
> +			FIELD_MODIFY(CH_0, &val, tmp_val);
Likewise - add comment on when default applies.
> +			break;
> +		}
> +	}
> +
> +	ret = regmap_write(regmap, CMD_FORMAT(reg, WRITE_CMD), val);
> +
> +	return ret;
> +}
> +
> +static int mcp47feb02_write_to_eeprom(struct regmap *regmap, unsigned int reg,
> +				      unsigned int val)
> +{
> +	int eewa_val, ret;
> +
> +	/*
> +	 * wait till the currently occurring EEPROM Write Cycle is completed.
Wait

> +	 * Only serial commands to the volatile memory are allowed.
> +	 */
> +	ret = regmap_read_poll_timeout(regmap,
> +				       CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
> +				       eewa_val, !(eewa_val & MCP47FEB02_GAIN_STATUS_EEWA_MASK),
> +				       MCP47FEB02_DELAY_1_MS, MCP47FEB02_DELAY_1_MS * 5);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, CMD_FORMAT(reg, WRITE_CMD), val);
> +
> +	return ret;
return regmap_write()
Check for other simple cases like this.

> +}
> +
> +static ssize_t mcp47feb02_store_eeprom(struct device *dev, struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct mcp47feb02_data *data = iio_priv(dev_to_iio_dev(dev));
> +	int ret, i, val, val1;
> +	bool state;
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!state)
> +		return 0;
> +
> +	if (!data->have_eeprom) {

I assume the attribute doesn't exist so this is just paranoid checking?
If so add a comment that you shouldn't be able to get here.

> +		dev_err(dev, "Device has no eeprom memory.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Verify DAC Wiper and DAC Configuratioin are unlocked. If both are disabled,
> +	 * writing to EEPROM is available.
> +	 */
> +	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, READ_CMD),

Wrap shorter to keep nearer to 80 chars where it doesn't hurt readability

> +			  &val);
...

> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom, 0);
> +static struct attribute *mcp47feb02_attributes[] = {
> +	&iio_dev_attr_store_eeprom.dev_attr.attr,
> +	NULL,

No comma on a null terminator as we don't want to be able to add stuff after it.

> +};

> +static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
> +
> +static const struct attribute_group mcp47feb02_attribute_group = {
> +	.attrs = mcp47feb02_attributes,
I'd push this near the attribute definition rather than after the PM stuff.

> +};

> +
> +static int mcp47feb02_set_powerdown_mode(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan, unsigned int mode)
> +{
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	int bit_set, ret;
> +
> +	bit_set = test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set) {
> +		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> +						   chan->address, mode + 1);
> +		if (ret)
> +			return ret;
> +
> +		data->chdata[chan->address].powerdown_mode = mode;
> +
> +		return 0;
> +	}
> +
> +	dev_err(dev, "Channel %ld not enabled\n", chan->address);
> +	return -EINVAL;
> +}
> +
> +static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
> +					 const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	int bit_set;
> +
> +	bit_set = test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set)
> +		return sysfs_emit(buf, "%d\n", data->chdata[chan->address].powerdown);
> +
> +	dev_err(&data->client->dev, "Channel %ld not enabled\n", chan->address);

As below. I think this should be impossible in which case no need for the error message.
or the sanity check against active_channels_mask.  Same for all other cases above.


> +	return -EINVAL;
> +}
> +
> +static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
> +					  const struct iio_chan_spec *chan, const char *buf,
> +					  size_t len)
> +{
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	int bit_set, ret;
> +	bool state;
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret)
> +		return ret;
> +
> +	bit_set = test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set)
> +		data->chdata[chan->address].powerdown = state;
> +	else
> +		dev_err(dev, "Channel %ld not enabled\n", chan->address);

If it's an error return an error code. Can we actually get here?
If we have a powerdown per channel, and the channel isn't there, how is this
called?

 

> +
> +	return len;
> +}

> +
> +static const struct iio_chan_spec_ext_info mcp47feb02_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = mcp47feb02_read_powerdown,
> +		.write = mcp47feb02_write_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp47febxx_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &mcp47febxx_powerdown_mode_enum),
> +	{ },

Trivial but no trailing comma for 'terminating' entrees like this one.

> +};


> +static int mcp47feb02_parse_fw(struct iio_dev *indio_dev, const struct mcp47feb02_features *info)
> +{
> +	struct iio_chan_spec chanspec = mcp47febxx_ch_template;
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	struct iio_chan_spec *channels;
> +	u32 reg, num_channels;
> +	int chan_idx = 0;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > info->phys_channels)
> +		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		fwnode_property_read_u32(child, "reg", &reg);

Check that for error return. otherwise you just get garbage in reg.
Probably want to initialize reg to 0 before calling this anyway to ensure its a consistent
value if this fails for some reason.

> +
> +		if (reg >= info->phys_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "The index of the channels does not match the chip\n");
> +
> +		set_bit(reg, &data->active_channels_mask);
> +
> +		if (fwnode_property_present(child, "label"))
> +			fwnode_property_read_string(child, "label",
> +						    (const char **)&data->labels[reg]);
> +
> +		chanspec.address = reg;
> +		chanspec.channel = reg;
> +		channels[chan_idx] = chanspec;
> +		chan_idx++;
> +	}
> +
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->channels = channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	data->phys_channels = info->phys_channels;
> +
> +	/*
> +	 * check if vref-supply, vref1-supply, microchip,vref-buffered and
> +	 * microchip,vref1-buffered are defined in the devicetree
> +	 */
> +	data->use_vref = device_property_present(dev, "vref-supply");
> +	data->use_vref1 = device_property_present(dev, "vref1-supply");

Just try and get them and handle the regulator errors to discover if they aren't there.
However, not all chips have both of these?  If not then you should have that info in the
chip type specific structures and not try to query them at all if not relevant.

> +	data->vref_buffered = device_property_read_bool(dev, "microchip,vref-buffered");
> +	data->vref1_buffered = device_property_read_bool(dev, "microchip,vref1-buffered");
> +
> +	return 0;
> +}
> +
> +static int mcp47feb02_probe(struct i2c_client *client)
> +{
> +	int err, ret, vdd_mv, vref_mv, vref1_mv, i, tmp_vref, vref_ch, gain_ch;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct mcp47feb02_features *info;
> +	enum vref_mode ref_mode, ref_mode1;
> +	struct device *dev = &client->dev;
> +	struct mcp47feb02_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	info = i2c_get_match_data(client);
> +
> +	if (info->have_eeprom) {
> +		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
> +		data->have_eeprom = true;

I'd be tempted to stash a const pointer to info inside data.  Then you have ready
access to the chip specific stuff without leading code to copy things over.

> +	} else {
> +		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
> +		data->have_eeprom = false;
> +	}
> +
> +	if (IS_ERR(data->regmap))
> +		dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
> +
> +	err = mcp47feb02_parse_fw(indio_dev, info);
> +	if (err)
> +		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
> +
> +	if (!info->have_ext_vref2 && data->use_vref1)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Second External reference is unavailable on %s\n",
> +				     info->name);
> +
> +	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_VREF_REG_ADDR, READ_CMD), &vref_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
> +			  &gain_ch);
> +	if (ret)
> +		return ret;
> +
> +	gain_ch = gain_ch >> 8;
> +
> +	/*
> +	 * Values stored in the nonvolatile memory will be transferred to the volatile registers
> +	 * at startup. For safety reasons, the user receives a warning if startup values
> +	 * do not match the ones from current devicetree configuration.
> +	 * Nonvolatile memory can be written at any time
> +	 */
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		/* VDD can be set as Vref only with Gain x1 */
> +		if ((vref_ch & 0x03) == MCP47FEB02_VREF_VDD &&
> +		    (gain_ch & 0x01) == MCP47FEB02_GAIN_X2) {
> +			dev_info(dev, "vdd can be used only with gain x1\n");
> +			ret = mcp47feb02_write_to_register(data->regmap,
> +							   MCP47FEB02_GAIN_STATUS_REG_ADDR,
> +							   i, MCP47FEB02_GAIN_X1);
> +			if (ret)
> +				return ret;
> +
> +			data->chdata[i].use_2x_gain = MCP47FEB02_GAIN_X1;
> +		}
> +
> +		if (data->phys_channels >= 4 && (i % 2)) {
> +			if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_BUFFERED &&
> +			    data->use_vref1 && !data->vref1_buffered)
> +				dev_info(dev, "vref1 is unbuffered\n");
This doesn't sound like an error.   I'd state that vref1 from eeprom is unbuffered but not from firmware
or something like that.
> +			else if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
> +				 data->use_vref1 && data->vref1_buffered)
> +				dev_info(dev, "vref1 is buffered\n");
> +		} else {
> +			if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_BUFFERED &&
> +			    data->use_vref && !data->vref_buffered)
> +				dev_info(dev, "vref is unbuffered\n");
> +			else if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
> +				 data->use_vref && data->vref_buffered)
> +				dev_info(dev, "vref is buffered\n");
> +		}
> +
> +		vref_ch = vref_ch >> 2;
> +		gain_ch = gain_ch >> 1;
> +	}
> +
> +	if (data->use_vref)
Can we combine all the stuff about a given reference in one place.  Probably means dragging
the enabling and voltage measurement up here.

> +		ref_mode = data->vref_buffered ?
> +			MCP47FEB02_EXTERNAL_VREF_BUFFERED : MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
> +	else
> +		ref_mode = MCP47FEB02_INTERNAL_BAND_GAP;
> +
> +	if (data->use_vref1)
> +		ref_mode1 = data->vref1_buffered ?
> +			MCP47FEB02_EXTERNAL_VREF_BUFFERED : MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
> +
> +	else
> +		ref_mode1 =  MCP47FEB02_INTERNAL_BAND_GAP;
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		if (data->phys_channels >= 4 && (i % 2))
> +			tmp_vref = ref_mode1;
> +		else
> +			tmp_vref = ref_mode;
> +
> +		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_VREF_REG_ADDR,
> +						   i, tmp_vref);
> +		if (ret)
> +			return ret;
> +
> +		data->chdata[i].ref_mode = tmp_vref;
> +	}
> +
> +	indio_dev->name = id->name;
> +	if (info->have_eeprom)
> +		indio_dev->info = &mcp47feb02_info;
> +	else
> +		indio_dev->info = &mcp47fvb02_info;

Seems no harm in moving this to where you set the other have_eeprom specific stuff.

> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return ret;
> +
> +	vdd_mv = ret / 1000;
> +
> +	if (data->use_vref) {

As above. I would expect to see a check here on whether the chip has the relevant
pins (I guess they don't all have two vref?) rather than property presence
which is well handled by checking for -ENODEV (I think - check that error code)

or is this some risk in turning these on before buffers are enabled? In many boards
I'd expect the reference will be hard wired on anyway.

> +		ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +		if (ret < 0)
> +			return ret;
> +
> +		vref_mv = ret / 1000;
> +	}
> +
> +	if (data->use_vref1) {
> +		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> +		if (ret < 0)
> +			return ret;
> +
> +		vref1_mv = ret / 1000;
> +	}
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		ret = mcp47feb02_init_scales_avail(info, data, vdd_mv, vref_mv, vref1_mv);

Fix the issue Dan found here with uninitialized values.

> +		if (ret)
> +			dev_err_probe(dev, ret, "failed to init scales for ch i %d\n", i);

		If it fails. error out.  Or dev_err() isn't appropriate.


> +	}
> +
> +	err = iio_device_register(indio_dev);
> +
> +	return err;

	return devm_iio_device_register()

> +}
> +
> +static void mcp47feb02_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
I think someone else covered this, but if nothing else in remove, you
should just use devm_iio_device_register() and let devm magic do all
your remove path.

> +}

