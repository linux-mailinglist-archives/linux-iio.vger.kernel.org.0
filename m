Return-Path: <linux-iio+bounces-20046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58357AC9400
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1993C16A3B4
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90723506E;
	Fri, 30 May 2025 16:54:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AE1A3164;
	Fri, 30 May 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624040; cv=none; b=I16D+CiR8px2NNKk+Ytt43ajUZiy7JitWQSHVHG3g486AwXMATo4ApSTyJItU7XNjKzisyJIZOaatHbuotaWWj2tma4yZraVHkhC3+RJuyDEMQ6NRnUilA9YVMEJiypMswnOM6KjmoPVPODMWN9ntS6Qhm05Y7OXq/kHYBn1+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624040; c=relaxed/simple;
	bh=lQYiABD8QOgU7w6ch1dLEC4Wn6UzkdJASAgg416P15w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcKXrRn9+K1Dx3TQX3U+2JAqXAaeDqEE1iVTt7zOFU52Gl/GqgP3RCuBdoumTzN3wj5YVrgbSPNyCXYLBY3tErfz7WkllEG0EHCNKSNMhzgkHYqNYjPIJ//46n2phn+e5sqne+L7WFDjBmZn3gdxuY5pWPVptYLFzrRnczgApVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b88P14JpXz67LX2;
	Sat, 31 May 2025 00:50:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0243E140557;
	Sat, 31 May 2025 00:53:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 18:53:53 +0200
Date: Fri, 30 May 2025 17:53:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <victor.duicu@microchip.com>
CC: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marius.cristea@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250530175351.000039cb@huawei.com>
In-Reply-To: <20250529093628.15042-3-victor.duicu@microchip.com>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
	<20250529093628.15042-3-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 29 May 2025 12:36:28 +0300
victor.duicu@microchip.com wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Hi Victor,

As often the case, the questions are mostly about the custom ABI.

Jonathan

> ---
>  .../testing/sysfs-bus-iio-temperature-mcp9982 |  27 +
>  MAINTAINERS                                   |   7 +
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/mcp9982.c             | 866 ++++++++++++++++++
>  5 files changed, 911 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
>  create mode 100644 drivers/iio/temperature/mcp9982.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
> new file mode 100644
> index 000000000000..c55e106e5863
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
> @@ -0,0 +1,27 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/enable_extended_temp_range
> +KernelVersion:	6.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute enables extended range of temperatures.
> +		Value 1 uses the extended range, value 0 uses the default range.

As mentioned below, if this corresponds to -64 as the offset, can we expose
it as in_voltage_offset or similar?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_beta1
> +KernelVersion:	6.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute controls the value of beta correction
> +		for channel 1.

Is this something that we'd normally expect to manually update? What is
it a characteristic of?  If it is expected to the be related to the
diodes attached, that's a problem for firmware/dt, not sysfs interfaces.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_beta2
> +KernelVersion:	6.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute controls the value of beta correction
> +		for channel 2.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_beta_available
> +KernelVersion:	6.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute displays the values that can be
> +		set for beta correction.

Definitely mention the automode in these docs.




> diff --git a/drivers/iio/temperature/mcp9982.c b/drivers/iio/temperature/mcp9982.c
> new file mode 100644
> index 000000000000..89e966beffe6
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9982.c
> @@ -0,0 +1,866 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Victor Duicu <victor.duicu@microchip.com>
> + *
> + * Datasheet can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/irq.h>

Check if these are all needed.  This one doesn't seem to be...

> +#include <linux/limits.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

> +
> +static const struct regmap_config mcp9982_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &mcp9982_regmap_rd_table,
> +	.wr_table = &mcp9982_regmap_wr_table,
> +	.volatile_reg	= mcp9982_is_volatile_reg,
I'd use single space before =
Forcing alignment goes wrong far too often and doesn't really help with readability.

> +};

> +static int mcp9982_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret, index, index2;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(priv->regmap, MCP9982_INT_VALUE_ADDR(chan->channel), val);
> +		if (ret)
> +			return ret;
> +
> +		/* The extended temperature range is offset by 64 degrees C */
> +		if (priv->extended_temp_range)
> +			*val -= 64;

