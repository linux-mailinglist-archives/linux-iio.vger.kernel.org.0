Return-Path: <linux-iio+bounces-28001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE363D3B65C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D9E3021EEC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353538F259;
	Mon, 19 Jan 2026 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbSaJ0dE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E130C62E;
	Mon, 19 Jan 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849093; cv=none; b=MoHD924C8FA8Y5nxoXdwYM1dWn/FTxv5bKIGi8UmuyZWvUGHa5N0Hdn4dPSZK40rLjBbhShnQ0BRyeC1YYRHEZ2C0cN7qaKiT6GxtZxh4GOAZvCIXzX8rllSxNB33lYbTbLEU+hJMv3MD/Ctts0bA2F8NoZuSGY86GnpRpPELJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849093; c=relaxed/simple;
	bh=1sQZ5r4btg2zp+R5F1aJ5uXFrVXV/uMdn9n6o3cxgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEYz6di7/ER43nvVziWIbKPo5en6B4/6Z2PuPs9AMOoRx7gYqXLIm/OErR/7toCkWcgu6YfRIUR6HGTcu6eZaLcJxxdAWTKXmXC8bEAdHdjmuzJOHkteNvlaSXdf69gNQQ/2yiqFAO3Hu+woRTBg9l9BYnB+cjFXpml2vsn84rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbSaJ0dE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768849091; x=1800385091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1sQZ5r4btg2zp+R5F1aJ5uXFrVXV/uMdn9n6o3cxgZU=;
  b=AbSaJ0dEkO//Yr8xgTu5J+laROLy+Lue95Uplcr4glh3zhHFmoWGAxew
   hqhIoZF1A1fncxDLioM7QH0CSvTxhEMS7oLPFy9K71MhfCOVhcHxmiYMV
   i9z/go1wL1q9oYZ4ccY4R+FnXdE2Tz1+zCXv8Wf/3AJYPaE+OkneA4a72
   /+C/81zoSAIvDBAJvuZw9mXCWsufoir4XA4oV1Cl+rqeMZcAn6VoF0pSt
   7+Mrs38AFG8PzF7w5iZ9bLIRMk9R+4NhoLBRFrE5SFJilgMfK7yJeC0zQ
   JM39d6n3772UgyqIY+Tp/u/Hu9FL3VdkUmmW8G5yTkK0BKxj5rNvJ2CUK
   w==;
X-CSE-ConnectionGUID: wZMOgRdLQDmRuMcHdXezgw==
X-CSE-MsgGUID: 6dhDWszvTNSkqlrdlU6t1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73917582"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73917582"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:58:10 -0800
X-CSE-ConnectionGUID: w2JO+n1zSv+8OHpwmZkv/Q==
X-CSE-MsgGUID: 3WAIPgBATa2Ix2a7fK7F9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210417255"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:58:06 -0800
Date: Mon, 19 Jan 2026 20:58:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: petr.hodina@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: add AMS TCS3400 RGB and RGB-IR color
 sensor driver
Message-ID: <aW5-vJJf7RNLo-Z4@smile.fi.intel.com>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
 <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 06:19:07PM +0100, Petr Hodina via B4 Relay wrote:

> Add support for the AMS TCS3400 I2C color light-to-digital converter.
> The driver supports RGBC and RGB-IR modes, programmable integration
> time, optional interrupt-driven buffered capture, and regulator-based
> power control.

...

> +	tristate "AMS TCS3400 color light-to-digital converter"
> +	depends on I2C

> +	default n

This is already default 'default', remove.

> +	help
> +	  If you say yes here you get support for the AMS TCS3400.
> +	  This sensor can detect ambient light and color (RGB) values.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tcs3400.

...

> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TCS3400 - AMS/TAOS color light sensor with RGBC and RGB-IR channels
> + *
> + * Copyright (c) 2025 Petr Hodina

> + *

Stray blank line.

> + */

...

> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/pm_runtime.h>

Keep this ordered alphabetically and followed IWYU principle. Many are missing.

+ Blank line.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>

Also keep this group ordered.

...

> + +struct tcs3400_data {

Have you run `pahole`?

> +	struct i2c_client *client;


> +	struct mutex lock;
> +	struct regulator *vdd_supply;
> +	u8 atime;
> +	u8 gain;
> +	u8 channel_mode; /* 0x00 or 0x80 */
> +	u16 clear_ir; /* clear when mode=0x00, IR when mode=0x80 */
> +	u16 red;
> +	u16 green;
> +	u16 blue;
> +};

...

> +static const int tcs3400_gains[] = {1, 4, 16, 64};

Put inner spaces into {}.

...

> +static int tcs3400_power_on(struct tcs3400_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;

> +	msleep(20);

So-o long sleeps must be commented. Preferably with a reference
to the respective datasheet section / table / etc.

> +	return 0;
> +}

...

> +static int tcs3400_write_reg(struct tcs3400_data *data, u8 reg, u8 val)
> +{
> +	return i2c_smbus_write_byte_data(data->client, TCS3400_CMD_REG(reg), val);
> +}