As that's the case, can we control this simply via standard ABI of IIO_CHAN_INFO_OFFSET and
provide the available as well.  It is a little non obvious, but has the advantage of providing
the control you want with out the need for custom ABI.


> +
> +		ret = regmap_read(priv->regmap, MCP9982_FRAC_VALUE_ADDR(chan->channel), val2);
> +		if (ret)
> +			return ret;
> +
> +		/* Only the 3 MSB in low byte registers are used */
> +		*val2 = mcp9982_fractional_values[*val2 >> 5];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = mcp9982_conv_rate[priv->sampl_idx][0];
> +		*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +
> +		ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &index2);
> +		if (ret)
> +			return ret;
> +
> +		if (index2 >= 2)
> +			index2 -= 1;
> +		*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][index2][0];
> +		*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][index2][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		ret = regmap_read(priv->regmap, MCP9982_HYS_ADDR, &index);
> +		if (ret)
> +			return ret;
> +
> +		*val = index;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	guard(mutex)(&priv->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
> +			if (val == mcp9982_conv_rate[i][0] && val2 == mcp9982_conv_rate[i][1])
> +				break;
> +
> +		if (i >= ARRAY_SIZE(mcp9982_conv_rate))

It won't be greater than so == is appropriate.

> +			return -EINVAL;
> +
> +		ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +		if (ret)
> +			return ret;
> +
> +		priv->sampl_idx = i;
> +		return 0;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i = 0; i < ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]); i++)
> +			if (val == mcp9982_3db_values_map_tbl[priv->sampl_idx][i][0] &&
> +			    val2 == mcp9982_3db_values_map_tbl[priv->sampl_idx][i][1])
> +				break;
> +
> +		if (i >= ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]))
As above.

> +			return -EINVAL;
> +
> +		/*
> +		 * Filter register is coded with values:
> +		 *-0 for OFF
> +		 *-1 or 2 for level 1
> +		 *-3 for level 2
> +		 */
> +		if (i == 2)
> +			i = 3;
> +		ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, i);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +
> +		ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, val);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static ssize_t mcp9982_extended_temp_range_store(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	ret = kstrtouint(buf, 10, &val);

If you end up keeping this we have kstrtobool which tends to be more flexible
for an on/off parameter.

> +	if (ret)
> +		return -EINVAL;
> +
> +	switch (val) {
> +	case 0:
> +		priv->extended_temp_range = false;
> +		break;
> +	case 1:
> +		priv->extended_temp_range = true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&priv->lock);
> +	ret = regmap_assign_bits(priv->regmap, MCP9982_CFG_ADDR, MCP9982_CFG_RANGE,
> +				 priv->extended_temp_range);
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t mcp9982_show_beta(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int val, ret;
> +
> +	/* When APDD is enabled, betas are locked to autodetection */
> +	if (priv->apdd_enable)
> +		return sysfs_emit(buf, "Auto\n");
> +
> +	ret = regmap_read(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this_attr->address), &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val < 15)
> +		return sysfs_emit(buf, "%s\n", mcp9982_beta_values[val]);
> +
> +	if (val == 15)
> +		return sysfs_emit(buf, "Diode_Mode\n");
> +	else
> +		return sysfs_emit(buf, "Auto\n");
> +}
> +
> +static ssize_t mcp9982_store_beta(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int i;
> +
> +	/* When APDD is enabled, betas are locked to autodetection */
> +	if (priv->apdd_enable)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(mcp9982_beta_values); i++)
> +		if (strncmp(buf, mcp9982_beta_values[i], 5) == 0)
> +			break;
> +
> +	if (i < ARRAY_SIZE(mcp9982_beta_values)) {
> +		regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this_attr->address), i);
> +		return count;
> +	}
> +
> +	if (strncmp(buf, "Diode_Mode", 10) == 0) {
> +		regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this_attr->address), 15);
> +		return count;
> +	}

This interface is non obvious. Add a full description to the ABI docs.

> +
> +	if (strncmp(buf, "Auto", 4) == 0) {
> +		regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this_attr->address), BIT(4));
> +		return count;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mcp9982_beta_available_show(struct device *dev,
> +					   struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +
> +	for (i = 0; i < 15; i++) {
> +		strcat(buf, mcp9982_beta_values[i]);
> +		strcat(buf, " ");
> +	}
> +	strcat(buf, "Diode_Mode Auto\n");

As above. What is this?

> +	return sysfs_emit(buf, buf);
> +}

> +
> +static int mcp9982_parse_of_config(struct iio_dev *indio_dev, struct device *dev,
> +				   int device_nr_channels)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int reg_nr, iio_idx;
> +
> +	/* APDD, RECD12 and RECD34 are active on 0 */
> +	if (device_property_read_bool(dev, "microchip,apdd-state"))
> +		priv->apdd_enable = true;
> +	else
> +		priv->apdd_enable = false;

	priv->appd_enable = device_property_read_bool();

> +
> +	if (device_property_read_bool(dev, "microchip,recd12"))
> +		priv->recd12_enable = true;
> +	else
> +		priv->recd12_enable = false;
> +
> +	if (device_property_read_bool(dev, "microchip,recd34"))
> +		priv->recd34_enable = true;
> +	else
> +		priv->recd34_enable = false;
> +
> +	priv->num_channels = device_get_child_node_count(dev) + 1;
> +
> +	if (priv->num_channels > device_nr_channels)
> +		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
> +
> +	priv->iio_chan = devm_kcalloc(dev, priv->num_channels, sizeof(*priv->iio_chan), GFP_KERNEL);
> +	if (!priv->iio_chan)
> +		return -ENOMEM;
> +
> +	priv->iio_chan[0] = (struct iio_chan_spec)MCP9982_CHAN(0, 0, MCP9982_INT_VALUE_ADDR(0));

as below.

> +
> +	priv->labels[0] = "internal diode";
> +	iio_idx++;
> +	device_for_each_child_node_scoped(dev, child) {
> +		fwnode_property_read_u32(child, "reg", &reg_nr);
> +		if (!reg_nr || reg_nr >= device_nr_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "The index of the channels does not match the chip\n");
> +
> +		if (fwnode_property_present(child, "microchip,ideality-factor")) {
> +			fwnode_property_read_u32(child, "microchip,ideality-factor",
> +						 &priv->ideality_value[reg_nr - 1]);
> +			if (priv->ideality_value[reg_nr - 1] > 63)
> +				return dev_err_probe(dev, -EINVAL,
> +				     "The ideality value is higher than maximum\n");
> +		} else {
> +			/* Set default value */
> +			priv->ideality_value[reg_nr - 1] = 18;
> +		}

Set default and rely on no side effects if the read fails + that default must
be a valid choice.

		priv->ideality_value[reg_nr - 1] = 18;
		fwnode_property_read_u32(child, "microchip,ideality-factor",
					 &priv->ideality_value[reg_nr - 1]);
		if (priv->ideality_vavlue[reg_nr - 1] > 63)
			return dev_err_probe();

> +
> +		fwnode_property_read_string(child, "label",
> +					    (const char **)&priv->labels[reg_nr]);

I'm curious why that cast is needed. Should the string in the priv be const?
Do we perhaps have an issue with that elsewhere?

> +
> +		priv->iio_chan[iio_idx++] = (struct iio_chan_spec)MCP9982_CHAN(reg_nr, reg_nr,
> +							 MCP9982_INT_VALUE_ADDR(reg_nr));

Seems very likely that the (struct iio_chan_spec) should be in the macro definition.

> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9982_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct mcp9982_priv *priv;
> +	struct iio_dev *indio_dev;
> +	const struct mcp9982_features *chip;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Is this used? If not don't set it.

> +
> +	priv->regmap = devm_regmap_init_i2c(client, &mcp9982_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Cannot initialize register map\n");
> +
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return ret;
> +
> +	chip = i2c_get_match_data(client);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	ret = mcp9982_parse_of_config(indio_dev, &client->dev, chip->phys_channels);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Parameter parsing error\n");
> +
> +	ret = mcp9982_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize device\n");
> +
> +	indio_dev->name = chip->name;
> +	indio_dev->info = &mcp9982_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = priv->iio_chan;
> +	indio_dev->num_channels = priv->num_channels;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
> +
> +	mcp9982_calc_all_3db_values();

Seems likely you want to do this before exposing the sysfs interfaces?
If not blank line before this return.

> +	return 0;
> +}