Why not a regmap?

...

> +static int tcs3400_read_reg(struct tcs3400_data *data, u8 reg, u8 *val)
> +{

> +	int ret = i2c_smbus_read_byte_data(data->client, TCS3400_CMD_REG(reg));
> +
> +	if (ret < 0)
> +		return ret;

This is unmaintainable way of putting things. Better is to split value
definition and assignment.

	int ret;

	ret = ...
	if (ret ...)
		...

> +	*val = ret;
> +
> +	return 0;
> +}

...

> +static int tcs3400_read_word(struct tcs3400_data *data, u8 reg, u16 *val)
> +{
> +
> +	__le16 buf;
> +	int ret = i2c_smbus_read_i2c_block_data(data->client,
> +						TCS3400_CMD_REG(reg), 2, (u8 *)&buf);
> +	if (ret < 0)
> +		return ret;
> +	*val = le16_to_cpu(buf);
> +	return 0;

A lot of missing blank lines.

> +}
> +static int tcs3400_clear_interrupt(struct tcs3400_data *data)
> +{

> +

And here redundant blank line.

> +	return i2c_smbus_write_byte(data->client, TCS3400_CMD_ALS_INT_CLR);
> +}

...

> +static int tcs3400_read_channels(struct tcs3400_data *data)
> +{
> +
> +	int ret, retries = 20;
> +	u8 status;
> +
> +	do {
> +		ret = tcs3400_read_reg(data, TCS3400_STATUS, &status);
> +		if (ret)
> +			return ret;
> +		if (status & TCS3400_STATUS_AVALID)
> +			break;
> +		usleep_range(5000, 6000);
> +	} while (--retries);
> +	if (!retries) {
> +		dev_warn(&data->client->dev, "Timeout waiting for valid data\n");
> +		return -ETIMEDOUT;
> +	}

This is reinvention of something from iopoll.h.

> +	ret = tcs3400_read_word(data, TCS3400_CDATAL, &data->clear_ir);
> +	if (ret)
> +		return ret;
> +
> +	ret = tcs3400_read_word(data, TCS3400_RDATAL, &data->red);
> +	if (ret)
> +		return ret;
> +
> +	ret = tcs3400_read_word(data, TCS3400_GDATAL, &data->green);
> +	if (ret)
> +		return ret;
> +
> +	ret = tcs3400_read_word(data, TCS3400_BDATAL, &data->blue);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static irqreturn_t tcs3400_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct tcs3400_data *data = iio_priv(indio_dev);
> +	u16 buf[4];
> +	int ret;

> +	mutex_lock(&data->lock);

Use scoped_guard() from cleanup.h...

> +	ret = tcs3400_read_channels(data);
> +	if (!ret) {

...and usual pattern instead.

> +		buf[0] = data->clear_ir;
> +		buf[1] = data->red;
> +		buf[2] = data->green;
> +		buf[3] = data->blue;
> +		iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +						   iio_get_time_ns(indio_dev));
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

I stopped here, please, read other drivers that came into IIO subsystem lately
(last couple of Linux kernel release cycles) for the style that we want to see
in the drivers here.

...

> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),

Use

	struct device *dev = &client->dev;

at the top of the function and reduce the verbosity in all the probe code.

> +				     "Unable to get VDD regulator\n");

...

> +err_power_off:
> +	tcs3400_write_reg(data, TCS3400_ENABLE, 0);
> +	tcs3400_power_off(data);
> +	return ret;

Wrong. This messes up with releasing ordering. How did you test this?

...

> +static void tcs3400_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct tcs3400_data *data = iio_priv(indio_dev);
> +
> +	tcs3400_write_reg(data, TCS3400_ENABLE, 0);
> +	tcs3400_power_off(data);

Properly wrapped into devm this entire function will gone.

> +}

...

> +static const struct of_device_id tcs3400_of_match[] = {
> +	{ .compatible = "ams,tcs3400" },
> +	{ }
> +};

> +

Drop this blank line.

> +MODULE_DEVICE_TABLE(of, tcs3400_of_match);
> +
> +static const struct i2c_device_id tcs3400_id[] = {
> +	{ "tcs3400", 0 },

Drop ', 0' part

> +	{ }
> +};
> +

Drop blank line.

> +MODULE_DEVICE_TABLE(i2c, tcs3400_id);
> +
> +static struct i2c_driver tcs3400_driver = {
> +	.driver = {
> +		.name = TCS3400_DRV_NAME,
> +		.of_match_table = tcs3400_of_match,
> +	},
> +	.probe = tcs3400_probe,
> +	.remove = tcs3400_remove,
> +	.id_table = tcs3400_id,
> +};

> +

Misplaced blank line...

> +module_i2c_driver(tcs3400_driver);

...should be here.

> +MODULE_AUTHOR("Petr Hodina <petr.hodina@protonmail.com>");
> +MODULE_DESCRIPTION("AMS TCS3400 RGB/IR color sensor IIO driver");
> +MODULE_LICENSE("GPL");

-- 
With Best Regards,
Andy Shevchenko



